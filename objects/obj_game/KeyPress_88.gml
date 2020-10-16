//### X -- S
player.move_s(level.get_tile(global.player_x, global.player_y+1).elevation - level.get_tile(global.player_x, global.player_y).elevation);
level.update_visible(0, 1);
level.explore_neighborhood();
