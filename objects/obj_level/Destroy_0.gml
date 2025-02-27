/// @desc Destroy tile and sound objects when the level is destroyed.

audio_stop_sound(goal_sound);

while (ds_map_size(tiles) > 0)
{
	// Get first tile object, destroy it, and delete the map entry
	var key = ds_map_find_first(tiles);
	instance_destroy(tiles[? key]);
	ds_map_delete(tiles, key);
}

ds_map_destroy(tiles);
ds_map_destroy(visible_tiles);
