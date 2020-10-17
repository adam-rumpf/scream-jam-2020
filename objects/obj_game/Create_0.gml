/// @desc Game initialization processes.

// Define global constants and variables
global.seed = randomize(); // random seed for current level (reset on level restart)
global.version = 0.1; // game version number (encoded in save files)
global.save_file = "save.dat"; // save file name
global.settings_file = "settings.ini"; // settings file name
global.tile_size = 32; // tile dimension (px)
global.tile_scale = 2; // tile scaling

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
global.player_dx = 0.0; // player's position relative to their starting position during intermediate movement (between -1 and 1)
global.player_dy = 0.0;

//### Use level progress to decide how to begin the game

// Level-dependent variables
intensity = 0; // metaheuristic intensity (reset on level restart; controls various game mechanics)
health = 100.0; // player's current health
global.new_level = true; // whether to generate a new level on entering the room
level = undefined; // level object which defines the current level's terrain
player = undefined; // player object which handles some player-specific actions

// Spawn camera object
camera = instance_create_layer(0, 0, "Instances", obj_camera);

//### Temporarily move directly to the test room.
room_goto(rm_level);
