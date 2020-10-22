/// @func _peak_parameters(seed)
/// @desc Generates arrays of parameters for defining the peak functions for a given seed.
/// @param {int} seed Random seed for the current level.
/// @return {real[][]} Array of parameter arrays, respectively including: magnitudes, x-centers, y-centers, x-scaling, y-scaling, goal.

function _peak_parameters(seed)
{
	// Seed RNG
	random_set_seed(seed);
	
	// Generate parameters depending on the room
	var mag, xc, yc, xscale, yscale, goal;
	switch global.level
	{
		//### Add more cases for specific rooms.
		
		// Intro level
		case 0:
			
			// Set goal and slightly randomize
			goal = [15, 12];
			goal[0] += irandom_range(-3, 3);
			goal[1] += irandom_range(-2, 2);
			
			// Define peaks corresponding to goal
			mag = [2.0, 2.0];
			xc = [goal[0], goal[0]];
			yc = [goal[1], goal[1]];
			xscale = [0.0005, 0.05];
			yscale = [0.0005, 0.05];
			
			break;
		
		// Random level
		default:
			//### Temporary generation (replace with a random process).
			mag = [1.0];
			xc = [6];
			yc = [3];
			xscale = [0.05];
			yscale = [0.05];
			goal = [xc[0], yc[0]];
			break;
	}
	
	// Reset seed
	random_set_seed(seed);
	
	// Return arrays
	return [mag, xc, yc, xscale, yscale, goal];
}
