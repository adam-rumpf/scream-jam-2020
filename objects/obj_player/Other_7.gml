/// @desc Switch idle animation.

// Behavior depends on current animation
if (sprite_index != spr_player_idle_01)
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
		// Choose random animation
		sprite_index = choose(spr_player_idle_02);
	}
}
