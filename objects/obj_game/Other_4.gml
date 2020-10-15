/// @desc Continue the current level or start a new one.

// If a level room, spawn a player object
if (_level_room() == true)
	player = instance_create_layer(room_width/2, room_height/2, "Player", obj_player);

// Determine whether to generate a new level
if (new_level == false)
	exit;

// Generate a level depending on the current room

// Destroy any previous level objects if they exist
if (is_undefined(level) == false)
	instance_destroy(level);

// Create a new level object to handle the level generation and storage
level = instance_create_layer(0, 0, "Instances", obj_level);

// Reset new_level flag
new_level = false;
