private ["_town","_id","_pos","_building","_tracked","_civs","_vehs","_group","_all","_shopkeeper","_groups"];
if (!isServer) exitwith {};

_count = 0;
params ["_town","_spawnid"];
_posTown = server getVariable _town;
_pop = server getVariable format["population%1",_town];

_groups = [];


_gundealerpos = server getVariable format["gundealer%1",_town];
if(isNil "_gundealerpos") then {
	_building = [_posTown,OT_gunDealerHouses] call OT_fnc_getRandomBuilding;
	_gundealerpos = (_building call BIS_fnc_buildingPositions) call BIS_fnc_selectRandom;
	server setVariable [format["gundealer%1",_town],_gundealerpos,true];
	[_building,"system"] call OT_fnc_setOwner;
};
_group = createGroup civilian;
_groups	pushback _group;

_group setBehaviour "CARELESS";
_pos = [[[_gundealerpos,50]]] call BIS_fnc_randomPos;
_dealer = _group createUnit [OT_civType_gunDealer, _pos, [],0, "NONE"];

_wp = _group addWaypoint [_gundealerpos,0];
_wp setWaypointType "MOVE";
_wp setWaypointSpeed "LIMITED";

[_dealer] call OT_fnc_initGunDealer;

_dealer setVariable ["gundealer",true,true];
spawner setVariable [format ["gundealer%1",_town],_dealer,true];
sleep 0.1;

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];
