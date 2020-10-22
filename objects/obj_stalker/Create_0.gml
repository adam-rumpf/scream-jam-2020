/// @desc Set sprite attributes.

/*
 * This object is spawned by the game object to temporarily show the stalker enemy.
 * This object's sprite shows the stalker walking to occupy the player's previous tile.
 * After the player's movement ends, this object is destroyed.
 */

image_xscale = global.tile_scale;
image_yscale = global.tile_scale;
image_speed = 0.4;
image_alpha = 0; // begin invisible

// Set an alarm to play a sound after a slight delay
alarm[0] = irandom_range(10, 15);

/// @func set_sprite(dx, dy)
/// @desc Sets sprite (called by game object).
/// @param {int} dx x-component of player movement (-1, 0, or 1).
/// @param {int} dy y-component of player movement (-1, 0, or 1).

set_sprite = function(dx, dy)
{
	// Set sprite direction (as a multiple of 90 degrees) based on relative movement
	var dir;
	if (abs(dy) > 0)
	{
		// Vertical sprite
		if (dy > 0)
			dir = 3;
		else
			dir = 1;
	}
	else
	{
		// Horizontal sprite
		if (dx > 0)
			dir = 0;
		else
			dir = 2;
	}
	
	// Determine sprite based on intensity and direction
	switch global.ts_intensity
	{
		case 1:
			
			switch dir
			{
				case 0:
					sprite_index = spr_stalker_01_walk_e;
					break;
				case 1:
					sprite_index = spr_stalker_01_walk_n;
					break;
				case 2:
					sprite_index = spr_stalker_01_walk_w;
					break;
				case 3:
					sprite_index = spr_stalker_01_walk_s;
					break;
			}
			break;
		
		case 2:
			
			switch dir
			{
				case 0:
					sprite_index = spr_stalker_02_walk_e;
					break;
				case 1:
					sprite_index = spr_stalker_02_walk_n;
					break;
				case 2:
					sprite_index = spr_stalker_02_walk_w;
					break;
				case 3:
					sprite_index = spr_stalker_02_walk_s;
					break;
			}
			break;
		
		case 3:
			
			if (global.bloodless == false)
			{
				switch dir
				{
					case 0:
						sprite_index = spr_stalker_03_walk_e;
						break;
					case 1:
						sprite_index = spr_stalker_03_walk_n;
						break;
					case 2:
						sprite_index = spr_stalker_03_walk_w;
						break;
					case 3:
						sprite_index = spr_stalker_03_walk_s;
						break;
				}
			}
			else
			{
				switch dir
				{
					case 0:
						sprite_index = spr_stalker_03_alt_walk_e;
						break;
					case 1:
						sprite_index = spr_stalker_03_alt_walk_n;
						break;
					case 2:
						sprite_index = spr_stalker_03_alt_walk_w;
						break;
					case 3:
						sprite_index = spr_stalker_03_alt_walk_s;
						break;
				}
			}
			break;
	}
}
