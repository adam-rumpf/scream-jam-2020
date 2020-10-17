/// @desc Set opacity and listen for mouse clicks.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, brighten and listen for mouse clicks
	image_alpha = 0.9;
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Go to current level room
		room_goto(global.level_rooms[global.level]);
	}
	//### Replace with a smoother transition.
}
else
{
	// Otherwise dim
	image_alpha = 0.5;
}
