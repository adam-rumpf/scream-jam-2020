/// @func _save_clear()
/// @desc Deletes save files and resets game.

function _save_clear()
{
	// Clear save file
	if (file_exists(global.save_file) == true)
		file_delete(global.save_file);
	
	// Reset progress and return to title screen
	global.level = 0;
	_save_game();
	global.next_room = global.level_rooms[0];
	room_goto(rm_static);
}
