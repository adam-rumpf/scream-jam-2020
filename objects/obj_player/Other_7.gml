/// @desc Switch idle animation.

// Behavior depends on current animation
if (sprite_index == spr_player_idle_02)
{
	// Switch back to default if needed
	sprite_index = spr_player_idle_01;
	idle_loops = 0;
}
else
{
	idle_loops++;
	if (idle_loops < 6)
		exit;
	
	// If default for long enough, there's a random chance to play an alternate
	if (random_range(0, 1) < 0.1)
	{
		// Show alternate animation
		sprite_index = spr_player_idle_02;
	}
}
