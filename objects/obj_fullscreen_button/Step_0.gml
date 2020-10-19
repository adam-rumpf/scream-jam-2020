/// @desc Go to specified room on mouse click.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Toggle fullscreen
		if (window_get_fullscreen() == true)
		{
			window_set_fullscreen(false);
			label = "Screen: Windowed";
			global.fullscreen = false;
		}
		else
		{
			window_set_fullscreen(true);
			label = "Screen: Fullscreen";
			global.fullscreen = true;
		}
	}
}
