/// @desc Game initialization processes.

// Define global constants
global.version = 0.1; // game version number (encoded in save files)
global.save_file = "save.dat"; // save file name
global.settings_file = "settings.ini"; // settings file name
global.seed = randomize(); // random seed for current level (reset on level restart)
global.intensity = 0; // metaheuristic intensity (reset on level restart; controls various game mechanics)

// Load settings
global.sound = 0.5; // sound volume (0.0 to 1.0)
global.music = 0.5; // music volume (0.0 to 1.0)
_load_settings(); // attempt to load settings
_save_settings(); // overwrite settings file

// Load progress
global.level = 0; // level progress
_load_game(); // attempt to load progress
_save_game(); // overwrite save file

//### Temporarily move directly to the test room.
room_goto(rm_level_intro);
