/// @func _player_start(seed[, hmirror[, vmirror[, rotate[, rm]]]])
/// @desc Generates the starting coordinates for the player for a given room.
/// @param {int} seed Random seed for the current level.
/// @param {bool} [hmirror=false] Whether the room is horizontally mirrored.
/// @param {bool} [vmirror=false] Whether the room is vertically mirrored.
/// @param {int} [rotate=0] Increment of 90 degrees by which the room is rotated (0, 1, 2, or 3).
/// @param {room} [rm=room] Level room to generate starting coordinates for (defaults to current room).
/// @return {int[]} Ordered pair giving the player's starting (x,y) grid coordinates.

function _player_start(seed)
{
	// Get optional arguments
	var hmirror = (argument_count > 1 ? argument[1] : false);
	var vmirror = (argument_count > 2 ? argument[2] : false);
	var rotate = (argument_count > 3 ? argument[3] : 0);
	var rm = (argument_count > 4 ? argument[4] : room);
	
	// Seed RNG
	random_set_seed(seed);
	
	// Generate coordinates depending on the room
	var _x, _y;
	switch rm
	{
		//### Add more cases for specific rooms.
		
		// Random level
		default:
			//### Temporary generation (replace with a random process).
			_x = irandom_range(-1, 1);
			_y = irandom_range(-1, 1);
			break;
	}
	
	// Remap coordinates according to transformations
	var xx = _x;
	var yy = _y;
	if (vmirror == true)
		xx = -xx;
	if (hmirror == true)
		yy = -yy;
	switch rotate
	{
		case 1:
			var temp = xx;
			xx = -yy;
			yy = temp;
			break;
		case 2:
			xx = -xx;
			yy = -yy;
			break;
		case 3:
			var temp = xx;
			xx = yy;
			yy = -temp;
			break;
	}
	
	// Reset seed
	random_set_seed(seed);
	
	// Return arrays
	return [xx, yy];
}
