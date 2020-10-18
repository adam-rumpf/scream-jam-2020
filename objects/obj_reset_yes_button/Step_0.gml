/// @desc Go to menu on mouse click.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Delete save file
		_save_clear();
	}
}
