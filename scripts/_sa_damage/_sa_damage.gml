/// @func _sa_damage(diff)
/// @desc Deals damage from the SA enemies depending on objective value difference and intensity.
/// @param {int} diff Difference between player's objective and new tile's objective.

function _sa_damage(diff)
{
	// Clamp difference
	var d = clamp(abs(diff), 0, 10);
	
	// Determine damage depending on intensity
	switch global.intensity
	{
		case 1:
			health -= d;
			break;
		case 2:
			health -= 2*d;
			break;
		case 3:
			health -= 4*d;
			break;
	}
}
