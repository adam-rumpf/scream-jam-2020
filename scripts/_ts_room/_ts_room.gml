/// @func _ts_room()
/// @desc Determines whether the current room uses the TS rules.
/// @return {bool} True if the current room uses TS rules, false otherwise.

function _ts_room()
{
	// List all level rooms explicitly here
	switch room
	{
		case rm_level:
		case rm_level_ts:
		case rm_level_hybrid:
			return true;
		default:
			return false;
	}
}
