// Draw button as text.

// Set text attributes
draw_set_font(fnt_default);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var alpha = 0.5;
if (selected == true)
	alpha = 0.9;

// Draw text
draw_text_color(x, y, label, c_white, c_white, c_white, c_white, alpha);
