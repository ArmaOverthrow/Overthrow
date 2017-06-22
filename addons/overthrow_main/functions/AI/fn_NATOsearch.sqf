private _target = objNull;
private _cop = objNull;

if((count _this) == 3) then {
	//its a position
	{
		_c = leader (group _x);
		if(side _c == west and !(_c getVariable ["OT_searching",false])) exitWith{_cop = _c};
	}foreach(_this nearEntities ["CAManBase",300]);
	if(isNil "_cop") exitWith {};
	{
		if !(side _x == west or side _x == east) exitWith{_target = _x};
	}foreach(_cop nearEntities ["CAManBase",50]);
}else{
	_target = _this select 0;
	if((count _this) > 1) then {
		_cop = _this select 1;
	}else{
		{
			_c = leader (group _x);
			if(side _c == west and !(_c getVariable ["OT_searching",false])) exitWith{_cop = _c};
		}foreach(_target nearEntities ["CAManBase",150]);
	};
};
if(isNil "_cop" or isNil "_target") exitWith{};

_cop setVariable ["OT_searching",true,true];

if((isplayer _target) and !(captive _target)) exitWith{};

private _group = group _cop;
private _hdl = objNull;

//delete all group waypoints
while {(count(waypoints _group))>0} do
{
	deletewaypoint ((waypoints _group) select 0);
};
sleep 0.5;

private _wp = _group addWaypoint [position _target,0];
_wp setWaypointBehaviour "AWARE";
_group setBehaviour "AWARE";
if(isplayer _target) then {
	[_cop,(["Stop right there!","Halt, citizen!","HALT!","Stay right there, citizen"] call BIS_fnc_selectRandom)] remoteExec ["globalchat",_target,false];
	_wp setWaypointSpeed "FULL";
	_hdl = _target addEventHandler ["InventoryOpened", {
		hint "NATO search is in progress, you cannot open your inventory";
		true //<-- inventory override
	}];
}else{
	[_target, "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon"] remoteExec ["playMove",_target,false];
	[_target, "MOVE"] remoteExec ["disableAI",_target,false];
};
_posnow = position _target;
_timenow = time;

private _cleanup = {
	[_target, ""] remoteExec ["switchMove",_target,false];
	params ["_group","_cop","_target","_handler"];
	if(!isNil "_group") then {
		_group setBehaviour "SAFE";
		_group call OT_fnc_initGendarmPatrol;
	};
	if(!isNil "_cop") then {
		_cop setVariable ["OT_searching",false,true];
		[_cop, ""] remoteExec ["switchMove",_cop,false];
	};
	if(isplayer _target) then {
		_target removeEventHandler ["InventoryOpened",_handler];
	}else{
		[_target, "MOVE"] remoteExec ["enableAI",_target,false];
	};
};
[_cop,(position _target)] remoteExec["doMove",_cop,false];
waitUntil {sleep 1;(_cop distance _target) < 7 or (_target distance _posnow) > 2 or (time - _timenow) > 120};
if(isNil "_cop" or isNil "_target") exitWith{[_group,_cop,_target,_hdl] call _cleanup};
if(!alive _cop or !alive _target) exitWith{[_group,_cop,_target,_hdl] call _cleanup};

if((isplayer _target and !captive _target) or (!alive _cop) or ((time - _timenow) > 120)) exitWith {[_group,_cop,_target,_hdl] call _cleanup};

if((_target distance _posnow) > 2) then {
	if(isplayer _target) then {
		[_cop,"I said stop! move again and we WILL open fire"] remoteExec ["globalchat",_target,false];
		"sectorLost" remoteExec ["playsound",_target,false];

		while {(count(waypoints _group))>0} do
		{
			deletewaypoint ((waypoints _group) select 0);
		};
		sleep 3;

		private _wp = _group addWaypoint [position _target,0];
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "FULL";

		_posnow = position _target;
		_timenow = time;
		_cop doMove (position _target);
		waitUntil {sleep 2;(_cop distance _target) < 7 or (_target distance _posnow) > 2 or (time - _timenow) > 120};
		if((_target distance _posnow) > 2) then {
			_target setCaptive false;
			[_group,_cop,_target,_hdl] call _cleanup;
		};
	};
};
if(isNil "_cop" or isNil "_target") exitWith{[_group,_cop,_target,_hdl] call _cleanup};
if(!alive _cop or !alive _target) exitWith{[_group,_cop,_target,_hdl] call _cleanup};
[_cop, "Amovpknlmstpsraswrfldnon_gear"] remoteExec ["playMove",_cop,false];
if(isplayer _target) then {
	[_cop,"This is a random search, stay perfectly still"] remoteExec ["globalchat",_target,false];
	sleep 5;
}else{
	sleep 15;
};

if((isplayer _target and !captive _target) or (!alive _cop) or ((time - _timenow) > 120)) exitWith {[_group,_cop,_target,_hdl] call _cleanup};

if((_target distance _posnow) > 2) exitWith {
	if(isplayer _target) then {
		"You tried to escape a NATO search" remoteExecCall ["hint",_target,false];
	};
	[_group,_cop,_target,_hdl] call _cleanup;
	_target setCaptive false;

	_target spawn OT_fnc_revealToNATO;
};

private _msg = "";

if(isplayer _target) then {
	private _foundillegal = false;
	private _foundweapons = false;
	{
		_cls = _x select 0;
		if(_cls in OT_allWeapons + OT_allMagazines + OT_illegalHeadgear + OT_illegalVests + OT_allStaticBackpacks + OT_allOptics) then {
			_count = _x select 1;
			for "_i" from 1 to _count do {
				_target removeItem _cls;
				_cop addItem _cls;
			};
			_foundweapons = true;
		};
		if(_cls in OT_illegalItems) then {
			_count = _x select 1;
			for "_i" from 1 to _count do {
				_target removeItem _cls;
				_cop addItem _cls;
			};
			_foundillegal = true;
		};
	}foreach(_target call OT_fnc_getSearchStock);

	if(_foundillegal or _foundweapons) then {
		if(_foundweapons) then {			
			if(isplayer _target) then {
				[_cop,"What's this!?"] remoteExec ["globalchat",_target,false];
				"NATO found weapons" remoteExecCall ["hint",_target,false];
			};
			_target setCaptive false;
			_target spawn OT_fnc_revealToNATO;
		}else{
			if(isplayer _target) then {
				private _stealth = _target getVariable ["OT_stealth",1];
				_chance = 100;
				if(_stealth > 1) then {
					_chance = 100 - (_stealth * 20);
				};
				if((random 100) < _chance) then {
					[_cop,"We found some illegal items and confiscated them, be on your way"] remoteExec ["globalchat",_target,false];
					"NATO confiscated illegal items" remoteExecCall ["hint",_target,false];
					private _town = (getpos _target) call OT_fnc_nearestTown;
					[_town,-10] remoteExecCall ["OT_fnc_standing",_target,false];
				}else{
					[_cop,"Thank you for your co-operation"] remoteExec ["globalchat",_target,false];
				};
			};
		};
	}else{
		[_cop,"Thank you for your co-operation"] remoteExec ["globalchat",_target,false];
	};
};
[_group,_cop,_target,_hdl] call _cleanup;
