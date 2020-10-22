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
		
		// SA
		case 1:
			
			// Set goal and slightly randomize
			goal = [45, 25];
			goal[0] += irandom_range(-5, 5);
			goal[1] += irandom_range(-10, 10);
			
			// Initialize peaks
			mag = array_create(7);
			xc = array_create(7);
			yc = array_create(7);
			xscale = array_create(7);
			yscale = array_create(7);
			
			// Define first two peaks to correspond to goal
			mag[0] = 3.0;
			mag[1] = 3.0;
			xc[0] = goal[0];
			xc[1] = goal[0];
			yc[0] = goal[1];
			yc[1] = goal[1];
			xscale[0] = 0.0005;
			xscale[1] = 0.05;
			yscale[0] = 0.0005;
			yscale[1] = 0.05;
			
			// Define a few intermediate peaks
			for (var i = 2; i < 7; i++)
			{
				mag[i] = 0.5;
				xscale[i] = 0.05;
				yscale[i] = 0.05;
			}
			mag[6] = 0.25;
			xc[2] = 10;
			yc[2] = 10;
			xc[3] = 15;
			yc[3] = 20;
			xc[4] = 20;
			yc[4] = 20;
			xc[5] = 25;
			yc[5] = 25;
			xc[6] = 25;
			yc[6] = 30;
			
			// Slightly randomize coordinates
			for (var i = 2; i < 7; i++)
			{
				mag[i] += random_range(-0.05, 0.05);
				xc[i] += irandom_range(-4, 4);
				yc[i] += irandom_range(-4, 4);
				xscale[i] += random_range(-0.01, 0.03);
				yscale[i] += random_range(-0.01, 0.03);
			}
			
			break;
		
		// TS
		case 2:
			
			// Set goal and slightly randomize
			goal = [35, 20];
			goal[0] += irandom_range(-5, 5);
			goal[1] += irandom_range(-10, 10);
			
			// Initialize peaks
			mag = array_create(6);
			xc = array_create(6);
			yc = array_create(6);
			xscale = array_create(6);
			yscale = array_create(6);
			
			// Define first two peaks to correspond to goal
			mag[0] = 3.0;
			mag[1] = 3.0;
			xc[0] = goal[0];
			xc[1] = goal[0];
			yc[0] = goal[1];
			yc[1] = goal[1];
			xscale[0] = 0.0005;
			xscale[1] = 0.05;
			yscale[0] = 0.0005;
			yscale[1] = 0.05;
			
			// Define a few intermediate peaks
			for (var i = 2; i < 6; i++)
			{
				mag[i] = 0.5;
				xscale[i] = 0.05;
				yscale[i] = 0.05;
			}
			mag[2] = 0.75;
			xc[2] = 15 + irandom_range(-4, 4);
			yc[2] = 15 + irandom_range(-6, 6);
			xc[3] = goal[0] + 2;
			yc[3] = goal[1] - 10;
			xc[4] = goal[0] - 8;
			yc[4] = goal[1] - 6;
			xc[5] = goal[0] - 6;
			yc[5] = goal[1] + 4;
			
			// Slightly randomize coordinates
			for (var i = 3; i < 6; i++)
			{
				mag[i] += random_range(-0.05, 0.05);
				xc[i] += irandom_range(-3, 3);
				yc[i] += irandom_range(-3, 3);
				xscale[i] += random_range(-0.01, 0.03);
				yscale[i] += random_range(-0.01, 0.03);
			}
			
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
