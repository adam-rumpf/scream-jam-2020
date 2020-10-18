/// @desc Initialize button's attributes.

// Button listens for mouse clicks only when selected
selected = false;

// Set tile scale
image_xscale = 0.95*global.tile_scale;
image_yscale = 0.95*global.tile_scale;

// Make sprite invisible
image_alpha = 0;

// Link to the game object and to a specific direction (given by game object)
game = undefined; // game object
dx = 0; // movement in x-direction (-1, 0, or 1)
dy = 0; // movement in y-direction (-1, 0, or 1)
