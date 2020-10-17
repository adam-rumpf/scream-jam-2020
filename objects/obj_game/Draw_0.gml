/// @desc Draw health display within level rooms.

if (_level_room() == false)
	exit;

//### Redo display later.

// Define bounds of health display rectangle
var x1, y1, x2, y2;
x1 = 40;
x2 = 50;
y1 = room_height/12;
y2 = 5*room_height/12;

// Define colors
var fill1, fill2, border1, border2;
fill1 = make_color_hsv(0, 255, 127);
fill2 = make_color_hsv(0, 255, 95);
border1 = make_color_hsv(0, 0, 63);
border2 = make_color_hsv(0, 0, 31);

// Draw health bar
if (health > 0)
	draw_rectangle_color(x1, y1 + min((y2-y1)*(1-(health/100)), y2), x2, y2, fill1, fill1, fill2, fill2, false);
draw_rectangle_color(x1, y1, x2, y2, border2, border2, border1, border1, true);
