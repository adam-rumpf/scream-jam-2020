/// @desc Fade in.

if (image_alpha < 1)
	image_alpha = min(max(abs(global.player_dx), abs(global.player_dy)), 1);
