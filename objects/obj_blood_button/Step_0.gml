/// @desc Go to specified room on mouse click.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Toggle blood options
		if (global.bloodless == false)
		{
			label = "Show Blood: Off";
			global.bloodless = true;
		}
		else
		{
			label = "Show Blood: On";
			global.bloodless = false;
		}
	}
}
