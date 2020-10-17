/// @func _center_pull(x[, slope])
/// @desc Defines a piecewise function on [0.0,1.0] that pushes values away from the center.
/// @param {real} x Input between 0.0 and 1.0.
/// @param {real} [slope=0.5] Slope to apply to linear functions (between 0.0 and 1.0; lower moves further away from center).
/// @return {real} Remapped value between 0.0 and 1.0.

function _center_pull(xx)
{
	// Get optional slope argument
	var slope = (argument_count > 1 ? argument[1] : 0.5);
	slope = clamp(slope, 0.0, 1.0);
	
	// Apply piecewise definition.
	var val; // output value
	if (xx < 0.5)
	{
		// Push down towards 0.0
		val = slope*x;
	}
	else if (xx > 0.5)
	{
		// Push up towards 1.0
		val = slope*x + 1 - slope;
	}
	else
	{
		// If exactly 0.5, leave as is
		val = 0.5;
	}
	
	// Return clamped result
	return clamp(val, 0.0, 1.0);
}
