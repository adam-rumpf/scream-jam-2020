/// @desc Draw tiles around player, or draw map.

// Drawing depends on room type.
if (_level_room() == true)
{
	// Draw tiles around player in a level room

	// Determine offset based on player's intermediate movement
	var dx = 0;
	var dy = 0;
	if ((global.player_dx != 0.0) || (global.player_dy != 0.0))
	{
		dx = global.tile_size*global.tile_scale*(-global.player_dx) + global.tile_size*global.tile_scale*sign(global.player_dx);
		dy = global.tile_size*global.tile_scale*(-global.player_dy) + global.tile_size*global.tile_scale*sign(global.player_dy);
	}

	// Determine spreads of visible and neighborhood tile elevations
	var visible_range, neighborhood_range;
	visible_range = max_visible - min_visible;
	neighborhood_range = max_neighborhood - min_neighborhood;

	// Loop through visible tile list
	var num_visible = ds_map_size(visible_tiles);
	var key = ds_map_find_first(visible_tiles);
	for (var i = 0; i < num_visible; i++)
	{
		// Get current tile
		var tile = visible_tiles[? key];
		
		// Determine whether the tile is the goal
		var finish = false; // whether the current tile is the level's goal
		if ((tile.x == goal[0]) && (tile.y == goal[1]))
			finish = true;
	
		// Get screen coordinates from tile
		var coords = tile.screen_coordinates(dx, dy);
		
		// Determine opacity of tile (depends on internal alpha value and fading near screen edge)
		var alpha = tile.image_alpha*edge_fade(coords[0] - (global.tile_size*global.tile_scale)/2, coords[1] - (global.tile_size*global.tile_scale)/2);
		var tile_alpha = alpha; // separte alpha value to make neighbor tiles slightly transluscent
	
		// Determine shading depending on whether the tile is a neighbor
		var rel; // fraction of way between most extreme visible tiles
		if ((is_neighbor(tile.x, tile.y) == true) && (global.player_dx == 0.0) && (global.player_dy == 0.0) && (global.ending == false))
		{
			// Determine shade based on placement among all neighboring tiles
			if (neighborhood_range > 0)
				rel = _center_pull((tile.elevation - min_neighborhood)/neighborhood_range, 0.125); // pull away from center for contrast
			else
				rel = 0.5;
			var col = make_color_hsv(47, 127, (1-rel)*c_neighborhood_max + rel*c_neighborhood_min);
			
			// Make red and more transluscent to more clearly show fog
			if (tile.fog > 0)
			{
				col = make_color_hsv(23, 127, (1-rel)*c_neighborhood_max + rel*c_neighborhood_min);
				tile_alpha = min(tile_alpha, 0.6);
			}
			
			// Override in case this is the goal tile
			if (finish == true)
				col = c_black;
		}
		else
		{
			// Determine shade based on placement among all visible tiles
			if (visible_range > 0)
				rel = (tile.elevation - min_visible)/visible_range;
			else
				rel = 0.5;
			var col = make_color_hsv(0, 0, (1-rel)*c_visible_max + rel*c_visible_min);
			
			// Override in case this is the goal tile
			if (finish == true)
				col = c_black;
		}
	
		// Draw a background texture, shaded to indicate elevation
		draw_sprite_ext(spr_square, tile.image_index, coords[0], coords[1], tile.image_xscale, tile.image_yscale, tile.image_angle, col, tile_alpha);
	
		// Draw the tile's sprite
		draw_sprite_ext(spr_tile, tile.image_index, coords[0], coords[1], tile.image_xscale, tile.image_yscale, tile.image_angle, c_white, tile_alpha);
	
		// Draw tile outline
		draw_sprite_ext(spr_outline, 0, coords[0], coords[1], tile.image_xscale, tile.image_yscale, 0, c_white, alpha);
		
		// In case of goal, draw goal sprite
		if (finish == true)
		{
			var frames = sprite_get_number(spr_goal);
			var frame = round((0.2*current_time)/room_speed) % frames;
			draw_sprite_ext(spr_goal, frame, coords[0], coords[1], tile.image_xscale, tile.image_yscale, 0, c_white, alpha);
		}
		
		// Handle SA enemy
		if ((_sa_room() == true) && (global.sa_intensity > 0) && (finish == false))
		{
			// Determine whether tile is suboptimal
			if (tile.elevation < global.player_elevation)
				tile.suboptimal = true;
			else
				tile.suboptimal = false;
			
			// Draw fog sprite
			var spr, frames;
			switch global.sa_intensity
			{
				case 1:
					spr = spr_mist_01;
					break;
				case 2:
					spr = spr_mist_02;
					break;
				case 3:
					spr = spr_mist_03;
					break;
			}
			frames = sprite_get_number(spr);
			
			// Determine frame number to vary slightly by tile coordinate
			var multi = 1 + (tile_seed(tile.x, tile.y) % 100)/100;
			var frame = round((0.2*multi*current_time)/room_speed) % frames;
			
			// Draw fog
			draw_sprite_ext(spr, frame, coords[0], coords[1], global.tile_scale, global.tile_scale, 0, c_red, tile.fog);
		}
		
		// Handle TS enemy
		if ((_ts_room() == true) && (tile.stalker > 0) && (finish == false))
		{
			// Get sprites and number of subimages (the two sprites are blended for intensity transitions)
			var spr1, spr2, rel, frames;
			spr1 = tile.tabu_sprite(global.player_x, global.player_y, floor(dts)); // old sprite
			spr2 = tile.tabu_sprite(global.player_x, global.player_y, ceil(dts)); // new sprite
			rel = dts - floor(dts); // fraction of way between old and new sprites
			frames = sprite_get_number(spr1);
			
			// Determine frame number to vary slightly by tile coordinate
			var multi = 1 + (tile_seed(tile.x+50, tile.y+50) % 100)/100;
			var frame = round((0.05*multi*current_time)/room_speed) % frames;
			
			// Draw enemy
			draw_sprite_ext(spr1, frame, coords[0], coords[1], global.tile_scale, global.tile_scale, 0, c_white, (1-rel)*tile.stalker);
			draw_sprite_ext(spr2, frame, coords[0], coords[1], global.tile_scale, global.tile_scale, 0, c_white, rel*tile.stalker);
		}
	
		// Go to next tile
		key = ds_map_find_next(visible_tiles, key);
	}
}
else if (room == rm_menu)
{
	// Draw map on menu screen
	
	// Get array of elevations
	var map, w, h;
	map = map_array();
	h = array_length(map);
	w = array_length(map[0]);
	
	// Find player's location on map
	var player_i, player_j;
	player_i = global.player_x - min_x;
	player_j = global.player_y - min_y;
	
	// Define bounds for the map display box
	var map_min_x, map_min_y, map_max_x, map_max_y, map_center_x, map_center_y, map_rad;
	map_center_x = room_width/4;
	map_center_y = room_height/2 + 16;
	map_rad = 144;
	if (w >= h)
	{
		map_min_x = map_center_x - map_rad;
		map_max_x = map_center_x + map_rad;
		map_min_y = map_center_y - (h/w)*map_rad;
		map_max_y = map_center_y + (h/w)*map_rad;
	}
	else
	{
		map_min_y = map_center_y - map_rad;
		map_max_y = map_center_y + map_rad;
		map_min_x = map_center_x - (w/h)*map_rad;
		map_max_x = map_center_x + (w/h)*map_rad;
	}
	
	// Draw map in corner of screen
	for (var j = 0; j < h; j++)
	{
		for (var i = 0; i < w; i++)
		{
			if (map[j][i] == undefined)
				continue;
			
			// Remap array coordinates to a map box
			var xy1, xy2;
			xy1 = _coordinate_remap(0, 0, w+1, h+1, map_min_x, map_min_y, map_max_x, map_max_y, i, j);
			xy2 = _coordinate_remap(0, 0, w+1, h+1, map_min_x, map_min_y, map_max_x, map_max_y, i+1, j+1);
			
			// Get cell color
			var col;
			if ((i == player_i) && (j == player_j))
				col = c_red; // player's cell is red
			else if (max_explored - min_explored == 0)
				col = make_color_hsv(0, 0, 127);
			else
				col = make_color_hsv(0, 0, 255*(1 - (map[j][i] - min_explored)/(max_explored - min_explored)));
			
			// Draw square
			draw_rectangle_color(xy1[0], xy1[1], xy2[0], xy2[1], col, col, col, col, false);
		}
	}
}
