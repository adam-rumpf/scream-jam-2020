/// @func _level_room()
/// @desc Determines whether the current room is a level.
/// @return {bool} True if the current room is a level, false otherwise.

function _level_room()
{
	// List all level rooms explicitly here
	switch room
	{
		case rm_level:
		case rm_level_intro:
		case rm_level_sa:
		case rm_level_ts:
		case rm_level_hybrid:
		case rm_level_final:
			return true;
		default:
			return false;
	}
}
