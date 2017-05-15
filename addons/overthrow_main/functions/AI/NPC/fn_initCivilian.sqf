private ["_unit"];

_unit = _this select 0;
_unit setskill ["courage",1];
private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit setVariable ["NOAI",true,false];
_unit setVariable ["civ",true,true];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0, _unit];

_unit forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);

_unit addEventHandler ["FiredNear", {
	_u = _this select 0;
	_group = group _u;
	if !(_group getVariable ["fleeing",false]) then {
		_group setVariable ["fleeing",true,false];
		_group setBehaviour "COMBAT";
		_by = _this select 1;
		_camps = _u nearObjects [OT_refugeeCamp,2500];
		if(count _camps > 0) then {
			_camp = _camps select 0;
			while {(count (waypoints _group)) > 0} do {
			 	deleteWaypoint ((waypoints _group) select 0);
			};
			_wp = _group addWaypoint [position _camp,30];
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
		};
	};
}];
