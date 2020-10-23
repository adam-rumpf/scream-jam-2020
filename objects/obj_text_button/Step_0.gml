/// @desc Listen for mouse clicks.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
		game_end();
}
