/// @desc Initialize title screen timers.

// Title display parameters
alpha = 0; // opacity
fade = 0; // whether to fade in or out (-1 for out, 1 for in, 0 for neither)
factor = 1; // acceleration factor (bigger after the user clicks)
init = true; // whether the object has just been initialized
alarm[0] = 2.0*room_speed; // time until fade-in begins

//### Play sound

//### TEMP
room_goto(rm_static);
