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
idle_loops = 0; // number of consecutive loops of default idle animation
footsteps = undefined; // current footstep sound

// Initialize image attributes
image_xscale = global.tile_scale;
image_yscale = global.tile_scale;
image_speed = 0.2;
if (global.wake_up == true)
{
	global.wake_up = false;
	locked = true;
	sprite_index = spr_player_wake;
}
else
	sprite_index = spr_player_idle_01;

// Define player attributes
ascend_speed = 0.0225; // tile-to-tile movement speed for ascending (fraction of tile per step)
level_speed = 0.025; // tile-to-tile movement speed for remaining level (fraction of tile per step)
descend_speed = 0.0325; // tile-to-tile movement speed for descending (fraction of tile per step)
slip_speed = 0.04; // movement speed for final cutscene
level_margin = 2; // elevation changes within this margin are considered "level" for the purposes of animation

// Player methods

/// @func move_actions([delta[, tabu]])
/// @desc Standard actions that are part of every move.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_actions = function()
{
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
	var start_health = health; // health at beginning of move
	
	// If the move is uphill and this is an SA room, take damage
	if ((delta > 0) && (_sa_room() == true))
		_sa_damage();
	
	// If the move is tabu, take damage
	if (tabu == true)
		_ts_damage();
	
	// Heal slightly if no damage was taken
	if (health == start_health)
		health = min(health + 1, 100);
	
	// Increment move count and update intensity schedule
	global.moves++;
	_intensity_schedule();
	
	// Start sound depending on uphill/downhill
	if (delta > level_margin)
		footsteps = audio_play_sound(snd_walk_slow, 10, false);
	else if (delta < -level_margin)
		footsteps = audio_play_sound(snd_walk_fast, 10, false);
	else
		footsteps = audio_play_sound(snd_walk_normal, 10, false);
	audio_sound_gain(footsteps, global.sound, 0);
	audio_sound_pitch(footsteps, random_range(0.8, 1.2));
	
	// Set movement parameters and begin moving
	locked = true;
	convex = 0.0;
}

/// @func move_n([delta[, tabu]])
/// @desc Moves the player north.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_n = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_e([delta[, tabu]])
/// @desc Moves the player east.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_e = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_s([delta[, tabu]])
/// @desc Moves the player south.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_s = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_w([delta[, tabu]])
/// @desc Moves the player west.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_w = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_ne([delta[, tabu]])
/// @desc Moves the player northeast.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_ne = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_se([delta[, tabu]])
/// @desc Moves the player southeast.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_se = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_sw([delta[, tabu]])
/// @desc Moves the player southwest.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_sw = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
}

/// @func move_nw([delta[, tabu]])
/// @desc Moves the player northwest.
/// @param {int} [delta=0] Elevation change.
/// @param {bool} [tabu=false] Whether the move is tabu.

move_nw = function()
{
	// Do nothing while locked
	if ((locked == true) || (dying == true) || (exiting == true))
		exit;
	
	// Get optional arguments
	var delta = (argument_count > 0 ? argument[0] : 0);
	var tabu = (argument_count > 1 ? argument[1] : false);
	
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
	move_actions(delta, tabu);
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
	image_speed *= 0.75;
	locked = true;
	exiting = true;
}

/// @func die()
/// @desc Play death animation when health reaches zero.

die = function()
{
	// Ignore if already playing animation
	if (dying == true)
		exit;
	
	// Change sprite and set a timer to restart the level
	if (global.bloodless == true)
		sprite_index = spr_player_death_02;
	else
		sprite_index = spr_player_death_01;
	locked = true;
	dying = true;
}

/// @func slip_s()
/// @desc Slips south during the ending cutscene.

slip_s = function()
{
	if (locked == true)
		exit;
	
	// Set movement speed and sprite
	movement_speed = slip_speed;
	if (global.player_y >= 50)
	{
		sprite_index = spr_player_slip_s;
		image_speed = 0.1;
	}
	else
		sprite_index = spr_player_downhill_s;
	
	// Update global coordinates
	global.player_y++;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	
	// Start sound
	footsteps = audio_play_sound(snd_footstep_single, 10, false);
	audio_sound_gain(footsteps, global.sound*clamp(30/(abs(global.player_y)+1), 0, 1), 0);
	audio_sound_pitch(footsteps, random_range(0.8, 1.2));
	
	// Set movement parameters and begin moving
	convex = 0.0;
	dir_x = 0;
	dir_y = 1;
	slip_speed += 0.005;
	locked = true;
	
	// Also begin changing actual y-coordinate on screen
	if (global.player_y >= 50)
		y += floor((global.player_y - 50)/2);
}
