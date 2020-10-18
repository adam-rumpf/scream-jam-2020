/// @desc Listen for in-game events.

//### When level is complete, move to the next room (or an intermediate room) and set new_level to true.
//### Listen for player actions.
//### Listen for selecting the menu screen, in which case we move to that room but do not set new_level to true.
//### Also update the global.level variable and save when we complete a room.

// Listen for level victory
if (global.victory == true)
{
	// Set up to go to a new level
	global.victory = false;
	global.new_level = true;
	
	// Determine next room
	global.next_room = rm_level;//### Switch based on level progression
	global.level = 0;//### Also update.
	
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
