//### E -- NE
player.move_ne(-level.get_tile(global.player_x+1, global.player_y-1).elevation + global.player_elevation);
level.update_player_elevation();
level.update_visible(1, -1);
level.explore_neighborhood();
