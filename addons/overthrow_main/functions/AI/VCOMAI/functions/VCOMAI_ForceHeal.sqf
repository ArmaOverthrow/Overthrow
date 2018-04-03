//Heal any hurt friendlies nearby.
//Potential for ace healing
//_damageVar = player getvariable ["ace_medical_bodyPartStatus", [0,0,0,0,0,0]]; [player, "selection", (_damageVar select (["selection"] call ace_medical_fnc_selectionNameToNumber)) + _newDamage, player, "TypeOfDammage", -1] call ace_medical_fnc_handleDamage;
private _Unitgroup = group _this;
private _USide = side _Unitgroup;
private _Friendlies = allUnits select {Side _x isEqualTo _USide && (_x distance _this) < 50};

{
	if (damage _x > 0) exitWith 
	{
			while {alive _x && {alive _this} && {_this distance _x > 3}} do 
			{
				_this domove (getposATL _x);
				_this forcespeed -1;				
				sleep 5;
				if (VCOM_AIDEBUG isEqualTo 1) then
				{
					[_this,"Moving to heal. Like a good medic.",5,20000] remoteExec ["3DText",0];
				};				
			};
			if (alive _x && alive _this && _this distance _x <= 3) then
			{
				_this action ["HealSoldier",_x];
				_this forcespeed -1;
				if (ACEACTIVATED) then {[objNull, _x] call ace_medical_fnc_treatmentAdvanced_fullHealLocal};
				if (VCOM_AIDEBUG isEqualTo 1) then
				{
					[_this,"Healing. Like a good medic.",15,20000] remoteExec ["3DText",0];
				};				
			};
	}; 
} foreach _Friendlies;