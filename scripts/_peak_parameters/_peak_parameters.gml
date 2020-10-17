/// @func _peak_parameters(seed[, rm])
/// @desc Generates arrays of parameters for defining the peak functions for a given seed.
/// @param {int} seed Random seed for the current level.
/// @param {room} [rm=room] Level room to generate noise for (defaults to current room).
/// @return {real[][]} Array of parameter arrays, respectively including: magnitudes, x-centers, y-centers, x scaling, y scaling.

function _peak_parameters(seed)
{
	// Get optional room argument
	var rm = (argument_count > 1 ? argument[1] : room);
	
	// Seed RNG
	random_set_seed(seed);
	
	// Generate parameters depending on the room
	var mag, xc, yc, xscale, yscale;
	switch rm
	{
		//### Add more cases for specific rooms.
		
		// Random level
		default:
			//### Temporary generation (replace with a random process).
			mag = [1.0];
			xc = [6];
			yc = [6];
			xscale = [0.05];
			yscale = [0.05];
			break;
	}
	
	// Reset seed
	random_set_seed(seed);
	
	// Return arrays
	return [mag, xc, yc, xscale, yscale];
}
