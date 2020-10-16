/// @desc Draw tiles around player.

// Draw only in level rooms
if (_level_room() == false)
	exit;

// Otherwise determine which tiles to draw (depending on which have been revealed and the player's current position)
//### The list should be recalculated only when the player moves, since it's a potentially expensive operation.
//### We should also be able to tell upon movement exactly which tiles will be entering or leaving the visible set.

// Determine offset based on player's intermediate movement
var dx = 0;
var dy = 0;
if ((global.player_dx != 0.0) || (global.player_dy != 0.0))
{
	dx = global.tile_size*(-global.player_dx) + global.tile_size*sign(global.player_dx);
	dy = global.tile_size*(-global.player_dy) + global.tile_size*sign(global.player_dy);
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
	
	//### Seprate procedure for neighborhood
	
	// Determine shade based on placement among all visible tiles
	var rel; // fraction of way between most extreme visible tiles
	if (visible_range > 0)
		rel = (tile.elevation - min_visible)/visible_range;
	else
		rel = 0.5;
	var col = make_color_hsv(0, 0, rel*c_visible_max + (1-rel)*c_visible_min);
	
	// Draw a background texture, shaded to indicate elevation
	//###
	draw_sprite_ext(spr_square, tile.image_index, coords[0], coords[1], 1, 1, tile.image_angle, col, tile.image_alpha);
	
	// Draw the tile's sprite
	draw_sprite_ext(spr_tile, tile.image_index, coords[0], coords[1], 1, 1, tile.image_angle, c_white, tile.image_alpha);
	
	// Draw tile outline
	draw_sprite_ext(spr_outline, 0, coords[0], coords[1], 1, 1, 0, c_white, tile.image_alpha);
	
	// Go to next tile
	key = ds_map_find_next(visible_tiles, key);
}
