/// @desc Initialize level.

/*
 * A level object is created when a new level begins and destroyed when it ends (due to completion or death).
 * The object is persistent so that the level can be maintained in memory while in the menu room.
 * This object serves three main purposes: determining the player's start coordinate, defining the terrain function, and storing the tile objects.
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
 * ###Randoized levels are defined according to a small number of random parameters.
 *
 * Tile objects:
 * Tile-specific information is stored in tile objects.
 * In order to avoid having to generate too many tiles, we maintain an unordered map of explored tiles, indexed by coordinate strings "x,y".
 * Whenever we need to gather information from a tile, we look up its key "x,y" to see whether it has been visited.
 */

// Set random seed for level
global.seed = randomize();

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
		var tile = instance_create_layer(xx, yy, "Instances", obj_tile);//###
		tiles[? key] = tile;
		return tile;
	}
}

//Define level attributes

// Initialize tile object map
tiles = ds_map_create();

// Generate level
//###

// Set player coordinates
//###
get_tile(global.player_x, global.player_y);

// Explore tiles around player
for (var i = -1; i <= 1; i++)
{
	for (var j = -1; j <= 1; j++)
	{
		if ((i == 0) && (j == 0))
			continue;
		get_tile(global.player_x+i, global.player_y+j);
	}
}

// Initialize most extreme explored coordinates
northernmost = global.player_y + 1;
easternmost = global.player_x + 1;
southernmost = global.player_y - 1;
westernmost = global.player_x - 1;
