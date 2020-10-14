/// @func _load_game()
/// @desc Loads game progress (if the save file exists).
/// @return {bool} Returns true if successful.

function _load_game()
{
	// Proceed only if the file exists
	if (file_exists(global.save_file) == true)
	{
		// Get level progress and version number
		var map = ds_map_secure_load(global.save_file);
		global.version = real(ds_map_find_value(map, "version"));
		global.level = int64(ds_map_find_value(map, "level"));

		return true;
	}
	else
		return false;
}
