/// @desc Draw reset confirmation message.

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_font(fnt_default);
draw_text(room_width/2, room_height/2 - 32, "Delete save files?\nThis cannot be undone.");