_item = _this select 0;
_veh = _this select 1;
_pos = getpos _veh;

_illegal = _item getVariable ["ace_illegalCargo",false];

if(_illegal) then {
	{
		if(isPlayer _x) then {
			_x setCaptive false;
			[_x] call OT_fnc_revealToNATO;
		};
	}foreach(_pos nearentities 30);
};