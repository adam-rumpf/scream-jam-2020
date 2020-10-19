/// @func _save_settings(fname)
/// @desc Saves game settings (and creates a new INI file if none exists).
/// @return {bool} Returns true if successful.

function _save_settings()
{
	// Clear file
	if (file_exists(global.settings_file) == true)
		file_delete(global.settings_file);

	// Set sound and music values
	ini_open(global.settings_file);
	ini_write_real("audio", "sound", global.sound);
	ini_write_real("audio", "music", global.music);
	
	// Set screen values
	ini_write_real("video", "fullscreen", global.fullscreen);
	
	ini_close();
	
	return true;
}
