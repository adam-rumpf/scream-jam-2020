/// @desc Continue the current level or start a new one.

// Spawn level objects in a level room
if (_level_room() == true)
{
	// Spawn the player object
	player = instance_create_layer(room_width/2, room_height/2, "Player", obj_player);
	
	// Create GUI elements
	instance_create_layer(room_width - 48, 32, "Buttons", obj_menu_button);
	
	// Create invisible buttons around the player to listen for mouse clicks
	var unit = global.tile_size*global.tile_scale;
	for (var i = -1; i <= 1; i++)
	{
		for (var j = -1; j <= 1; j++)
		{
			if ((i == 0) && (j == 0))
				continue;
			var button = instance_create_layer(room_width/2 + unit*i, room_height/2 + unit*j, "Buttons", obj_button_neighbor);
			button.game = self;
			button.dx = i;
			button.dy = j;
		}
	}
}

// If the menu room, spawn GUI elements
if (room == rm_menu)
{
	// Create menu buttons
	var space = 48;
	instance_create_layer(3*room_width/4 - 32, room_height/2 - 4*space, "Buttons", obj_sound_button);
	instance_create_layer(3*room_width/4 - 32, room_height/2 - 3*space, "Buttons", obj_music_button);
	instance_create_layer(3*room_width/4 - 32, room_height/2 - space, "Buttons", obj_fullscreen_button);
	instance_create_layer(3*room_width/4 - 32, room_height/2 + space, "Buttons", obj_credits_button);
	instance_create_layer(3*room_width/4 - 32, room_height/2 + 2*space, "Buttons", obj_reset_button);
	instance_create_layer(3*room_width/4 - 32, room_height/2 + 3*space, "Buttons", obj_quit_button);
	instance_create_layer(room_width - 48, room_height - 32, "Buttons", obj_back_button);
}

// Determine whether to generate a new level
if (global.new_level == false)
	exit;

// Generate a level depending on the current room

// Destroy any previous level objects if they exist
if (is_undefined(level) == false)
	instance_destroy(level);

// Create a new level object to handle the level generation and storage
level = instance_create_layer(0, 0, "Instances", obj_level);

// Reset new level variables
global.new_level = false;
global.wake_up = true;
global.victory = false;
global.sa_intensity = 0;
global.ts_intensity = 0;
health = 100.0;
global.dead = false;
global.moves = 0;
