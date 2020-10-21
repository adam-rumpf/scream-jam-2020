/// @desc Play a random sound and reset the timer.

var sound = sounds[irandom_range(0, array_length(sounds)-1)];
var handle = audio_play_sound(sound, 5, false);
audio_sound_gain(handle, global.sound, 0);
alarm[0] = room_speed*irandom_range(10, 40);
