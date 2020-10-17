/// @func _level_room()
/// @desc Determines whether the current room is a level.
/// @return {bool} True if the current room is a level, false otherwise.

function _level_room()
{
	// List all level rooms explicitly here
	switch room
	{
		case rm_level:
		//###
			return true;
		default:
			return false;
	}
}
