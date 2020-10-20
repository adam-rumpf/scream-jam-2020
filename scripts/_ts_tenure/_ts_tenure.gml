/// @func _ts_tenure()
/// @desc Determines TS tenures depending on intensity.

function _ts_tenure()
{
	// Do nothing if not active
	if (global.ts_intensity == 0)
		exit;
	
	// Determine tenure depending on intensity
	var tenure;
	switch global.ts_intensity
	{
		case 1:
			tenure = 3;//###
			break;
		case 2:
			tenure = 6;//###
			break;
		case 3:
			tenure = 9;//###
			break;
		default:
			tenure = 0;
			break;
	}
	
	return tenure;
}