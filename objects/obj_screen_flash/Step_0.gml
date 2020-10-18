/// @desc Count down and destroy self when timer is up.

timer--;
if (timer <= 0)
	instance_destroy();
