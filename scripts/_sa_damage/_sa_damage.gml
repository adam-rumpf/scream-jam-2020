/// @func _sa_damage(diff)
/// @desc Deals damage from the SA enemies depending on objective value difference and intensity.
/// @param {int} diff Difference between player's objective and new tile's objective.

function _sa_damage()
{
	// Do nothing if not active
	if (global.sa_intensity == 0)
		exit;
	
	// Determine damage depending on intensity
	switch global.sa_intensity
	{
		case 1:
			health -= 5;//###2*d;
			break;
		case 2:
			health -= 10;//###4*d;
			break;
		case 3:
			health -= 20;//###8*d;
			break;
	}
	
	// Show a red flash
	var flash = instance_create_layer(0, 0, "Instances", obj_screen_flash);
	flash.timer = 0.075*room_speed;
	flash.col = make_color_hsv(0, 255, 191);
	
	//### Play a sound
}
