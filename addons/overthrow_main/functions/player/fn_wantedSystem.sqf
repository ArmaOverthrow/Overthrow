private _unit = _this;

_unit setCaptive true;
_unit setVariable ["OT_hiding",0,true];
_unit setVariable ["OT_wantedTimer",0,true];

_unit addEventHandler ["Take", {
	params ["_me","_container"];

	if (captive _me) then {
		//Looting dead bodies is illegal
		if(!alive _container && {typeof _container isKindOf ["Man",configFile>>"CfgVehicles"]}) then {
			_container setvariable ["OT_looted",true,true];
			_container setvariable ["OT_lootedAt",time,true];
			if (!(_container call OT_fnc_hasOwner) && (_me call OT_fnc_unitSeen)) then {
				_me setCaptive false;
				[_me] call OT_fnc_revealToNATO;
				[_me] call OT_fnc_revealToCRIM;
			};
		};
	};
}];

_unit addEventHandler ["Fired", {
	params ["_me","_weaponFired"];
	if (captive _me) then {
		//See if anyone heard the shots
		private _range = 800;
		(_me weaponAccessories (currentMuzzle _me)) params [["_silencer",""]];
		if!(_silencer isEqualTo "") then {
			//Shot was suppressed
			_range = 50;
		};

		if!((allGroups findIf {side _x in [west, east] && { (leader _x distance _me) < _range } }) isEqualTo -1) exitWith {
			_me setCaptive false;
			[_me, _range] call OT_fnc_revealToNATO;
		};
	};
}];


if((isPlayer _unit) && isNil "OT_ACEunconsciousChangedEHId") then {
	OT_ACEunconsciousChangedEHId = ["ace_unconscious", {
		params["_unit","_state"];

		if (!local _unit || { !alive _unit } || { !_state } || { !isPlayer _unit }) exitWith {};

		// inform other players
		if(isMultiplayer && count(call CBA_fnc_players) > 1) then {
			[
			  format[
			    "%1 has fallen unconscious and is waiting for assistance at GRIDREF: %2",
			    name player,
			    mapGridPosition player
			  ]
			] remoteExec ["systemChat",[0,-2] select isDedicated];
		};

		//Look for a medic
		private _havepi = "ACE_epinephrine" in (items player);
		private _nearbyUnits = player nearentities["CAManBase",50];
		_nearbyUnits apply {
			if (
				!isPlayer _x
				&& { ((side _x isEqualTo resistance) || captive _x) }
				&& { !(_unit isEqualTo _x) }
				&& { _havepi || {("ACE_epinephrine" in (items _x))} }
			) then {
				systemChat format ["%1: On my way to help you", name _x];
				_unit setVariable ["OT_informedMedics",(_unit getVariable ["OT_informedMedics",0])+1];
				[_x,_unit] call OT_fnc_orderRevivePlayer;
			};
			0
		};

		if((_unit getVariable ["OT_informedMedics",0]) isEqualTo 0) then {
			[_unit] call OT_fnc_unconsciousNoHelpPossible;
		};
	}] call CBA_fnc_addEventHandler;
};

[
	OT_fnc_wantedLoop,
	[_unit],
	3
] call CBA_fnc_waitAndExecute;
