/// @func _intensity_schedule()
/// @desc Determines the global intensity level for a given step number depending on the room.

function _intensity_schedule()
{
	// Determine intensity depending on room
	switch global.level
	{
		// Intro and final (no intensity)
		case 0:
		case 4:
			global.sa_intensity = 0;
			global.ts_intensity = 0;
			break;
		
		// SA
		case 1:
			
			// No TS
			global.ts_intensity = 0;
			
			// SA increases over time
			if (global.moves < 10)
				global.sa_intensity = 0;
			else if (global.moves < 20)
				global.sa_intensity = 1;
			else if (global.moves < 30)
				global.sa_intensity = 2;
			else
				global.sa_intensity = 3;
			
			break;
			
		
		//### Customize other rooms.
		default:
			if (global.moves < 10)
			{
				global.sa_intensity = 0;
				global.ts_intensity = 0;
			}
			else if (global.moves < 20)
			{
				global.sa_intensity = 1;
				global.ts_intensity = 1;
			}
			else if (global.moves < 30)
			{
				global.sa_intensity = 2;
				global.ts_intensity = 2;
			}
			else
			{
				global.sa_intensity = 3;
				global.ts_intensity = 3;
			}
			break;
	}
}
