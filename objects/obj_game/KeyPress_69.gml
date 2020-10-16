//### E -- NE
player.move_ne(level.get_tile(global.player_x+1, global.player_y-1).elevation - level.get_tile(global.player_x, global.player_y).elevation);
level.update_visible(1, -1);
level.explore_neighborhood();
