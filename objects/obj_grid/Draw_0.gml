/// @desc Draw grid.

// Increment grid line position
spd = min(spd + 0.05, 20);

// Draw grid
for (var i = 0; i < array_length(lines); i++)
{
	lines[i] -= spd;
	if (lines[i] < 0)
		lines[i] += room_height;
	draw_line_width_color(-100, lines[i], room_width+100, lines[i], 4, c_gray, c_gray);
}
var wave = round(4*sin(0.002*current_time));
for (var i = -spacing/2; i <= room_width; i += spacing)
	draw_line_width_color(i+wave, -100, i+wave, room_height+100, 4, c_gray, c_gray);
