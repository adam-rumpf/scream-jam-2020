/// @desc Go to specified room on mouse click.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Go to save deletion room
		room_goto(rm_reset);
	}
}
