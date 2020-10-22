/// @desc Play a pitch-shifted walking sound.

var sound = audio_play_sound(snd_walk_fast, 4, false);
var gain, pitch;

// Set audio attributes depending on intensity
switch global.ts_intensity
{
	case 1:
		gain = 0.1*global.sound;
		pitch = random_range(0.6, 0.7);
		break;
	case 2:
		gain = 0.25*global.sound;
		pitch = random_range(0.525, 0.625);
		break;
	case 3:
		gain = 0.4*global.sound;
		pitch = random_range(0.45, 0.55);
		break;
	default:
		gain = 0.1*global.sound;
		pitch = random_range(0.6, 0.7);
}

audio_sound_gain(sound, gain, 0);
audio_sound_pitch(sound, pitch);
