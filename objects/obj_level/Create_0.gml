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
 * The elevation of each tile is a weighted sum of three functions: peaks, wave noise, and random noise.
 * The peak component is a sum of Gaussian distributions centered at various points.
 * The wave function is a sum of sinusoidal functions with different frequencies.
 * The random noise is not coordinate-dependent and is drawn from a weighted distribution.
 * The peak and wave functions both depend on several arrays of parameters which are generated and stored by this object for the given random seed.
 *
 * Tile objects:
 * Tile-specific information is stored in tile objects.
 * In order to avoid having to generate too many tiles, we maintain an unordered map of explored tiles, indexed by coordinate strings "x,y".
 * Whenever we need to gather information from a tile, we look up its key "x,y" to see whether it has been visited.
 */

// Perform initial level setup

// Define colors used to indicate various elevations (as a color value for HSV)
c_visible_max = 60; // most extreme colors among all visible tiles (higher is colred darker)
c_visible_min = 5;
c_neighborhood_max = 230; // most extreme colors among all neighboring tiles (higher is colred darker)
c_neighborhood_min = 80;

// Set random seed for level
global.seed = randomize();

// Determine whether to mirror the level (to add variety to presets)
hmirror = choose(true, false); // whether to horizontally mirror
vmirror = choose(true, false); // whether to vertically mirror

// Initialize most extreme explored coordinates
max_y = -infinity;
min_y = infinity;
max_x = -infinity;
min_x = infinity;

// Initialize most extreme elevations
max_explored = -infinity;
min_explored = infinity;
max_visible = -infinity;
min_visible = infinity;
max_neighborhood = -infinity;
min_neighborhood = infinity;

// Initialize tile object map
tiles = ds_map_create();

// Initialize unordered map of visible tiles (for use in the draw event; updated upon player movement)
visible_tiles = ds_map_create();
var rad = 2; // initial exploration radius
visible_vrad = ceil((room_height/(global.tile_size*global.tile_scale))/2) + 1; // number of tiles above/below player to draw
visible_hrad = ceil((room_width/(global.tile_size*global.tile_scale))/2) + 1; // number of tiles left/right of player to draw

// Generate wave noise parameters
wave_terms = 8; // number of sine functions to add (more means higher frequencies)
wave_weight = 10; // multiplier for wave noise size
var param = _wave_parameters(global.seed, wave_terms);
wave_freq = param[0]; // random sinusoidal function frequencies
wave_offset = param[1]; // random sinusoidal function offsets

// Generate peak parameters for underlying terrain
peak_weight = 32; // multiplier for peak function values
var param = _peak_parameters(global.seed);
peak_magnitude = param[0]; // magnitude multiplier for each peak
peak_xc = param[1]; // x-coordinates of peak centers
peak_yc = param[2]; // y-coordinates of peak centers
peak_xscale = param[3]; // x-direction scaling of peak functions (smaller is wider)
peak_yscale = param[4]; // y-direction scaling of peak functions (smaller is wider)
goal = param[5]; // goal tile (should be global maximum)

// Define level methods

/// @func transform_coords(x, y)
/// @desc Transforms a tile coordinate according to the level's reflections.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {int[]} New coordinate of tile.

transform_coords = function(_x, _y)
{
	// Get coordinates
	var xx = _x;
	var yy = _y;
	
	// Remap coordinates according to transformations
	if (vmirror == true)
		xx = -xx;
	if (hmirror == true)
		yy = -yy;
	
	// Return new coordinates
	return [xx, yy];
}

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
/// @return {bool} True if the tile has been explored, false otherwise.

tile_explored = function(xx, yy)
{
	// Check whether the tile key exists in the map
	return ds_map_exists(tiles, tile_key(xx, yy));
}

/// @func tile_visible(x, y)
/// @desc Determines whether a given tile is currently visible (i.e. whether it has an entry in the visible tile map).
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {bool} True if the tile is visible, false otherwise.

tile_visible = function(xx, yy)
{
	// Check whether the tile key exists in the map
	return ds_map_exists(visible_tiles, tile_key(xx, yy));
}

/// @func get_tile(x, y)
/// @desc Retrieves a given tile from the tile object map, generating a new one (and updating the extreme tile lists) if it hasn't been explored yet.
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
		
		// Create tile
		var tile = instance_create_layer(xx, yy, "Instances", obj_tile); // create a new tile object
		tile.elevation = calculate_elevation(xx, yy); // set tile's elevation (also automatically seeds RNG for this tile)
		tile.image_index = _random_weighted_index([10, 10, 10, 1]); // set random image index // ### UPDATE WHEN TILES ARE REDONE
		tile.image_yscale *= choose(1, -1); // randomize horizontal sprite mirroring
		tile.image_xscale *= choose(1, -1); // randomize vertical sprite mirroring
		tile.image_angle = choose(0, 90, 180, 270); // randomize sprite rotation
		tiles[? key] = tile; // add tile to map
		
		// Update extreme tiles
		max_y = max(max_y, yy);
		min_y = min(min_y, yy);
		max_x = max(max_x, xx);
		min_x = min(min_x, xx);
		max_explored = max(max_explored, tile.elevation);
		min_explored = min(min_explored, tile.elevation);
		
		return tile;
	}
}

/// @func explore_neighborhood()
/// @desc Explores all tiles in the player's neighborhood, and updates the neighborhood extremes.

explore_neighborhood = function()
{
	// Reset neighborhood extremes
	max_neighborhood = -infinity;
	min_neighborhood = infinity;
	
	// Generate all tiles up to 1 tiles away from the player
	for (var i = -1; i <= 1; i++)
	{
		for (var j = -1; j <= 1; j++)
		{
			// Make or retrieve tile
			var tile = get_tile(global.player_x + i, global.player_y + j);
			
			// Update extremes
			max_neighborhood = max(max_neighborhood, tile.elevation);
			min_neighborhood = min(min_neighborhood, tile.elevation);
		}
	}
	
	// Update visibility
	update_visible();
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
/// @desc Defines the underlying (deterministic) terrain elevation for a given coordinate as a sum of peak functions defined by this object's parameter arrays.
/// @param {int} x-coordinate of tile.
/// @param {int} y-coordinate of tile.
/// @return {real} Base elevation of the tile at (x,y).

base_terrain = function(xx, yy)
{
	// Get transformed coordinates
	var coords = transform_coords(xx, yy);
	
	// Add peak functions
	var total = 0.0;
	for (var i = 0; i < array_length(peak_magnitude); i++)
		total += peak_magnitude[i]*_peak(coords[0], coords[1], peak_xc[i], peak_yc[i], peak_xscale[i], peak_yscale[i]);
	
	// Return sum
	return total;
}

/// @func wave_noise(x, y)
/// @desc Defines a wave-like part of the terrain's random noise as a sum of sinusoidal functions defined by this object's frequency and offset arrays.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {real} Change in elevation of the tile at (x,y) caused by the wave component of the noise, normalized to be between -1.0 and 1.0.

wave_noise = function(xx, yy)
{
	// Get half of array lengths
	var n = array_length(wave_freq)/2;
	
	// Add sinusoidal functions
	var total = 0.0;
	for (var i = 0; i < n; i++)
		total += sin(wave_freq[i]*xx + wave_offset[i]) + sin(wave_freq[n+i]*yy + wave_offset[n+i]);
	
	// Return normalized sum
	return total/(2*n);
}

/// @func random_noise(x, y)
/// @desc Defines the completely random part of the terrain's random noise (also re-seeds RNG for this tile).
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {real} Change in elevation of the tile at (x,y) caused by the completely random component of the noise.

random_noise = function(xx, yy)
{
	// Seed RNG for current tile
	random_set_seed(tile_seed(xx, yy));
	
	// Choose a random integer between -2 and 2, with more extreme values being less frequent
	var val = [-2, -1, 0, 1, 2]; // possible noise values
	var wt = [1, 3, 7, 3, 1]; // probabilistic weight of each value
	var noise = val[_random_weighted_index(wt)];
	
	return noise;
}

/// @func calculate_elevation(x, y)
/// @desc Calculates the elevation for a given tile by adding the deterministic part to the various noise layers.
/// @param {int} x x-coordinate of tile.
/// @param {int} y y-coordinate of tile.
/// @return {int} Elevation of the tile at (x,y).

calculate_elevation = function(xx, yy)
{
	// Evaluate and then round a weightd sum of the deterministic part and the random parts
	return floor(peak_weight*base_terrain(xx, yy) + wave_weight*wave_noise(xx,yy) + random_noise(xx, yy));
}

/// @func update_visible()
/// @desc Updates the set of visible tiles when the player moves, as well as the extreme visible elevations.

update_visible = function()
{
	// Reset visible extremes
	max_visible = -infinity;
	min_visible = infinity;
	
	// Remake visible tile list
	ds_map_clear(visible_tiles);
	for (var i = global.player_x - visible_hrad; i <= global.player_x + visible_hrad; i++)
	{
		for (var j = global.player_y - visible_vrad; j <= global.player_y + visible_vrad; j++)
		{
			// Skip unexplored tiles
			if (tile_explored(i, j) == false)
				continue;
			
			// Add the tile to the visible list and upate the extreme visible elevations
			var tile = get_tile(i, j);
			visible_tiles[? tile_key(i, j)] = tile;
			max_visible = max(max_visible, tile.elevation);
			min_visible = min(min_visible, tile.elevation);
		}
	}
}

/// @func is_neighbor(x, y[, center])
/// @desc Determines whether a given coordinate is a neighbor of the player's current tile.
/// @param {int} x x-coordiante of tile.
/// @param {int} y y-coordiante of tile.
/// @param {bool} [center=false] Whether or not to include the player's tile.
/// @return {bool} True if the specified tile is a neighbor of the player, and false otherwise.

is_neighbor = function(xx, yy)
{
	// Get optional center argument
	var center = (argument_count > 2 ? argument[2] : false);
	
	// Procedure depends on whether center is included
	if (center == true)
	{
		// If including center, verify that all coordinate differences are at most 1
		if ((abs(xx-global.player_x) <= 1) && (abs(yy-global.player_y) <= 1))
			return true;
	}
	else
	{
		// If not including center, verify that one coordinate difference is exactly 1 while the other is at most 1
		if (((abs(xx-global.player_x) == 1) && (abs(yy-global.player_y) <= 1)) || ((abs(xx-global.player_x) <= 1) && (abs(yy-global.player_y) == 1)))
			return true;
	}
	
	return false;
}

/// @func _explore_area(xrad, yrad)
/// @desc Explores a given area around the player (for testing purposes only).
/// @param {int} xrad Exploration radius in x-direction.
/// @param {int} yrad Exploration radius in y-direction.

_explore_area = function(xrad, yrad)
{
	for (var i = -xrad; i <= xrad; i++)
	{
		for (var j = -yrad; j <= yrad; j++)
		{
			// Make or retrieve tile
			var tile = get_tile(global.player_x + i, global.player_y + j);
			
			// Update extremes
			max_neighborhood = max(max_neighborhood, tile.elevation);
			min_neighborhood = min(min_neighborhood, tile.elevation);
		}
	}
	
	// Update visibility
	update_visible();
}

/// @func edge_fade(x, y)
/// @desc Determines how much to fade out elements as a function of their position on the screen.
/// @param {int} x x-coordinate within room.
/// @param {int} y y-coordinate within room.
/// @return {real} Opacity value between 0.0 and 1.0.

edge_fade = function(xx, yy)
{
	// Find limiting dimension
	var dim = min(room_width, room_height);
	
	// Find distance from center
	var dist = _vector_distance([room_width/2, room_height/2], [xx, yy]);
	
	// The middle quarter of the screen is full opacity, and outside of that the opacity scales linearly down to 0.25 at the closer edge
	if (dist <= dim/8)
		return 1.0;
	else
		return max(1.25 - (2*dist)/dim, 0.0);
}

/// @func map_array()
/// @desc Creates a rectangular array of all explored map elevations (with unexplored tiles as undefined).
/// @return {int[][]} 2D array of elevation values and undefined values.

map_array = function()
{
	// Initialize undefined array using most extreme known dimensions
	var w, h, arr;
	w = max_x - min_x + 1;
	h = max_y - min_y + 1;
	arr = array_create(h, array_create(w, undefined));
	
	// Add known elevations to the array
	for (var j = min_y; j <= max_y; j++)
	{
		for (var i = min_x; i <= max_x; i++)
		{
			// Skip unexplored tiles
			if (tile_explored(i, j) == false)
				continue;
			
			// Get elevations of explored tiles
			var tile = get_tile(i, j);
			arr[j-min_y][i-min_x] = tile.elevation;
		}
	}
	
	return arr;
}

/// @func update_player_elevation()
/// @desc Updates the global player elevation based on the player's current coordinates.

update_player_elevation = function()
{
	// Look up elevation of player's current tile
	global.player_elevation = get_tile(global.player_x, global.player_y).elevation;
}

// Define level attributes

// Remap goal to match level transformations
goal = transform_coords(goal[0], goal[1]);

// Set player coordinates and get initial elevation
var coords = _player_start(global.seed, hmirror, vmirror);
global.player_x = coords[0];
global.player_y = coords[1];
update_player_elevation();

// Explore tiles around player
explore_neighborhood();
for (var i = -rad; i <= rad; i++)
{
	for (var j = -rad; j <= rad; j++)
	{
		// Generate tile
		var tile = get_tile(global.player_x+i, global.player_y+j);
		ds_map_add(visible_tiles, tile_key(i, j), tile); // all initial tiles are visible
	}
}
update_visible();

//### Determine the global optimum
