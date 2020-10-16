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
ascend_speed = 0.02; // tile-to-tile movement speed for ascending (fraction of tile per step)
level_speed = 0.04; // tile-to-tile movement speed for remaining level (fraction of tile per step)
descend_speed = 0.06; // tile-to-tile movement speed for descending (fraction of tile per step)
level_margin = 2; // elevation changes within this margin are considered "level" for the purposes of animation

// Define player variables
movement_speed = 0.0; // rate of incrementing movement parameter
convex = 0.0; // convex parameter for position between previous and next tile
dir_x = 0; // sign of x-direction movement (-1, 0, or 1)
dir_y = 0; // sign of y-direction movement (-1, 0, or 1)

// Set timer for switching idle animation
alarm[0] = irandom_range(room_speed*8, room_speed*16);

// Movement methods

/// @func move_n([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player north.

move_n = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_n;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_n;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_n;
	}
	
	// Update global coordinates
	global.player_y--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 0;
	dir_y = -1;
}

/// @func move_e([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player east.

move_e = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_e;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_e;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_e;
	}
	
	// Update global coordinates
	global.player_x++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 1;
	dir_y = 0;
}

/// @func move_s([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player south.

move_s = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_s;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_s;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_s;
	}
	
	// Update global coordinates
	global.player_y++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 0;
	dir_y = 1;
}

/// @func move_w([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player west.

move_w = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_w;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_w;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_w;
	}
	
	// Update global coordinates
	global.player_x--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = -1;
	dir_y = 0;
}

/// @func move_ne([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player northeast.

move_ne = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_e;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_e;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_e;
	}
	
	// Adjust for diagonal movement
	movement_speed /= sqrt(2);
	
	// Update global coordinates
	global.player_y--;
	global.player_x++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 1;
	dir_y = -1;
}

/// @func move_se([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player southeast.

move_se = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_e;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_e;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_e;
	}
	
	// Adjust for diagonal movement
	movement_speed /= sqrt(2);
	
	// Update global coordinates
	global.player_y++;
	global.player_x++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 1;
	dir_y = 1;
}

/// @func move_sw([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player southwest.

move_sw = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_w;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_w;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_w;
	}
	
	// Adjust for diagonal movement
	movement_speed /= sqrt(2);
	
	// Update global coordinates
	global.player_y++;
	global.player_x--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = -1;
	dir_y = 1;
}

/// @func move_nw([delta])
/// @param {int} [delta=0] Elevation change.
/// @desc Moves the player northwest.

move_nw = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// Set movement speed and sprite based on elevation difference
	if (delta < -level_margin)
	{
		movement_speed = descend_speed;
		sprite_index = spr_player_downhill_w;
	}
	else if (delta > level_margin)
	{
		movement_speed = ascend_speed;
		sprite_index = spr_player_uphill_w;
	}
	else
	{
		movement_speed = level_speed;
		sprite_index = spr_player_level_w;
	}
	
	// Adjust for diagonal movement
	movement_speed /= sqrt(2);
	
	// Update global coordinates
	global.player_y--;
	global.player_x--;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = -1;
	dir_y = -1;
}

//###
image_speed = 0.25;
