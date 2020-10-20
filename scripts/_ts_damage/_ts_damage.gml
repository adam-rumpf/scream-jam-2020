/// @func _ts_damage()
/// @desc Deals damage from the TS enemies depending on objective value difference and intensity.

function _ts_damage()
{
	// Do nothing if not active
	if (global.ts_intensity == 0)
		exit;
	
	// Determine damage depending on intensity
	switch global.ts_intensity
	{
		case 1:
			health -= 25;//###
			break;
		case 2:
			health -= 50;//###
			break;
		case 3:
			health -= 100;//###
			break;
	}
	
	// Show a red flash
	var flash = instance_create_layer(0, 0, "Instances", obj_screen_flash);
	flash.timer = 0.075*room_speed;
	flash.col = make_color_hsv(0, 255, 191);
}
