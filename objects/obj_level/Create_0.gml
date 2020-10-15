/// @desc Initialize level.

/*
 * A level object is created when a new level begins and destroyed when it ends (due to completion or death).
 * The object is persistent so that the level can be maintained in memory while in the menu room.
 * It also draws the background tiles (while within game rooms).
 *
 * This object serves three main storage purposes: determining the player's start coordinate, defining the terrain function, and storing the tile objects.
 * The game takes place on a potentially infinite grid of tiles, each with its own elevation and other attributes.
 * The elevation function and tile map allow us to generate only the visited tiles to save memory.
 *
 * Elevation function:
 * The elevation function should map each tile coordinate to an elevation value.
 * All elevations are nonnegative integers that represent the objective value of the coordinate, with higher being better.
 * In-game the elevations are essentially treated as being negative, with higher elevations being displayed and listed as lower, to go with the "descent" goal.
 * The elevation function is a sum of various coordinate-dependent noise functions as well as seed-dependent random noise.
 * Tile elevation should be deterministic for a given coordinate and seed.
 * Most levels have a predefined elevation function, subject to some random noise.
 * The function is defined by a set of parameters stored by this object.
 * ###Randoized levels are defined according to a small number of random parameters.
 *
 * Tile objects:
 * Tile-specific information is stored in tile objects.
 * In order to avoid having to generate too many tiles, we maintain an unordered map of explored tiles, indexed by coordinate strings "x,y".
 * Whenever we need to gather information from a tile, we look up its key "x,y" to see whether it has been visited.
 */

// Perform initial level setup

// Set random seed for level
global.seed = randomize();

// Determine whether to mirror or rotate the level
hmirror = choose(true, false); // whether to horizontally mirror
vmirror = choose(true, false); // whether to vertically mirror
rotate = choose(0, 1, 2, 3); // increment of 90 degree rotation

// Initialize tile object map
tiles = ds_map_create();

// Initialize unordered map of visible tiles (for use in the draw event; updated upon player movement)
visible_tiles = ds_map_create();
visible_vrad = ceil((room_height/global.tile_size)/2) + 1; // number of tiles above/below player to draw
visible_hrad = ceil((room_width/global.tile_size)/2) + 1; // number of tiles left/right of player to draw
var rad = 2; // initial exploration radius

// Define level methods

/// @func tile_key(x, y)
/// @desc Returns the tile map key for a given coordinate.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {string} Key to access the tile at coordinates (x,y) in the tile object list.

tile_key = function(xx, yy)
{
	return string(xx) + "," + string(yy);
}

/// @func tile_explored(x, y)
/// @desc Determines whether a given tile has been explored yet (i.e. whether it has an entry in the tile object map).
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {bool} True if the tile has been explored, and false otherwise.

tile_explored = function(xx, yy)
{
	// Check whether the tile key exists in the map
	return ds_map_exists(tiles, tile_key(xx, yy));
}

/// @func get_tile(x, y)
/// @desc Retrieves a given tile from the tile object map, generating a new one if it hasn't been explored yet.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {obj_tile} Tile object at coordinate (x,y).

get_tile = function(xx, yy)
{
	// Generate tile key
	var key = tile_key(xx, yy);
	
	// Determine whether the tile exists already
	if (tile_explored(xx, yy) == true)
	{
		// If so, return the object
		return tiles[? key];
	}
	else
	{
		// Otherwise generate a new tile and add it to the map
		var tile = instance_create_layer(xx, yy, "Instances", obj_tile); // create a new tile object
		tile.elevation = calculate_elevation(xx, yy); // set tile's elevation
		tile.image_index = irandom_range(0, sprite_get_number(spr_tile)-1); // set random image index
		tile.image_yscale = choose(1, -1); // randomize horizontal sprite mirroring
		tile.image_xscale = choose(1, -1); // randomize vertical sprite mirroring
		tile.image_angle = choose(0, 90, 180, 270); // randomize sprite rotation
		tiles[? key] = tile; // add tile to map
		return tile;
	}
}

/// @func tile_seed(x, y)
/// @desc Generates an RNG seed unique to a given tile for the current global seed.
/// @param {int} x-coordinate of tile.
/// @param {int} y-coordinate of tile.
/// @return {int} Random seed unique to the tile at (x,y), for use in generating deterministic values for the tile.

tile_seed = function(xx, yy)
{
	// Seed based on the global seed and a unique natural number assigned to each coordinate
	return global.seed + _pair_to_natural(_integer_to_natural(xx), _integer_to_natural(yy));
}

/// @func base_terrain(x, y)
/// @desc Defines the underlying (deterministic) terrain elevation for a given coordinate, based on the current level.
/// @param {int} x-coordinate of tile.
/// @param {int} y-coordinate of tile.
/// @return {real} Base elevation of the tile at (x,y).

base_terrain = function(_x, _y)
{
	// Get coordinates
	var xx = _x;
	var yy = _y;
	
	// Remap coordinates according to transformations
	if (vmirror == true)
		xx = -xx;
	if (hmirror == true)
		yy = -yy;
	switch rotate
	{
		case 1:
			xx = -yy;
			yy = xx;
			break;
		case 2:
			xx = -xx;
			yy = -yy;
			break;
		case 3:
			xx = yy;
			yy = -xx;
			break;
	}
	
	// Define base elevation of coordinate depending on room
	//###
	return 10.0;
}

/// @func wave_noise(x, y)
/// @desc Defines a wave-like part of the terrain's random noise (which is a sum of sinusoidal functions), normalized to be between 0 and 1.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {real} Change in elevation of the tile at (x,y) caused by the wave component of the noise.

wave_noise = function(xx, yy)
{
	// Seed RNG for current tile
	random_set_seed(tile_seed(xx, yy));
	
	// Generate an array of slightly randomized frequencies and offsets
	var n = 8; // half the number of terms
	var freq = array_create(2*n);
	var offset = array_create(2*n);
	for (var i = 0; i < 2*n; i++)
	{
		freq[i] = 0.01 * random_range(0.095, 0.105) * power(2, 0.5*(i % n));
		offset[i] = random_range(-8, 8);
	}
	
	// Add sinusoidal functions
	var total = 0.0;
	for (var i = 0; i < n; i++)
		total += sin(freq[i]*xx + offset[i]) + sin(freq[n+i]*yy + offset[n+i]);
	
	// Return normalized sum
	return total/(2*n);
}

/// @func random_noise(x, y)
/// @desc Defines the completely random part of the terrain's random noise (which may be positive or negative).
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {real} Change in elevation of the tile at (x,y) caused by the completely random component of the noise.

random_noise = function(xx, yy)
{
	// Seed RNG for current tile
	random_set_seed(tile_seed(xx, yy));
	
	// Choose a random integer between -2 and 2, with more extreme values being less frequent
	var val = [-2, -1, 0, 1, 2]; // possible noise values
	var wt = [1, 3, 5, 3, 1]; // probabilistic weight of each value
	return val[_random_weighted_index(wt)];
}

/// @func calculate_elevation(x, y)
/// @desc Calculates the elevation for a given tile by adding the deterministic part to the various noise layers.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {int} Elevation of the tile at (x,y).

calculate_elevation = function(xx, yy)
{
	// Evaluate and then round a weightd sum of the deterministic part and the random parts
	return floor(base_terrain(xx, yy) + 8*wave_noise(xx, yy) + random_noise(xx, yy));
}

/// @func update_visible(dx, dy)
/// @desc Updates the set of visible tiles when the player moves.
/// @param {int} dx Change in player's x-coordinate (+/- 1).
/// @param {int} dy Change in player's y-coordinate (+/- 1).

update_visible = function(dx, dy)
{
	// Left movement
	if (dx < 0)
	{
		// Hide 
	}
}

//Define level attributes

// Generate parameters for level terrain
//### peak centers, sine/cosine coefficients, reflection/rotation, etc.

// Set player coordinates
//### setting the value of global.player_x and global.player_y

// Initialize most extreme explored coordinates
northernmost = global.player_y + rad;
easternmost = global.player_x + rad;
southernmost = global.player_y - rad;
westernmost = global.player_x - rad;

// Initialize most extreme elevations
max_explored = -infinity;
min_explored = infinity;
max_visible = -infinity;
min_visible = infinity;
max_neighborhood = -infinity;
min_neighborhood = infinity;

// Explore tiles around player
for (var i = -rad; i <= rad; i++)
{
	for (var j = -rad; j <= rad; j++)
	{
		// Generate tile
		var tile = get_tile(global.player_x+i, global.player_y+j);
		ds_map_add(visible_tiles, tile_key(i, j), tile); // all initial tiles are visible
		
		// Update extremes
		max_explored = max(max_explored, tile.elevation);
		min_explored = min(min_explored, tile.elevation);
		max_visible = max(max_visible, tile.elevation);
		min_visible = min(min_visible, tile.elevation);
		if ((abs(i) <= 1) && (abs(j) <= 1))
		{
			max_neighborhood = max(max_neighborhood, tile.elevation);
			min_neighborhood = min(min_neighborhood, tile.elevation);
		}
	}
}
