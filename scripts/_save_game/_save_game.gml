/// @func _save_game()
/// @desc Saves game progress (and creates a new save file if none exists).
/// @return {bool} Returns true if successful.

function _save_game()
{
	// Clear file
	if (file_exists(global.save_file) == true)
		file_delete(global.save_file);

	// Set level progress and version number
	var map = ds_map_create();
	ds_map_add(map, "version", global.version);
	ds_map_add(map, "level", global.level);

	// Save information
	return ds_map_secure_save(map, global.save_file);
}
