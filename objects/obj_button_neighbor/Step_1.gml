/// @desc Set opacity and listen for mouse clicks.

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, brighten and listen for mouse clicks
	//### Add arrows and text
	if (mouse_check_button_pressed(mb_left) == true)
	{
		// Call game object's movement method
		game.move_player(dx, dy);
	}
	
	// Set pointer opacity
	pointer_alpha = 0.9;
}
else
	pointer_alpha = 0;
