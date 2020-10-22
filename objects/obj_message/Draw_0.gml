/// @desc Draw a message depending on the current game state.

// Determine message depending on level
//###
var str;
switch global.level
{
	// New game
	case 0:
		str = "Better get down from here.\nNight is coming.";
		break;
	
	// SA
	case 1:
		str = "A dangerous fog rolls in\nfrom the mountains.";
		break;
	
	// TS
	case 2:
		str = "Horrid creatures come\nout at night.";
		break;
	
	// Hybrid
	case 3:
		str = "You need to get down from here.";
		break;
	
	// Final
	case 4:
		str = "Be careful. You might find what\nyou've been searching for.";
		break;
}

// Display the message
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_font(fnt_default);
draw_text(room_width/2, room_height/2, str);
