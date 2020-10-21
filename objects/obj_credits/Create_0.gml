/// @desc Spawn back button and set scroll position.

var back = instance_create_layer(room_width - 48, room_height - 32, "Instances", obj_quit_no_button);
back.label = "Back";
pos = room_height + 32;
