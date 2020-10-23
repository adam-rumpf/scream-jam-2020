/// @func _sa_damage()
/// @desc Deals damage from the SA enemies depending on objective value difference and intensity.

function _sa_damage()
{
	// Do nothing if not active
	if (global.sa_intensity == 0)
		exit;
	
	// Determine damage depending on intensity
	switch global.sa_intensity
	{
		case 1:
			health -= 5;
			break;
		case 2:
			health -= 15;
			break;
		case 3:
			health -= 25;
			break;
	}
	
	// Show a red flash
	var flash = instance_create_layer(0, 0, "Instances", obj_screen_flash);
	flash.timer = 0.1*room_speed;
	flash.col = make_color_hsv(0, 255, 191);
}
