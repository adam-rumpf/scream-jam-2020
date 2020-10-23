/// @func _music_room()
/// @desc Determines whether the current room is meant to play the standard game music.
/// @return {bool} True if the music is meant to be played in the current room, false otherwise.

function _music_room()
{
	// List all music rooms explicitly here
	switch room
	{
		case rm_level:
		case rm_level_intro:
		case rm_level_sa:
		case rm_level_ts:
		case rm_level_hybrid:
		case rm_menu:
		case rm_credits:
		case rm_quit:
		case rm_reset:
			return true;
		default:
			return false;
	}
}
