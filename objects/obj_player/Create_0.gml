/// @desc Initialize player attributes.

/*
 * The player object handling player animations and a few player-specific processes.
 * All game-relevant information that needs to persist across rooms, such as the player's health, is handled externally.
 *
 * The player object is always positioned in the middle of the room.
 * The player's grid coordinates are stored in the global player_x and player_y variables.
 * These variables are integer grid positions.
 * While the player moves from one tile to the next, a global player_move variable increments from 0.0 to 1.0 to indicate the fraction of the way to the next tile.
 */

// Define player attributes
ascend_speed = 0.01; // tile-to-tile movement speed for ascending (fraction of tile per step)
level_speed = 0.02; // tile-to-tile movement speed for remaining level (fraction of tile per step)
descend_speed = 0.03; // tile-to-tile movement speed for descending (fraction of tile per step)

// Define player variables
movement_speed = 0.0; // rate of incrementing movement parameter
convex = 0.0; // convex parameter for position between previous and next tile
dir_x = 0; // sign of x-direction movement (-1, 0, or 1)
dir_y = 0; // sign of y-direction movement (-1, 0, or 1)

// Movement methods

/// @func move_n()
/// @desc Moves the player north.

move_n = function()
{
	// Update global coordinates
	global.player_y--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 0;
	dir_y = -1;
	movement_speed = level_speed; //### Determine whether this is an ascent or a descent
}

/// @func move_e()
/// @desc Moves the player east.

move_e = function()
{
	// Update global coordinates
	global.player_x++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 1;
	dir_y = 0;
	movement_speed = level_speed; //### Determine whether this is an ascent or a descent
}

/// @func move_s()
/// @desc Moves the player south.

move_s = function()
{
	// Update global coordinates
	global.player_y++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 0;
	dir_y = 1;
	movement_speed = level_speed; //### Determine whether this is an ascent or a descent
}

/// @func move_w()
/// @desc Moves the player west.

move_w = function()
{
	// Update global coordinates
	global.player_x--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = -1;
	dir_y = 0;
	movement_speed = level_speed; //### Determine whether this is an ascent or a descent
}

/// @func move_ne()
/// @desc Moves the player northeast.

move_ne = function()
{
	// Update global coordinates
	global.player_y--;
	global.player_x++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 1;
	dir_y = -1;
	movement_speed = level_speed/sqrt(2); //### Determine whether this is an ascent or a descent
}

/// @func move_se()
/// @desc Moves the player southeast.

move_se = function()
{
	// Update global coordinates
	global.player_y++;
	global.player_x++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 1;
	dir_y = 1;
	movement_speed = level_speed/sqrt(2); //### Determine whether this is an ascent or a descent
}

/// @func move_sw()
/// @desc Moves the player southwest.

move_sw = function()
{
	// Update global coordinates
	global.player_y++;
	global.player_x--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = -1;
	dir_y = 1;
	movement_speed = level_speed/sqrt(2); //### Determine whether this is an ascent or a descent
}

/// @func move_nw()
/// @desc Moves the player northwest.

move_nw = function()
{
	// Update global coordinates
	global.player_y--;
	global.player_x--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = -1;
	dir_y = -1;
	movement_speed = level_speed/sqrt(2); //### Determine whether this is an ascent or a descent
}

//###
image_speed = 0.25;
