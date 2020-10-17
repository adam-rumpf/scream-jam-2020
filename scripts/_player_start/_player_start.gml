/// @func _player_start(seed[, hmirror[, vmirror[, rotate[, rm]]]])
/// @desc Generates the starting coordinates for the player for a given room.
/// @param {int} seed Random seed for the current level.
/// @param {bool} [hmirror=false] Whether the room is horizontally mirrored.
/// @param {bool} [vmirror=false] Whether the room is vertically mirrored.
/// @param {room} [rm=room] Level room to generate starting coordinates for (defaults to current room).
/// @return {int[]} Ordered pair giving the player's starting (x,y) grid coordinates.

function _player_start(seed)
{
	// Get optional arguments
	var hmirror = (argument_count > 1 ? argument[1] : false);
	var vmirror = (argument_count > 2 ? argument[2] : false);
	var rm = (argument_count > 3 ? argument[3] : room);
	
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
	
	// Reset seed
	random_set_seed(seed);
	
	// Return arrays
	return [xx, yy];
}
