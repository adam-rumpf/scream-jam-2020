//### W -- N
player.move_n(-level.get_tile(global.player_x, global.player_y-1).elevation + global.player_elevation);
level.update_player_elevation();
level.update_visible(0, -1);
level.explore_neighborhood();
