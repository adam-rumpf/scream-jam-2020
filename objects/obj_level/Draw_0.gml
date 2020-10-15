/// @desc Draw tiles around player.

// Do nothing if on the menu screen
if (room == rm_menu)
	exit;

// Otherwise determine which tiles to draw (depending on which have been revealed and the player's current position)
//### The list should be recalculated only when the player moves, since it's a potentially expensive operation.
//### We should also be able to tell upon movement exactly which tiles will be entering or leaving the visible set.
