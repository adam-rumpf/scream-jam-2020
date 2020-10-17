/// @desc Listen for in-game events.

// Listen for player to each goal (on goal coordinates and not moving)
if ((global.player_dx == 0.0) && (global.player_dy == 0.0) && (global.player_x == level.goal[0]) && (global.player_y == level.goal[1]))
{
	// Show player's exit animation
	player.win();
}
