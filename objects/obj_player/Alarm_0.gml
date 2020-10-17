/// @desc Switch idle animation.

// Reset timer
randomize();
alarm[0] = irandom_range(room_speed*6, room_speed*18);

// Toggle animation state
if (sprite_index == spr_player_idle_01)
{
	// If currently default, choose a random animation
	sprite_index = choose(spr_player_idle_02);
	
	// Reset timer to end as soon as the non-standard animation is done
	alarm[0] = image_number/image_speed;
}
else
	// If non-default, go to default
	sprite_index = spr_player_idle_01;
