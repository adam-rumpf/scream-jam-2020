/// @func _intensity_schedule()
/// @desc Determines the global intensity level for a given step number depending on the room.

function _intensity_schedule()
{
	// Determine intensity depending on room
	switch room
	{
		//### Customize other rooms.
		default:
			if (global.moves < 10)
				global.intensity = 0;
			else if (global.moves < 20)
				global.intensity = 1;
			else if (global.moves < 30)
				global.intensity = 2;
			else
				global.intensity = 3;
			break;
	}
}
