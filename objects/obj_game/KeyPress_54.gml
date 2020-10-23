//### TEST CODE

global.victory = false;
global.new_level = true;
global.first_time = true;
global.wake_up = true;
global.level = 5;
global.next_room = global.level_rooms[global.level];
room_goto(rm_static);
