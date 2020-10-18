/// @desc Go to menu on mouse click.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Go back to game room
		global.next_room = global.level_rooms[global.level];
		room_goto(rm_static);
	}
}
