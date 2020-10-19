/// @desc Listen for in-game events.

//### When level is complete, move to the next room (or an intermediate room) and set new_level to true.
//### Listen for player actions.
//### Listen for selecting the menu screen, in which case we move to that room but do not set new_level to true.
//### Also update the global.level variable and save when we complete a room.

// Listen for escape key press
if (keyboard_check_pressed(vk_escape))
	game_end();

// Listen for level victory
if (global.victory == true)
{
	// Set up to go to a new level
	global.victory = false;
	global.new_level = true;
	global.first_time = true;
	
	// Go to next room in sequence (unless at end)
	//### Replace this with a game reset if we don't get around to the random levels.
	//###global.level = min(global.level + 1, array_length(global.level_rooms) - 1);
	global.level = (global.level + 1) % array_length(global.level_rooms); //### Placeholder for looping
	global.next_room = global.level_rooms[global.level];
	
	// Save progress
	_save_game();
	
	// Go to next room (through transition room)
	room_goto(rm_static);
}

// Listen for player health to reach zero
if (health <= 0)
{
	// Show player's death animation
	player.die();
}

// Listen for player death
if (global.dead == true)
{
	// Restart with a newly-generated level
	global.new_level = true;
	room_restart();//###
	//###
}
