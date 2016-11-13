private _unit = _this select 0;
private _pos = _this select 1;

private _mylevel = _unit getvariable ["intelBase",0];

if(OT_hasTFAR) then {
	{
		_c = _x splitString "_";
		if((_c select 0) == "tf") exitWith {
			_mylevel = _mylevel + 1;  //Player has radio: +1
			if(((_pos call nearestComms) select 1) in (server getVariable ["NATOabandoned",[]])) then {_mylevel = _mylevel + 1}; //Player has radio, and nearest comms tower is under control: +1
		};
	}foreach(assignedItems _unit);
}else{
	if((assignedItems _unit find "ItemRadio") > -1) then {
		_mylevel = _mylevel + 1;  //Player has radio: +1
		if(((_pos call nearestComms) select 1) in (server getVariable ["NATOabandoned",[]])) then {_mylevel = _mylevel + 1}; //Player has radio, and nearest comms tower is under control: +1
	};
};



if((_unit distance _pos) < 1000) then {_mylevel = _mylevel + 1}; //Player is within 1km of position: +1

if((_unit distance _pos) < 150) then {_mylevel = _mylevel + 1}; //Player is within 150m of position: +1

_mylevel