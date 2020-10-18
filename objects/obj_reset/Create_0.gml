/// @desc Spawn reset confirmation buttons.

instance_create_layer(2*room_width/5, room_height/2 + 32, "Instances", obj_reset_yes_button);
instance_create_layer(3*room_width/5, room_height/2 + 32, "Instances", obj_quit_no_button);
