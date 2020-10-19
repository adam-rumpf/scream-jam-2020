/// @desc Game initialization processes.

// Define global constants and variables
global.seed = randomize(); // random seed for current level (reset on level restart)
global.version = 0.1; // game version number (encoded in save files)
global.save_file = "save.dat"; // save file name
global.settings_file = "settings.ini"; // settings file name
global.tile_size = 32; // tile dimension (px)
global.tile_scale = 2; // tile scaling

// Define array of rooms in level sequence
global.level_rooms = [rm_level_intro, rm_level_sa, rm_level_ts, rm_level_hybrid, rm_level_final]; //###

// Initialize cursor tacker
instance_create_layer(mouse_x, mouse_y, "Instances", obj_cursor);

// Load settings
global.sound = 0.5; // sound volume (0.0 to 1.0)
global.music = 0.5; // music volume (0.0 to 1.0)
global.fullscreen = true; // whether the game is in fullscreen
_load_settings(); // attempt to load settings
_save_settings(); // overwrite settings file

// Load progress
global.level = 0; // level progress
_load_game(); // attempt to load progress
_save_game(); // overwrite save file

// Player attributes
global.player_x = 0; // player's grid coordinates (the player object, itself, is fixed in the center of the room)
global.player_y = 0;
global.player_dx = 0.0; // player's position relative to their starting position during intermediate movement (between -1 and 1)
global.player_dy = 0.0;

//### Use level progress to decide how to begin the game

// Level-dependent variables
global.intensity = 0; // metaheuristic intensity (reset on level restart; controls various game mechanics)
health = 100.0; // player's current health
global.dead = false; // whether the player is dead (restart level if true)
global.new_level = true; // whether to generate a new level on entering the room
global.first_time = true; // whether this is the player's first time seeing a level during the current play session
level = undefined; // level object which defines the current level's terrain
player = undefined; // player object which handles some player-specific actions
global.player_elevation = 0; // elevation of player's current tile
global.victory = false; // whether the level has been won
global.moves = 0; // number of moves made so far
global.next_room = global.level_rooms[global.level]; // next room to go to (for use in screen transitions)

// Define movement methods

/// @func move_player(x, y)
/// @desc Moves the player and updates the level.
/// @param {int} x x-component of movement (-1, 0, or 1).
/// @param {int} y y-component of movement (-1, 0, or 1).

move_player = function(xx, yy)
{
	// Find the difference in objective value
	var diff = global.player_elevation - level.get_tile(global.player_x + xx, global.player_y + yy).elevation;
	
	// Call one of the player's movement methods depending on the direction of movement
	if ((xx == 0) || (yy == 0))
	{
		// Cardinal direction
		if (xx < 0)
			player.move_w(diff);
		else if (xx > 0)
			player.move_e(diff);
		else if (yy < 0)
			player.move_n(diff);
		else if (yy > 0)
			player.move_s(diff);
	}
	else
	{
		// Diagonal direction
		if (xx < 0)
		{
			if (yy < 0)
				player.move_nw(diff);
			else if (yy > 0)
				player.move_sw(diff);
		}
		else if (xx > 0)
		{
			if (yy < 0)
				player.move_ne(diff);
			else
				player.move_se(diff);
		}
	}
	
	// Update the level display
	level.update_player_elevation();
	level.update_visible(0, -1);
	level.explore_neighborhood();
}

// Go to title screen
room_goto(rm_title);
