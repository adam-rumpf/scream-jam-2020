/// @desc Listen for in-game events (particularly the results of a player's move).

// Determine whether the player is currently moving
var moving = (global.player_dx != 0.0) || (global.player_dy != 0.0);

// Listen for player to reach goal (on goal coordinates and not moving)
if ((moving == false) && (global.player_x == level.goal[0]) && (global.player_y == level.goal[1]))
{
	// Show player's exit animation
	player.win();
}

// Listen for player health to reach zero (after movement ends)
if ((moving == false) && (health <= 0))
{
	// Show player's death animation
	player.die();
}
