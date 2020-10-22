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
			if (global.moves < 15)
				global.sa_intensity = 0;
			else if (global.moves < 30)
				global.sa_intensity = 1;
			else if (global.moves < 45)
				global.sa_intensity = 2;
			else
				global.sa_intensity = 3;
			
			break;
		
		// TS
		case 2:
			
			// No SA
			global.sa_intensity = 0;
			
			// TS increases over time
			if (global.moves < 7)
				global.ts_intensity = 0;
			else if (global.moves < 28)
				global.ts_intensity = 1;
			else if (global.moves < 42)
				global.ts_intensity = 2;
			else
				global.ts_intensity = 3;
			
			break;
		
		// Hybrid
		case 3:
			
			// SA comes and goes in waves
			var offset = 10;
			var period = 50;
			if (global.moves < offset)
				global.sa_intensity = 0;
			else if ((global.moves - offset) % period < period/5)
				global.sa_intensity = 1;
			else if ((global.moves - offset) % period < 2*period/5)
				global.sa_intensity = 2;
			else if ((global.moves - offset) % period < 3*period/5)
				global.sa_intensity = 3;
			else if ((global.moves - offset) % period < 4*period/5)
				global.sa_intensity = 2;
			else
				global.sa_intensity = 1;
			
			// TS increases over time
			if (global.moves < 15)
				global.ts_intensity = 0;
			else if (global.moves < 30)
				global.ts_intensity = 1;
			else if (global.moves < 45)
				global.ts_intensity = 2;
			else
				global.ts_intensity = 3;
			
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
