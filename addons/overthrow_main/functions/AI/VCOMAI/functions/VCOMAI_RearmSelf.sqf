//This function will determine if an AI is low on ammo and needs to re-arm.
//This script passes _this. _this should be the AI unit.
_AL = VCOM_AIMagLimit;
if (vehicle _this != _this) exitWith {};

//The first thing we want to do. Is figure out what ammo this unit is using.
_CM = currentMagazine _this;

//Now, we want to compare this classname to all the other ammo classnames this unit may have and count the number.
_mags = magazines _this;

//Count the total number of mags.
_TC = 0;
{ if (_x isEqualTo _CM) then {_TC = _TC + 1} } foreach _mags;

//If unit has 2 or less, then make the unit find ammo!
if (_TC < _AL) then {
	//Find closest men!
	_FB = _this nearEntities [["WeaponHolderSimulated", "Man", "Air", "Car", "Motorcycle", "Tank"], 200];
	_FB = _FB - [_this];
	{
		if (alive _x && _x isKindOf "Man") then {_FB = _FB - [_x];};
	} foreach _FB;
	
	//If menz are around see if we can take ammo from them first.
	_Stop = false;
	if (count _FB != 0) then {
		{
			_mags = [];
			_Unit = _x;
			if (_Unit isKindOf "Man") then {
				_mags = magazines _Unit;
			} else {
				_mags = magazineCargo _Unit;
			};
			if (isNil "_mags") then {_mags = [];};
			{
				if (_x isEqualTo _CM) exitwith {
					[_this,_Unit] spawn VCOMAI_RearmGo; 
					_Stop = true;
				};
			} foreach _mags;
			if ( _Stop ) exitwith {};
		} foreach _FB;
	};
};