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

// Fade out TS enemy
if (_ts_room() == true)
{
	// Appear as soon as player movement ends (stalker object shows walking animation in the meantime)
	if (is_tabu() == true)
	{
		if (stalker_show == true)
		{
			if ((global.player_dx == 0.0) && (global.player_dy == 0.0))
				stalker = 1;
		}
		else
			stalker_show = true;
	}
	else
	{
		stalker = max(stalker - 0.015, 0);
		stalker_show = false;
	}
}
