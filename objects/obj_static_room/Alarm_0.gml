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
	else if (global.next_room == -1)
	{
		// If next room is set to -1 (at end of game), end
		game_end();
	}
	else
	{
		// If next room is set to -2 (on save clear), reset
		game_restart();
	}
}
