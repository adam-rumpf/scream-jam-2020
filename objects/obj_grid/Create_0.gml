/// @desc Create a grid of lines.

// Define y-coordinates of grid lines
var num = 1;
lines = [0];
spacing = room_height/10;
while (lines[num-1] < room_height)
{
	lines[num] = lines[num-1] + spacing;
	num++;
}
spd = 10;
