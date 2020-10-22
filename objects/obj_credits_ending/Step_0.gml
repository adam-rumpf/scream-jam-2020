/// @desc Increment credits position and reset game once over.

pos -= 1;//### Adjust this cutoff depending on the credits length.
if (pos < -760 - 60)
{
	global.next_room = -1;
	room_goto(rm_static);
}
