private _target = objNull;
private _cop = objNull;

if((count _this) == 3) then {
	//its a position	
	{
		_c = leader (group _x);
		if(side _c == west and !(_c getVariable ["OT_searching",false])) exitWith{_cop = _c};
	}foreach(_this nearEntities ["Man",400]);
	if(isNil "_cop") exitWith {};	
	{
		if(side _x == civilian && !isplayer _x) exitWith{_target = _x};
	}foreach(_cop nearEntities ["Man",50]);
}else{
	_target = _this select 0;
	if((count _this) > 1) then {
		_cop = _this select 1;
	}else{
		{
			_c = leader (group _x);
			if(side _c == west and !(_c getVariable ["OT_searching",false])) exitWith{_cop = _c};
		}foreach(_target nearEntities ["Man",150]);
	};
};
if(isNil "_cop" or isNil "_target") exitWith{};

_cop setVariable ["OT_searching",true,true];

if(isplayer _target and !captive _target) exitWith{};

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
	"NATO: Stop right there!" remoteExec ["notify_talk",_target,false];	
	_wp setWaypointSpeed "FULL";
	_hdl = _target addEventHandler ["InventoryOpened", {
		hint "NATO search is in progress, you cannot open your inventory";
		true //<-- inventory override
	}];
}else{
	_target playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	_target disableAI "MOVE";	
};
_posnow = position _target;
_timenow = time;

private _cleanup = {
	_group setBehaviour "SAFE";
	_group call initPolicePatrol;
	_cop setVariable ["OT_searching",false,true];
	_cop switchMove "";
	if(isplayer _target) then {
		_target removeEventHandler ["InventoryOpened",_hdl];
	}else{
		_target enableAI "MOVE";
		_target switchMove "";
	};
};
_cop doMove (position _target);
waitUntil {sleep 1;(_cop distance _target) < 2 or (_target distance _posnow) > 2 or (time - _timenow) > 120};

if((isplayer _target and !captive _target) or (!alive _cop) or ((time - _timenow) > 120)) exitWith _cleanup;

if((_target distance _posnow) > 2) then {
	if(isplayer _target) then {
		"NATO: I said stop! move again and we WILL open fire" remoteExec ["notify_talk",_target,true];
		_wp setWaypointPosition (position _target);
		_posnow = position _target;
		_timenow = time;
		_cop doMove (position _target);
		waitUntil {sleep 1;(_cop distance _target) < 2 or (_target distance _posnow) > 2 or (time - _timenow) > 120};		
		if((_target distance _posnow) > 2) then {
			_target setCaptive false;
			[] call _cleanup;
		};
	};
};
_cop playMove "Amovpknlmstpsraswrfldnon_gear";
if(isplayer _target) then {
	"NATO: This is a random search, stay perfectly still" remoteExec ["notify_talk",_target,true];
	_target playMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
	sleep 5;
}else{
	sleep 15;
};

if((isplayer _target and !captive _target) or (!alive _cop) or ((time - _timenow) > 120)) exitWith _cleanup;

if((_target distance _posnow) > 2) exitWith {
	if(isplayer _target) then {
		_target setCaptive false;	
		[] call _cleanup;
	};
};

private _msg = "";

if(isplayer _target) then {
	private _foundillegal = false;
	private _foundweapons = false;
	{
		_cls = _x select 0;
		if(_cls in OT_allWeapons + OT_allMagazines + OT_illegalHeadgear + OT_illegalVests + OT_allStaticBackpacks) then {
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
	}foreach(_target call searchStock);
	
	if(_foundillegal or _foundweapons) then {
		if(_foundweapons) then {
			"NATO: What's this??!?" remoteExec ["notify_talk",_target,false];
			_target setCaptive false;
			{
				if(side _x == west) then {
					_x reveal [_target,1.5];
					sleep 0.2;
				};
			}foreach(_target nearentities ["Man",500]);	
		}else{
			"NATO: We found some illegal items and confiscated them, be on your way" remoteExec ["notify_talk",_target,false];
		};
	}else{
		"NATO: Thank you for your co-operation" remoteExec ["notify_talk",_target,false];
	};	
};
[] call _cleanup;
