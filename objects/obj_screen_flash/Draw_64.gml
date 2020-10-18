/// @desc Draw over the screen.

// Get GUI dimensions
var w, h;
w = display_get_gui_width();
h = display_get_gui_height();

// Cover screen
draw_rectangle_color(0, 0, w, h, col, col, col, col, false);
