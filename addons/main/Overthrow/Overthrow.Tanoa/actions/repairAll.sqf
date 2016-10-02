private ["_pos"];
_pos = getpos player;

{
if (_x distance _pos < 50)
	then
	{
	_x setDamage 0;
	//_x setVehicleAmmoDef 1;
	[_x,1] remoteExec ["setVehicleAmmoDef",_x];
	};
} forEach vehicles;

"All vehicles within 50m have been repaired and rearmed." call notify_minor;