/// @desc Set opacity and listen for mouse clicks.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, brighten and listen for mouse clicks
	image_alpha = 0.9;
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Perform action (depends on button)
	}
}
else
{
	// Otherwise dim
	image_alpha = 0.5;
}
