/// @func _sa_room()
/// @desc Determines whether the current room uses the SA rules.
/// @return {bool} True if the current room uses SA rules, false otherwise.

function _sa_room()
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