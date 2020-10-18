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

// Initialize image attributes
image_xscale = global.tile_scale;
image_yscale = global.tile_scale;
image_speed = 0.1; //###
if (global.new_level == true)
{
	sprite_index = spr_player_wake;
	alarm[1] = image_number/image_speed; // set timer to switch to idle animation
}
else
	sprite_index = spr_player_idle_01;

// Define player attributes
ascend_speed = 0.03; // tile-to-tile movement speed for ascending (fraction of tile per step)
level_speed = 0.05; // tile-to-tile movement speed for remaining level (fraction of tile per step)
descend_speed = 0.06; // tile-to-tile movement speed for descending (fraction of tile per step)
level_margin = 2; // elevation changes within this margin are considered "level" for the purposes of animation

// Define player variables
movement_speed = 0.0; // rate of incrementing movement parameter
convex = 0.0; // convex parameter for position between previous and next tile
dir_x = 0; // sign of x-direction movement (-1, 0, or 1)
dir_y = 0; // sign of y-direction movement (-1, 0, or 1)
locked = false; // whether to lock controls
if (global.new_level == false)
	locked = false;
dying = false; // whether the player's death animation is playing
exiting = false; // whetehr the player's level exit animation is playing

// Set timer for switching idle animation
randomize();
alarm[0] = irandom_range(room_speed*6, room_speed*18);

// Player methods

/// @func move_actions([delta])
/// @desc Standard actions that are part of every move.
/// @param {int} [delta=0] Elevation change.

move_actions = function()
{
	// Get optional elevation change argument
	var delta = (argument_count > 0 ? argument[0] : 0);
	
	// If the move is uphill and this is an SA room, take damage
	if ((delta > 0) && (_sa_room() == true))
		_sa_damage(delta);
	
	// Increment move count and update intensity schedule
	global.moves++;
	_intensity_schedule();
	
	// Set movement parameters and begin moving
	locked = true;
	convex = 0.0;
}

/// @func move_n([delta])
/// @desc Moves the player north.
/// @param {int} [delta=0] Elevation change.

move_n = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = 0;
	dir_y = -1;
	move_actions(delta);
}

/// @func move_e([delta])
/// @desc Moves the player east.
/// @param {int} [delta=0] Elevation change.

move_e = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = 1;
	dir_y = 0;
	move_actions(delta);
}

/// @func move_s([delta])
/// @desc Moves the player south.
/// @param {int} [delta=0] Elevation change.

move_s = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = 0;
	dir_y = 1;
	move_actions(delta);
}

/// @func move_w([delta])
/// @desc Moves the player west.
/// @param {int} [delta=0] Elevation change.

move_w = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = -1;
	dir_y = 0;
	move_actions(delta);
}

/// @func move_ne([delta])
/// @desc Moves the player northeast.
/// @param {int} [delta=0] Elevation change.

move_ne = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = 1;
	dir_y = -1;
	move_actions(delta);
}

/// @func move_se([delta])
/// @desc Moves the player southeast.
/// @param {int} [delta=0] Elevation change.

move_se = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = 1;
	dir_y = 1;
	move_actions(delta);
}

/// @func move_sw([delta])
/// @desc Moves the player southwest.
/// @param {int} [delta=0] Elevation change.

move_sw = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = -1;
	dir_y = 1;
	move_actions(delta);
}

/// @func move_nw([delta])
/// @desc Moves the player northwest.
/// @param {int} [delta=0] Elevation change.

move_nw = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
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
	dir_x = -1;
	dir_y = -1;
	move_actions(delta);
}

/// @func win()
/// @desc Play exit animation on reaching the global optimum.

win = function()
{
	// Ignore if already playing animation
	if (exiting == true)
		exit;
	
	// Change sprite and set a timer to exit the level
	sprite_index = spr_player_exit;
	locked = true;
	exiting = true;
	alarm[0] = 1000;
	alarm[2] = image_number/image_speed;
}

/// @func die()
/// @desc Play death animation when health reaches zero.

die = function()
{
	// Ignore if already playing animation
	if (dying == true)
		exit;
	
	// Change sprite and set a timer to restart the level
	sprite_index = choose(spr_player_death_01, spr_player_death_02);
	locked = true;
	dying = true;
	alarm[0] = 1000;
	alarm[3] = image_number/image_speed;
}
