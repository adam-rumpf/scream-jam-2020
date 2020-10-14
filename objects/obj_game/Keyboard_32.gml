//### TEST CODE

var size = ds_map_size(level.tiles);
var key = ds_map_find_first(level.tiles);
var lst = [];
for (var i = 0; i < size; i++)
{
	var tile = level.tiles[? key];
	var xx = tile.x;
	var yy = tile.y;
	//lst[i] = level.wave_noise(xx, yy);
	lst[i] = tile.elevation;
	key = ds_map_find_next(level.tiles, key);
}
show_message(lst);



/*
var size = ds_map_size(inventory) ;
var key = ds_map_find_first(inventory);
for (var i = 0; i < size; i++;)
   {
   if key != "gold"
      {
      key = ds_map_find_next(inventory, key);
      }
   else break;
   }
   */
