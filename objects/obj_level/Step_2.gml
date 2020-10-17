/// @desc Listen for player to reach goal.

// Check that player is at correct coordinates and is not moving
if ((global.player_dx == 0.0) && (global.player_dy == 0.0) && (global.player_x == goal[0]) && (global.player_y == goal[1]))
	obj_player.win();
