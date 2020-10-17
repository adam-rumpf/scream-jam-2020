/// @func _wave_parameters(seed[, n])
/// @desc Generates arrays of parameters for defining the wave noise function for a given seed.
/// @param {int} seed Random seed for the current level.
/// @param {int} [n=8] Number of terms (array length is 2n since two sine functions are used per cell).
/// @return {real[][]} Array of parameter arrays, respectively including: frequencies, offsets.

function _wave_parameters(seed)
{
	// Get optional term argument
	var n = (argument_count > 1 ? argument[1] : 8);
	
	// Seed RNG
	random_set_seed(seed);
	
	// Generate an array of slightly randomized frequencies and offsets
	var freq = array_create(2*n);
	var offset = array_create(2*n);
	for (var i = 0; i < 2*n; i++)
	{
		freq[i] = 0.01 * random_range(0.095, 1.05) * power(2, 0.5*(i % n) + 1);
		offset[i] = random_range(-8, 8);
	}
	
	// Reset seed
	random_set_seed(seed);
	
	// Return arrays
	return [freq, offset];
}
