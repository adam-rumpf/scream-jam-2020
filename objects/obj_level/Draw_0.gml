/// @desc Draw tiles around player, or draw map.

// Drawing depends on room type.
if (_level_room() == true)
{
	// Draw tiles around player in a level room

	// Otherwise determine which tiles to draw (depending on which have been revealed and the player's current position)
	//### The list should be recalculated only when the player moves, since it's a potentially expensive operation.
	//### We should also be able to tell upon movement exactly which tiles will be entering or leaving the visible set.

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
	
		// Get screen coordinates from tile
		var coords = tile.screen_coordinates(dx, dy);
	
		// Determine shading depending on whether the tile is a neighbor (shade higher elevation as if lower)
		var rel; // fraction of way between most extreme visible tiles
		if (is_neighbor(tile.x, tile.y) == true)
		{
			// Determine shade based on placement among all neighboring tiles
			if (neighborhood_range > 0)
				rel = (tile.elevation - min_neighborhood)/neighborhood_range;
			else
				rel = 0.5;
			var col = make_color_hsv(47, 127, (1-rel)*c_neighborhood_max + rel*c_neighborhood_min);
		}
		else
		{
			// Determine shade based on placement among all visible tiles
			if (visible_range > 0)
				rel = (tile.elevation - min_visible)/visible_range;
			else
				rel = 0.5;
			var col = make_color_hsv(0, 0, (1-rel)*c_visible_max + rel*c_visible_min);
		}
	
		// Determine opacity of tile (depends on internal alpha value and fading near screen edge)
		var alpha = tile.image_alpha*edge_fade(coords[0] - (global.tile_size*global.tile_scale)/2, coords[1] - (global.tile_size*global.tile_scale)/2);
	
		// Draw a background texture, shaded to indicate elevation
		//###
		draw_sprite_ext(spr_square, tile.image_index, coords[0], coords[1], tile.image_xscale, tile.image_yscale, tile.image_angle, col, alpha);
	
		// Draw the tile's sprite
		draw_sprite_ext(spr_tile, tile.image_index, coords[0], coords[1], tile.image_xscale, tile.image_yscale, tile.image_angle, c_white, alpha);
	
		// Draw tile outline
		draw_sprite_ext(spr_outline, 0, coords[0], coords[1], tile.image_xscale, tile.image_yscale, 0, c_white, alpha);
	
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
	
	//### Draw map in middle of screen
	for (var j = 0; j < h; j++)
	{
		for (var i = 0; i < w; i++)
		{
			if (map[j][i] == undefined)
				continue;
			
			var x1, x2, y1, y2, s, col;
			s = 4;
			x1 = room_width/2 + s*(w/2 - i);
			x2 = x1 + s;
			y1 = room_height/2 + s*(h/2 - j);
			y2 = y1 + s;
			if (max_explored - min_explored == 0)
				col = make_color_hsv(0, 0, 127);
			else
				col = make_color_hsv(0, 0, 255*(1 - (map[j][i] - min_explored)/(max_explored - min_explored)));
			draw_rectangle_color(x1, y1, x2, y2, col, col, col, col, false);
		}
	}
	
	//###
	//show_message(map);
}
