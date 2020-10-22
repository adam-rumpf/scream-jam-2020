/// @desc Destroy temporary room objects on room end.

if (player != undefined)
	instance_destroy(player);

// Stop music
audio_sound_gain(global.song, 0, 500);

// End final room sound (unless transitioning to final credits)
if ((room != rm_level_final) || (ending == false))
	audio_sound_gain(descent_sound, 0, 50);
