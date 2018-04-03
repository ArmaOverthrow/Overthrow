_GroupUnits = _this select 0;
_Side = _this select 1;


_LetsWait = true;
while {_LetsWait} do 
{
	
	{
		if ((count (waypoints (group _x))) > 1) then {_LetsWait = false};
	} foreach _GroupUnits;
	sleep 2;
};



_group = createGroup _Side;

{
	[_x] joinSilent _group;
	_x setVariable ["VCOM_LOITERING",false];
	if (_x isEqualTo (leader _x)) then
	{
		_x setVariable ["VCOM_FLANKING",false,false];
	};
	_x setVariable ["VCOM_MovedRecently",false,false];	
} foreach _GroupUnits;