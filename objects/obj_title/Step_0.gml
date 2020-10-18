/// @desc Fade title in and then out.

// Update alpha
var rate = 0.0075;
alpha = clamp(alpha + rate*fade*factor, 0, 1);

// Accelerate on mouse click
if (mouse_check_button(mb_any) || keyboard_check(vk_anykey))
{
	factor = 3;
	alarm[0] = min(alarm[0]/factor, 1);
}

// After fully faded in, set timer to fade out
if ((alpha >= 1) && (fade > 0))
{
	init = false;
	fade = 0;
	alarm[1] = (2.0/factor)*room_speed;
}

// After fully faded back out, set timer to go to next room
if ((alpha <= 0) && (init == false))
{
	init = true;
	alarm[2] = (1.0/factor)*room_speed;
}
