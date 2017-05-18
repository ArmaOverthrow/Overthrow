private _unit = _this select 0;

if(OT_hasACE) then {
	_unit addItemToUniform "ACE_rangeCard";
};
_unit setVariable ["NOAI",true,false];
_unit spawn {
	_this disableAI "MOVE";
	sleep 48;
	private _dir = random 360;
	private _pos = ([_this,1,_dir] call BIS_fnc_relPos);
	_this setposATL [_pos select 0,_pos select 1,((getposATL _this) select 2)+0.3];	
	_this setDir _dir;
	_this setUnitPos "MIDDLE";
};

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src or (_src call OT_fnc_unitSeenNATO)) then {
			_src setCaptive false;				
		};		
	};	
}];