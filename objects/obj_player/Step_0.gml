/// @desc Increment movement parameter.

// Fade out while exiting
if (exiting == true)
	image_alpha = 1 - (image_index/image_number);

// Do nothing if not moving
if (movement_speed == 0.0)
	exit;

// Increment movement parameter
if (convex < 1.0)
	convex += movement_speed;

// Update relative position
global.player_dx = convex*dir_x;
global.player_dy = convex*dir_y;

// If the movement is complete, set the speed and movement signs to zero
if (convex >= 1.0)
{
	locked = false;
	convex = 1.0;
	movement_speed = 0.0;
	dir_x = 0;
	dir_y = 0;
	global.player_dx = 0.0;
	global.player_dy = 0.0;
	if ((dying == false) && (exiting == false))
		sprite_index = spr_player_idle_01;
}
