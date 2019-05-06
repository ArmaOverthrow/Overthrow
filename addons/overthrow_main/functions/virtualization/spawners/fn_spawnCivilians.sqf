params ["_town","_spawnid"];
sleep random 0.2;

spawner setvariable [format["townspawnid%1",_town],_spawnid,false];

private _hometown = _town;
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

private _hour = date select 3;

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

private _count = 0;

private _pergroup = 1;
if(_numCiv > 8) then {_pergroup = 2};
if(_numCiv > 16) then {_pergroup = 4};

while {_count < _numCiv} do {
	private _groupcount = 0;
	private _group = createGroup [civilian,true];
	_group setBehaviour "SAFE";
	_groups pushback _group;

	private _home = _town call OT_fnc_getRandomRoadPosition;
	while {(_groupcount < _pergroup) && (_count < _numCiv)} do {
		_pos = [_home,random 360,10] call SHK_pos_fnc_pos;
		_civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
		_civ setBehaviour "SAFE";
		_civ setVariable ["hometown",_hometown,true];
		[_civ] call OT_fnc_initCivilian;

		private _identity = call OT_fnc_randomLocalIdentity;
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
	private _gangid = _x;
	private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
	_gang params ["_members"];

	if (!isNil "_members" && {_members isEqualType []}) then {
		private _vest = "";
		if(count _gang > 3) then {
			_vest = _gang select 3;
		}else{
			_vest = selectRandom OT_allProtectiveVests;
			if (_gang isEqualType []) then {
				_gang set [3,_vest];
			};
		};
		private _group = creategroup [opfor,true];
		_groups pushback _group;
		spawner setVariable [format["gangspawn%1",_gangid],_group];
		if(count _gang > 4) then { //Filter out old gangs
			private _home = _gang select 4; //camp position

			//Spawn the camp
			_veh = createVehicle ["Campfire_burning_F",_home,[],0,"CAN_COLLIDE"];
			_groups pushback _veh;

			_numtents = 2 + round(random 3);
			_count = 0;

			while {_count < _numtents} do {
				//this code is in tents
				_d = random 360;
				_p = [_home,[2,9],_d] call SHK_pos_fnc_pos;
				_p = _p findEmptyPosition [1,40,"Land_TentDome_F"];
				_veh = createVehicle ["Land_TentDome_F",_p,[],0,"CAN_COLLIDE"];
				_veh setDir _d;
				_groups pushback _veh;
				_count = _count + 1;
			};

			//And the gang leader in his own group
			private _leaderGroup = creategroup [opfor,true];
			private _pos = [_home,10] call SHK_pos_fnc_pos;
			_civ = _leaderGroup createUnit [OT_CRIM_Unit, _pos, [],0, "NONE"];
			_civ setRank "COLONEL";
			_civ setBehaviour "SAFE";
			_civ setVariable ["NOAI",true,false];
			[_civ] joinSilent nil;
			[_civ] joinSilent _leaderGroup;
			_civ setVariable ["OT_gangid",_gangid,true];
			[_civ,_town] call OT_fnc_initCrimLeader;

			_wp = _leaderGroup addWaypoint [_home,0];
			_wp setWaypointType "GUARD";

			_groups pushback _leaderGroup;

			{
				_x addCuratorEditableObjects [[_civ]];
			}foreach(allCurators);

			{
				private _civid = _x;
				private _ident = (OT_civilians getVariable [format["%1",_civid],[]]);
				_ident params ["_identity"];

				private _pos = [_pos,10] call SHK_pos_fnc_pos;
				private _civ = _group createUnit [OT_CRIM_Unit, _pos, [],0, "NONE"];
				[_civ] joinSilent nil;
				[_civ] joinSilent _group;

				if(isNil "_identity" || { _identity isEqualTo [] }) then {
					_identity = call OT_fnc_randomLocalIdentity;
				};

				[_civ,_town,_vest] call OT_fnc_initCriminal;
				[_civ,_identity] call OT_fnc_applyIdentity;
				[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];

				_civ setVariable ["OT_gangid",_gangid,true];
				_civ setVariable ["OT_civid",_civid,true];
				_civ setBehaviour "SAFE";
				_civ setVariable ["hometown",_hometown,true];

				{
					_x addCuratorEditableObjects [[_civ]];
				}foreach(allCurators);
			}foreach(_members);
			sleep 0.2;
			_group spawn OT_fnc_initCriminalGroup;
		};
	};
}foreach(_gangs);

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
