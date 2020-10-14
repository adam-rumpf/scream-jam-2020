/// @desc Game initialization processes.

// Define global constants and variables
global.seed = randomize(); // random seed for current level (reset on level restart)
global.version = 0.1; // game version number (encoded in save files)
global.save_file = "save.dat"; // save file name
global.settings_file = "settings.ini"; // settings file name
global.tile_size = 32; // tile dimension (px)

// Load settings
global.sound = 0.5; // sound volume (0.0 to 1.0)
global.music = 0.5; // music volume (0.0 to 1.0)
_load_settings(); // attempt to load settings
_save_settings(); // overwrite settings file

// Load progress
global.level = 0; // level progress
_load_game(); // attempt to load progress
_save_game(); // overwrite save file

// Player attributes
global.player_x = 0; // player's grid coordinates (the player object, itself, is fixed in the center of the room)
global.player_y = 0;

//### Use level progress to decide how to begin the game

// Level-dependent variables
intensity = 0; // metaheuristic intensity (reset on level restart; controls various game mechanics)
health = 100.0; // player's current health
locked = true; // whether the player's movements are locked
new_level = true; // whether to generate a new level on entering the room
level = undefined; // level object which defines the current level's terrain

//### Temporarily move directly to the test room.
room_goto(rm_level_intro);
