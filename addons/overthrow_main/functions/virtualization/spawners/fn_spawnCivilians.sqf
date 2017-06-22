params ["_town","_spawnid"];
sleep random 0.2;

spawner setvariable [format["townspawnid%1",_town],_spawnid,false];

private _hometown = _town;

private _count = 0;

private _groups = [];

private _pop = server getVariable format["population%1",_town];
private _stability = server getVariable format ["stability%1",_town];
private _posTown = server getVariable _town;

waitUntil {!isNil "OT_economyLoadDone"};

private _mSize = 350;
if(_town in OT_capitals) then {
	_mSize = 900;
};
private _numciv = 0;

if(_pop > 5) then {
	_numCiv = round(_pop * OT_spawnCivPercentage);
	if(_numCiv < 5) then {
		_numCiv = 5;
	};
}else {
	_numCiv = _pop;
};

if(_numCiv > 50) then {
	_numCiv = 50;
};

_hour = date select 3;

/*
private _church = server getVariable [format["churchin%1",_town],[]];
if !(_church isEqualTo []) then {
	//spawn the priest
	_group = createGroup civilian;
	_group setBehaviour "SAFE";
	_groups pushback _group;
	_pos = [[[_church,20]]] call BIS_fnc_randomPos;
	_civ = _group createUnit [OT_civType_priest, _pos, [],0, "NONE"];
	[_civ] call OT_fnc_initPriest;
	sleep 0.2;
};*/

_count = 0;

_pergroup = 1;
if(_numCiv > 8) then {_pergroup = 2};
if(_numCiv > 16) then {_pergroup = 4};
private _idents = OT_civilians getVariable [format["civs%1",_town],[]];
private _numidents = count _idents;
while {_count < _numCiv} do {
	_groupcount = 0;
	_group = createGroup civilian;
	_group deleteGroupWhenEmpty true;
	_group setBehaviour "SAFE";
	_groups pushback _group;

	_home = _town call OT_fnc_getRandomRoadPosition;
	while {(_groupcount < _pergroup) and (_count < _numCiv)} do {
		_pos = [_home,random 360,10] call SHK_pos;
		_civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
		_civ setBehaviour "SAFE";
		_civ setVariable ["hometown",_hometown,true];
		[_civ] call OT_fnc_initCivilian;

		_identity = [];
		if(_count < _numidents) then {
			_civid = _idents select _count;
			_ident = (OT_civilians getVariable [format["%1",_civid],[]]);
			if((_ident select 3) == -1) then {
				_identity = _ident select 0;
				_civ setVariable ["OT_civid",_civid,true];
				spawner setVariable [format["civspawn%1",_civid],_civ,false];
			}else{
				_identity = call OT_fnc_randomLocalIdentity;
			};
		};
		if(isNil "_identity" or count _identity == 0) then {
			_identity = call OT_fnc_randomLocalIdentity;
		};
		[_civ,_identity] call OT_fnc_applyIdentity;
		_count = _count + 1;
		_groupcount = _groupcount + 1;
	};
	sleep 0.2;
	_group spawn OT_fnc_initCivilianGroup;
};
sleep 0.2;
//Do gangs
private _gangs = OT_civilians getVariable [format["gangs%1",_town],[]];
{
	_gangid = _x;
	_gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
	_members = _gang select 0;

	if !(isNil "_members") then {
		_vest = "";
		if(count _gang > 3) then {
			_vest = _gang select 3;
		}else{
			_vest = selectRandom OT_allProtectiveVests;
			_gang set[3,_vest];
		};
		_group = creategroup opfor;
		_groups pushback _group;
		_home = _town call OT_fnc_getRandomRoadPosition;
		{
			_civid = _x;
			_ident = (OT_civilians getVariable [format["%1",_civid],[]]);
			_identity = _ident select 0;

			_pos = [_home,random 360,10] call SHK_pos;
			_civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
			[_civ] joinSilent nil;
			[_civ] joinSilent _group;
			spawner setVariable [format["civspawn%1",_civid],_civ,false];

			if(isNil "_identity" or count _identity == 0) then {
				_identity = call OT_fnc_randomLocalIdentity;
			};

			[_civ,_town,_vest] call OT_fnc_initCriminal;
			[_civ,_identity] call OT_fnc_applyIdentity;
			[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];

			_civ setVariable ["OT_gangid",_gangid,true];
			_civ setVariable ["OT_civid",_civid,true];
			_civ setBehaviour "SAFE";
			_civ setVariable ["hometown",_hometown,true];
		}foreach(_members);
		sleep 0.2;
		_group spawn OT_fnc_initCivilianGroup;
	};
}foreach(_gangs);

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
