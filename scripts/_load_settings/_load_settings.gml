/// @func _load_settings()
/// @desc Loads game settings (if the INI file exists).
/// @return {bool} Returns true if successful.

function _load_settings()
{
	// Proceed only if the file exists
	if (file_exists(global.settings_file) == true)
	{
		// Get sound and music values
		ini_open(global.settings_file);
		global.sound = ini_read_real("audio", "sound", global.sound);
		global.music = ini_read_real("audio", "music", global.music);
		
		// Get screen values
		global.fullscreen = bool(ini_read_real("video", "fullscreen", global.fullscreen));
		if (window_get_fullscreen() != global.fullscreen)
			window_set_fullscreen(global.fullscreen);
		
		ini_close();

		return true;
	}
	else
		return false;
}
