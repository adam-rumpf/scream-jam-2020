/// @desc Destroy temporary room objects on room end.

if (player != undefined)
	instance_destroy(player);

// Stop music
audio_sound_gain(global.song, 0, 500);
