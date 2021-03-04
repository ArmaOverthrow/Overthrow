params ["_unit","_town","_vest","_gangid"];

_unit setVariable ["criminal",true,false];
_unit setVariable ["civ",nil,false];
_unit setVariable ["NOAI",false,false];
_unit setVariable ["VCOM_NOPATHING_Unit",true,false];
_unit setRank "SERGEANT";
_unit setSkill 0.4 + (random 0.4);

_unit removeAllEventHandlers "FiredNear";
private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
_unit setUnitLoadout [_gang select 5,true];

if((random 100) < 15) then {
	_unit addItem "OT_Ganja";
};

[_unit] call {
	params ["_unit"];
	if((random 100) > 80) exitWith {
		//This is a medic
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to 10 do {_unit addItemToBackpack "ACE_fieldDressing";};
		for "_i" from 1 to 3 do {_unit addItemToBackpack "ACE_morphine";};
		_unit addItemToBackpack "ACE_bloodIV";
		_unit addItemToBackpack "ACE_epinephrine";
	};
	if((random 100) > 90) exitWith {
		//This is an engineer
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
		_unit addItemToBackpack "APERSBoundingMine_Range_Mag";
		_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";
		_unit addItemToBackpack "IEDUrbanSmall_Remote_Mag";

		_unit addItemToBackpack "ACE_DefusalKit";
		_unit addItemToBackpack "ACE_M26_Clacker";
		_unit addItemToBackpack "ACE_Clacker";
		_unit addItemToBackpack "ACE_DeadManSwitch";

		_unit addItemToBackpack "ToolKit";
	};
	if((random 100) > 97) exitWith {
		//This guy is a drug runner
		_unit addBackpack (OT_allBackpacks call BIS_fnc_selectRandom);
		for "_i" from 1 to round(random 15) do {_unit addItemToBackpack "OT_Ganja";};
	};
};
_unit addGoggles (OT_CRIM_Goggles call BIS_fnc_selectRandom);

_unit addEventHandler ["Dammaged", OT_fnc_EnemyDamagedHandler];
