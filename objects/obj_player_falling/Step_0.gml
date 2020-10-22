/// @desc Drift to middle of screen and then slightly vary position.

if (ybase < room_height/2)
	ybase += 1;

x = xbase + 4*sin(0.0057*current_time);
y = ybase + 8*sin(0.0033*current_time + 0.33);
