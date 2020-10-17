/// @func _peak(x, y, xc, yc[, xscale[, yscale]])
/// @desc Elevation function for a single peak with a given center and scale.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @param {int} xc x-coordinate of peak center.
/// @param {int} yc y-coordinate of peak center.
/// @param {real} [xscale=0.01] Scaling of x-direction distances (smaller value makes distribution wider).
/// @param {real} [yscale=0.01] Scaling of y-direction distances (smaller value makes distribution wider).
/// @return {real} Elevation of tile (x,y) due to the peak centered at (xc,yc), normalized to be between 0.0 and 1.0.

function _peak(xx, yy, xc, yc)
{
	// Get optional scale arguments
	var xscale = (argument_count > 4 ? argument[4] : 0.01);
	var yscale = (argument_count > 5 ? argument[5] : 0.01);
	
	// Calculate normalized exponential function value
	return exp(1/(xscale*sqr(xx - xc) + yscale*sqr(yy - yc) + 1))/exp(1);
}
