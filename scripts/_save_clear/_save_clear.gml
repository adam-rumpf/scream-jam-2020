/// @func _save_clear()
/// @desc Deletes save files and resets game.

function _save_clear()
{
	// Clear save file
	if (file_exists(global.save_file) == true)
		file_delete(global.save_file);
	
	// Reset game
	//### Possibly transition through static
	game_restart();
}
