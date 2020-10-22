/// @desc Go to designated next room.

// Determine next room depending on whether this is the player's first time
if (global.first_time == true)
	// If so, show the message
	room_goto(rm_message);
else
{
	// If not, go to the level room
	if (global.next_room >= 0)
		room_goto(global.next_room);
	else
	{
		// If next room is set to -1 (at end of game), reset
		_save_clear();
		game_end();
	}
}
