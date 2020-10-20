/// @desc Update label to match sound value.

label = "Sound: " + string(round(100*global.sound)) + "%";

if (selected == true)
{
	audio_sound_gain(sample, global.sound, 250);
	selected = false;
}
else
	audio_sound_gain(sample, 0, 250);
