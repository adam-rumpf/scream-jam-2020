//### A -- W
player.move_w(-level.get_tile(global.player_x-1, global.player_y).elevation + global.player_elevation);
level.update_player_elevation();
level.update_visible(-1, 0);
level.explore_neighborhood();
