/// @desc Initialize button's selection attribute and set text and dimensions.

// Button listens for mouse clicks only when selected
selected = false;

// Set text attributes
label = "Music: " + string(round(100*global.music)) + "%";
image_xscale = 7;
image_yscale = 1;
image_alpha = 0.5;

// Spawn pointer buttons
instance_create_layer(x + 92, y, "Buttons", obj_music_up);
instance_create_layer(x - 92, y, "Buttons", obj_music_down);
