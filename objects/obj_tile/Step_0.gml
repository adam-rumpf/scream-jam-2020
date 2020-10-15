/// @desc Fade in.

if (image_alpha >= 0.75)
	exit;

image_alpha = min(image_alpha + 0.01, 1);
