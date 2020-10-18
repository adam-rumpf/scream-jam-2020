/// @desc Fade self or fog in or out.

// Fade self in
image_alpha = min(image_alpha + 0.01, 0.75);

// Consider fog only if the level requires it
if ((_sa_room() == false) || (global.intensity <= 0))
	exit;

// Fade in if suboptimal or out otherwise
if (suboptimal == true)
	fog = min(fog + 0.0015, 0.125);
else
	fog = max(fog - 0.0015, 0);
