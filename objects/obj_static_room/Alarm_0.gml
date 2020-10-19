/// @desc Go to designated next room.

// Determine next room depending on whether this is the player's first time
if (global.first_time == true)
	// If so, show the message
	room_goto(rm_message);
else
	// If not, go to the level room
	room_goto(global.next_room);
