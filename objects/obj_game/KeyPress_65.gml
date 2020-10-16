//### A -- W
player.move_w(level.get_tile(global.player_x-1, global.player_y).elevation - level.get_tile(global.player_x, global.player_y).elevation);
level.update_visible(-1, 0);
level.explore_neighborhood();
