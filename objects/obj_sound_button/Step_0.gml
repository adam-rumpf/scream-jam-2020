/// @desc Update label to match sound value.

label = "Sound: " + string(round(100*global.sound)) + "%";

// Play a sample sound while selected
if (selected == true)
{
	//### Also phase out the global game music
	audio_sound_gain(sample, global.sound, 100);
	selected = false;
}
else
	audio_sound_gain(sample, 0, 100);
