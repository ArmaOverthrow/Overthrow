disableSerialization;
private _amt = _this;

private _town = (getpos player) call OT_fnc_nearestTown;
private _money = player getVariable ["money",0];

private _soldier = "Police" call OT_fnc_getSoldier;
private _price = _soldier select 0;

if(_money < (_amt * _price)) exitWith {"You cannot afford that" call OT_fnc_notifyMinor};

if !(_town in (server getvariable ["NATOabandoned",[]])) exitWith {"This police station is under NATO control" call OT_fnc_notifyMinor};

[_town,5 * _amt] call OT_fnc_support;

private _garrison = server getVariable [format['police%1',_town],0];
_garrison = _garrison + _amt;
server setVariable [format["police%1",_town],_garrison,true];

_mrkid = format["%1-police",_town];
_mrkid setMarkerText format["%1",_garrison];

[-(_amt*_price)] call OT_fnc_money;

_effect = floor(_garrison / 2);
if(_effect isEqualTo 0) then {_effect = "None"} else {_effect = format["+%1 Stability/10 mins",_effect]};

((findDisplay 9000) displayCtrl 1101) ctrlSetStructuredText parseText format["<t size=""1.5"" align=""center"">Police: %1</t>",_garrison];
((findDisplay 9000) displayCtrl 1104) ctrlSetStructuredText parseText format["<t size=""1.2"" align=""center"">Effects</t><br/><br/><t size=""0.8"" align=""center"">%1</t>",_effect];

_count = 0;
_range = 15;
private _group = createGroup resistance;
_group setVariable ["VCM_TOUGHSQUAD",true,true];
_group setVariable ["VCM_NORESCUE",true,true];

private _spawnid = spawner getvariable [format["townspawnid%1",_town],-1];
private _groups = spawner getvariable [_spawnid,[]];
_groups pushBack _group;
_posTown = server getVariable [format["policepos%1",_town],server getVariable _town];
while {_count < _amt} do {
	_groupcount = 0;

	_start = [[[_posTown,_range]]] call BIS_fnc_randomPos;
	_pos = [[[_start,20]]] call BIS_fnc_randomPos;

	_civ = [_soldier,_pos,_group] call OT_fnc_createSoldier;
	[_civ] joinSilent _group;
	_civ setRank "SERGEANT";
	[_civ,_town] call OT_fnc_initPolice;
	_civ setBehaviour "SAFE";

	_count = _count + 1;
};
_group call OT_fnc_initPolicePatrol;
spawner setvariable [_spawnid,_groups,false];
