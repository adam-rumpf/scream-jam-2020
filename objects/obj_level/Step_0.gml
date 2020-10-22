/// @desc Play sound to indicate distance to goal.

// Do nothing outside level rooms
if (_level_room() == false)
{
	audio_sound_gain(goal_sound, 0, 50);
	exit;
}

// Separate procedure for finale room
if (room == rm_level_final)
{
	//###
}
else
{
	// Set sound level depending on distance to goal
	var dist = max(abs(global.player_x - goal[0]), abs(global.player_y - goal[1]));
	var gain = clamp(1 - sqrt(sqrt(dist/10)), 0, 0.6);
	audio_sound_gain(goal_sound, global.sound*gain, 50);
}
