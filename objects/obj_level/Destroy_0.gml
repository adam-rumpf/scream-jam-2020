/// @desc Destroy tile objects when the level is destroyed.

while (ds_map_size(tiles) > 0)
{
	// Get first tile object, destroy it, and delete the map entry
	var key = ds_map_find_first(tiles);
	instance_destroy(tiles[? key]);
	ds_map_delete(tiles, key);
}

ds_map_destroy(tiles);
