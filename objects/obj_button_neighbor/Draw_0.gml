/// @desc Draw pointer and text.

// Become invisible if game is ending
if (global.ending == true)
{
	pointer_alpha = 0;
	exit;
}

// Do nothing if invisible or player is moving
if ((pointer_alpha <= 0) || (global.player_dx != 0.0) || (global.player_dy != 0.0))
	exit;

// Set wave motion to move back and forth
var wave = (global.tile_size*global.tile_scale*0.1)*sin(0.01*current_time);

// Set angle depending on directions
var angle = 0;
if ((dx == 0) || (dy == 0))
{
	// Cardinal direction
	if (dx < 0)
		angle = pi;
	else if (dx > 0)
		angle = 0;
	else if (dy < 0)
		angle = pi/2;
	else if (dy > 0)
		angle = 3*pi/2;
}
else
{
	// Diagonal direction
	if (dx < 0)
	{
		if (dy < 0)
			angle = 3*pi/4;
		else if (dy > 0)
			angle = 5*pi/4;
	}
	else if (dx > 0)
	{
		if (dy < 0)
			angle = pi/4;
		else if (dy > 0)
			angle = 7*pi/4;
	}
}

// Determine total position offset
var xx, yy, scale;
scale = max(global.sa_intensity, global.ts_intensity);
xx = x + wave*cos(angle) + 1.5*irandom_range(-scale, scale);
yy = y + wave*sin(-angle) + 1.5*irandom_range(-scale, scale);

// Draw pointer in correct orientation and scale
draw_sprite_ext(spr_pointer, 0, xx, yy, global.tile_scale, global.tile_scale, radtodeg(angle), c_white, pointer_alpha);

// Draw text to indicate whether the step is an ascent
var diff = global.player_elevation - game.level.get_tile(global.player_x + dx, global.player_y + dy).elevation;

// Display text
var str, wave, xx, yy, col;
wave = 2*sin(0.00567*current_time);
xx = room_width/2 + 0.5*irandom_range(-scale, scale);
yy = 45 + wave + 0.5*irandom_range(-scale, scale);
if (diff < 0)
{
	str = "Descend";
	col = make_color_hsv(47, 127, 191);
}
else if (diff > 0)
{
	str = "Ascend";
	col = make_color_hsv(47, 127, 255);
}
else
{
	str = "Walk";
	col = make_color_hsv(47, 127, 227);
}
draw_text_color(xx, yy, str, col, col, col, col, 0.9);
