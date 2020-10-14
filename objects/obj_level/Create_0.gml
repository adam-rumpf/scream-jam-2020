/// @desc Initialize level.

/*
 * A level object is created at the beginning of each level and destroyed at the end.
 * This object serves two main purposes: defining the terrain function, and storing the tile objects.
 *
 * Elevation function:
 * 
 *
 * Tile objects:
 * Tile-specific information is stored in tile objects.
 * In order to avoid having to generate too many tiles, we maintain an unordered map of explored tiles, indexed by coordinate strings "x,y".
 */

// Initialize tile object map
tiles = ds_map_create();
