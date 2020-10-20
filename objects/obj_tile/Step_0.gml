/// @desc Fade self or fog in or out.

// Fade self in
image_alpha = min(image_alpha + 0.01, 0.75);

// Consider enemy drawing only when required
if ((global.sa_intensity == 0) && (global.ts_intensity))
	exit;

// Fade in of if suboptimal or out otherwise
if (_sa_room() == true)
{
	if (suboptimal == true)
		fog = min(fog + 0.0015, 0.125);
	else
		fog = max(fog - 0.0015, 0);
}

// Fade in or out TS enemy
if (_ts_room() == true)
{
	if (is_tabu() == true)
		stalker = min(stalker + 0.015, 1);
	else
		stalker = max(stalker - 0.015, 0);
}
