/// @desc Initialize button's selection attribute and set text and dimensions.

// Button listens for mouse clicks only when selected
selected = false;

// Set text attributes
label = "Sound: " + string(round(100*global.sound)) + "%";
image_xscale = 7;
image_yscale = 1;
image_alpha = 0.5;

// Spawn pointer buttons
instance_create_layer(x + 92, y, "Buttons", obj_sound_up);
instance_create_layer(x - 92, y, "Buttons", obj_sound_down);

// Sound sample
sample = audio_play_sound(snd_static, 10, true);
audio_sound_gain(sample, 0, 0);
