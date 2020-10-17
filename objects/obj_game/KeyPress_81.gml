//### Q -- NW
player.move_nw(-level.get_tile(global.player_x-1, global.player_y-1).elevation + global.player_elevation);
level.update_player_elevation();
level.update_visible();
level.explore_neighborhood();
