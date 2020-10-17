/// @desc Continue the current level or start a new one.

// If a level room, spawn a player object and a GUI elements
if (_level_room() == true)
{
	player = instance_create_layer(room_width/2, room_height/2, "Player", obj_player);
	instance_create_layer(room_width - 32, 32, "Buttons", obj_menu_button);
}

// If the menu room, spawn GUI elements
if (room == rm_menu)
{
	instance_create_layer(room_width - 32, 32, "Buttons", obj_back_button);
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
global.victory = false;
global.intensity = 0;
health = 100.0;
global.dead = false;
global.moves = 0;
