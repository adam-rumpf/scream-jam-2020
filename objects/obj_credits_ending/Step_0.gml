/// @desc Increment credits position and reset game once over.

pos -= 1;
if (pos < -800 - 60)
{
	global.next_room = -1;
	room_goto(rm_static);
}
