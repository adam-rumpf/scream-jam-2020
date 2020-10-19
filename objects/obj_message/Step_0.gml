/// @desc Transition early on mouse click.

if (mouse_check_button_pressed(mb_any) == true)
	room_goto(rm_static);
