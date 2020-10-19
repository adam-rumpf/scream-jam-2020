/// @desc Set opacity and listen for mouse clicks.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	offset = 4*sin(0.01*current_time);
	
	// If selected, move and listen for mouse clicks
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Perform action (depends on button)
		global.sound = max(global.sound - 0.05, 0);
	}
}
else
{
	// Otherwise stop moving
	offset = 0;
}
