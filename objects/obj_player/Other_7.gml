/// @desc Switch idle animation.

// Behavior depends on current animation
switch sprite_index
{
	case spr_player_wake:
	
		// Go from waking animation to idle
		sprite_index = spr_player_idle_01;
		locked = false;
		
		break;
	
	case spr_player_idle_02:
	
		// Switch back to default if needed
		sprite_index = spr_player_idle_01;
		idle_loops = 0;
		
		break;
	
	case spr_player_idle_01:
		idle_loops++;
		if (idle_loops < 6)
			exit;
	
		// If default for long enough, there's a random chance to play an alternate
		if (random_range(0, 1) < 0.1)
		{
			// Show alternate animation
			sprite_index = spr_player_idle_02;
		}
		
		break;
	
	case spr_player_exit:
	
		// Game object step event listens for victory and handles level ending
		global.victory = true;
		
		break;
	
	case spr_player_death_01:
	case spr_player_death_02:
	
		// Game object listens for death status and handles level restart
		global.dead = true;
		
		break;
}
