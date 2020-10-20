/// @desc Set timer until room transitions and play static sound.

alarm[0] = 0.75*room_speed;
noise = audio_play_sound(snd_static, 10, true);
audio_sound_gain(noise, global.sound, 0);
