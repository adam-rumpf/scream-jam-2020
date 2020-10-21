/// @desc Initialize color and timer, and play sound.

// Attributes set by spawning object
col = c_white; // color to display
timer = 1; // steps until screen disappears

// Play sound
var sound = audio_play_sound(snd_damage, 30, false);
audio_sound_gain(sound, global.sound, 0);
