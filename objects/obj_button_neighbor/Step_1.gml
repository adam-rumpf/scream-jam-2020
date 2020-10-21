/// @desc Set opacity and listen for mouse clicks.

// Do nothing if player is moving
if ((global.player_dx != 0.0) || (global.player_dy != 0.0))
	exit;

// Determine behavior depending on whether the button is selected
if (selected == true)
{
	selected = false;
	
	// If selected, brighten and listen for mouse clicks
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
