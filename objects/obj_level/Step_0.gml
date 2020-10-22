/// @desc Play sound to indicate distance to goal.

// Do nothing outside level rooms
if (_level_room() == false)
{
	audio_sound_gain(goal_sound, 0, 50);
	exit;
}

// Move intermediate intensity variable towards current intensity
if (dts < global.ts_intensity)
	dts = min(dts + 0.05, global.ts_intensity);
else if (dts > global.ts_intensity)
	dts = max(dts - 0.05, global.ts_intensity);

// Separate procedure for final room
if (global.level == 4)
{
	// Set sound level depending on y-coordinate
	var gain = clamp(max(global.player_y - 5, 0)/30, 0, 0.6);
	audio_sound_gain(goal_sound, global.sound*gain, 50);
}
else
{
	// Set sound level depending on distance to goal
	var dist, gain;
	dist = max(abs(global.player_x - goal[0]), abs(global.player_y - goal[1]));
	if (global.level == 3)
		gain = clamp(1 - sqrt(dist/10), 0, 0.6);
	else
		gain = clamp(1 - sqrt(sqrt(dist/20)), 0, 0.6);
	audio_sound_gain(goal_sound, global.sound*gain, 50);
}
