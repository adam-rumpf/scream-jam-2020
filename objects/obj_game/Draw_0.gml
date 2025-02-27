/// @desc Draw health display within level rooms.

// Draw nothing outside of level rooms
if (_level_room() == false)
	exit;

// Draw a health bar (except for the intro room)
if (room != rm_level_intro)
{
	// Do nothing if invisible
	if (health_alpha <= 0)
		exit;
	
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
	
	// Draw either solid or partial health bar
	if (health_alpha < 1)
	{
		// If partiall visible, fade in and draw transluscent version
		health_alpha = min(health_alpha + 0.01, 1);
		
		// Draw health bar
		if (health_display > 0)
		{
			draw_primitive_begin(pr_trianglestrip);
			draw_vertex_color(x1, y1 + min((y2-y1)*(1-(health_display/100)), y2), fill1, health_alpha);
			draw_vertex_color(x2, y1 + min((y2-y1)*(1-(health_display/100)), y2), fill1, health_alpha);
			draw_vertex_color(x1, y2, fill2, health_alpha);
			draw_vertex_color(x2, y2, fill2, health_alpha);
			draw_primitive_end();
		}
		draw_primitive_begin(pr_linelist);
		draw_vertex_color(x2, y2, border1, health_alpha);
		draw_vertex_color(x1, y2, border1, health_alpha);
		draw_vertex_color(x1, y1, border2, health_alpha);
		draw_vertex_color(x2, y1, border2, health_alpha);
		draw_vertex_color(x2, y2, border1, health_alpha);
		draw_primitive_end();
	}
	else
	{
		// Otherwise simply draw rectangles
		if (health_display > 0)
			draw_rectangle_color(x1, y1 + min((y2-y1)*(1-(health_display/100)), y2), x2, y2, fill1, fill1, fill2, fill2, false);
		draw_rectangle_color(x1, y1, x2, y2, border2, border2, border1, border1, true);
	}
}
else
{
	// Display a hint message if the player has been wandering for too long in the intro room
	if (global.moves <= 30)
		exit;
	
	// Fade in message
	health_alpha = min(health_alpha + 0.025, 1);
	
	// Draw text
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_color(c_white);
	draw_set_font(fnt_default);
	
	var wave, yy;
	wave = 2*sin(0.00433*current_time);
	yy = room_height - 45 + wave;
	draw_text_color(room_width/2, yy, "Go downhill.", c_white, c_white, c_white, c_white, health_alpha);
}
