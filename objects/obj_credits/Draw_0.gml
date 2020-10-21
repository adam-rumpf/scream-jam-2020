/// @desc Draw credits.

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(fnt_default);
draw_text(room_width/2, pos, _credits());
