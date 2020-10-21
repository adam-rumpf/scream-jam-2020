/// @desc Initialize button's selection attribute and set text and dimensions.

// Button listens for mouse clicks only when selected
selected = false;

// Set text attributes
label = "Show Blood: On";
if (global.bloodless == true)
	label = "Show Blood: Off";
image_xscale = 8;
image_yscale = 1;
image_alpha = 0;
