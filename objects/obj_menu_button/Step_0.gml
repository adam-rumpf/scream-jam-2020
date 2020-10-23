/// @desc Go to menu on mouse click.

// Do nothing as game is ending
if (global.ending == true)
{
	selected = false;
	exit;
}

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Go to menu screen
		global.next_room = rm_menu;
		room_goto(rm_static);
	}
}
