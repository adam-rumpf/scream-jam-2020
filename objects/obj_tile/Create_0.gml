/// @desc Initialize tile attributes (all set externally by the level object).

/*
 * Each tile has a specified elevation and image attributes.
 * The tile object, itself, is invisible and has no sprite, but the image attributes are read to determine how the tile is drawn.
 * The elevation is used to define the objective function.
 * Computationally the game is treated as a maximization problem and as a hill climb, and so all heights should be nonnegative integers.
 * In-story and graphically, however, we treat larger height values as representing lower elevations, with the goal of going lower.
 *
 * The tile object also includes a method to determine its own sprite's coordinates on the screen, which depend on the player's position.
 * It is also used for positioning the SA and TS enemies, and includes an internal tabu tenure for use in TS.
 *
 * Note that the tile's x and y attributes indicate its coordinates in the grid, and have nothing to do with where it is displayed.
 */

// Initialize attributes (overwritten by level object)
elevation = 0; // elevation for use in defining the objective function
image_speed = 0;
image_index = 0; // image index of tile sprite
image_xscale = global.tile_scale; // scaling and horizontal mirroring
image_yscale = global.tile_scale; // scaling and vertical mirroring
image_angle = 0; // image rotation
image_alpha = 0; // image opacity (automatically increments to allow new tiles to fade in)

// Initialize fog attributes (used to fade fog in and out for SA levels)
suboptimal = false; // whether the move is suboptimal
fog = 0; // opacity of fog

// Initialize stalker attributes (used to handle tabu tenures and to control how the stalker is facing)
tabu_move = 0; // move number on which the tile's tenure is meant to expire

/// @func screen_coordinates([dx[, dy]])
/// @desc Returns the tile sprite's screen coordinates, which depend on the player's (x,y)-coordinates and the movement parameter.
/// @param {int} [dx=0] x-direction offset (to compensate for intermediate movement).
/// @param {int} [dy=0] y-direction offset (to compensate for intermediate movement).
/// @return {int[]} Ordered pair of (x,y) screen coordinates for the tile.

screen_coordinates = function()
{
	// Get optional offset arguments
	var dx = (argument_count > 0 ? argument[0] : 0);
	var dy = (argument_count > 1 ? argument[1] : 0);
	
	// Find screen position relative to player
	var xx = (x - global.player_x)*global.tile_size*global.tile_scale + (room_width/2) + dx;
	var yy = (y - global.player_y)*global.tile_size*global.tile_scale + (room_height/2) + dy;
	
	return [round(xx), round(yy)];
}

/// @func is_tabu()
/// @desc Determines whether this tile is tabu based on when its tenure started, the tenure lengths, and the current move number.
/// @return {bool} True if tabu, false otherwise.

is_tabu = function()
{
	// The tile is tabu if and only if its tenure end falls later than the current move
	return (tabu_move - global.moves) > 0;
}

/// @func face_player()
/// @desc Returns the direction that an enemy on this tile would need to turn to face the player.
/// @return {int} Integer ID of facing direction, as an increment of 90 degrees.

face_player = function()
{
	// Find relative difference in coordinates
	var dx = x - global.player_x;
	var dy = y - global.player_y;
	
	// Determine whether the horizontal difference or the vertical difference is greater
	if (abs(dx) >= abs(dy))
	{
		// Determine whether to face East or West
		if (dx > 0)
			return 2;
		else
			return 0;
	}
	else
	{
		// Determine whether to face North or South
		if (dy > 0)
			return 1;
		else
			return 3;
	}
}
