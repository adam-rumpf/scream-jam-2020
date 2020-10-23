/// @desc Listen for in-game events.

// Final level procedures
if (room == rm_level_final)
{
	// Initialize finale animation when player moves far enough
	if (global.player_y >= 30)
	{
		global.ending = true;
		
		// Delete menu button
		if (menu_button != undefined)
			instance_destroy(menu_button);

		// Force player to move south
		if ((global.player_dx == 0.0) || (global.player_dy == 0.0))
		{
			player.slip_s();
			level.update_visible(0, 1);
			level.explore_neighborhood();
		}
		
		// After going far enough south, change rooms
		if (global.player_y >= 80)
			room_goto(rm_ending);
	}
	
	// Set sound level depending on y-coordinate
	var gain = clamp(max(global.player_y - 5, 0)/30, 0, 0.75);
	audio_sound_gain(descent_sound, global.sound*gain, 50);
}

// Move health display towards player health
if (health < health_display)
	health_display = max(health_display - 1, health);
else if (health > health_display)
	health_display = min(health_display + 1, health);

// Listen for escape key press
if (keyboard_check_pressed(vk_escape))
	game_end();

// Listen for level victory
if (global.victory == true)
{
	// Set up to go to a new level
	global.victory = false;
	global.new_level = true;
	global.first_time = true;
	global.wake_up = true;
	
	// Go to next room in sequence (unless at end)
	//### Replace this with a game reset if we don't get around to the random levels.
	//###global.level = min(global.level + 1, array_length(global.level_rooms) - 1);
	global.level = (global.level + 1) % array_length(global.level_rooms); //### Placeholder for looping
	global.next_room = global.level_rooms[global.level];
	
	// Save progress
	_save_game();
	
	// Go to next room (through transition room)
	room_goto(rm_static);
}

// Listen for player death
if (global.dead == true)
{
	// Restart with a newly-generated level
	global.new_level = true;
	global.wake_up = true;
	room_goto(rm_static);
}
