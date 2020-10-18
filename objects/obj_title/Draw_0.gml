/// @desc Draw title screen.

// Set text attributes
draw_set_font(fnt_default);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Draw logo and text
draw_sprite_ext(spr_title_logo, 0, room_width/2, room_height/2 - 40, 0.3, 0.3, 0, c_white, alpha);
draw_text_color(room_width/2, room_height/2 + 110, "Adam Rumpf\n2020", c_white, c_white, c_white, c_white, alpha);
