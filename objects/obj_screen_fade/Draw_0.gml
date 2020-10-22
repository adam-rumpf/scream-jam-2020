/// @desc Shade screen.

// Increment overlay opacity
alpha = min(alpha + 0.00075, 0.95);

// Draw overlay
draw_primitive_begin(pr_trianglestrip);
draw_vertex_color(-100, -100, c_black, alpha);
draw_vertex_color(room_width+100, -100, c_black, alpha);
draw_vertex_color(-100, room_height+100, c_black, alpha);
draw_vertex_color(room_width+100, room_height+100, c_black, alpha);
draw_primitive_end();
