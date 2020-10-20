/// @desc Set timer for room transition and begin to play room sound.

alarm[0] = 5*room_speed;
global.first_time = false; // prevent message from being seen until next room

// Begin playing sound
wind = audio_play_sound(snd_wind, 10, true);
audio_sound_gain(wind, global.sound, 0);
