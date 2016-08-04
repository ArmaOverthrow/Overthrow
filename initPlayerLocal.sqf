private ["_town","_house","_housepos","_pos","_pop","_houses","_mrk","_furniture"];

if(isMultiplayer and (!isServer)) then {
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";
};

player setVariable ["money",100,true];
player setVariable ["owner",player,true];

titleText ["", "BLACK FADED", 0];

waitUntil {!isNil "AIT_economyInitDone"};

{
	player setVariable [format["rep%1",_x],0,true];
}foreach(AIT_allTowns);

AIT_stats = [] execVM "stats.sqf";


_town = server getVariable "spawntown";
_pos = server getVariable _town;
_pop = server getVariable format["population%1",_town];
_stability = server getVariable format["stability%1",_town];
_rep = player getVariable format["rep%1",_town];
_money = player getVariable "money";

mainMenu = (findDisplay 46) displayAddEventHandler ["KeyDown",keyHandler];

//JIP interactions
_shops = server getVariable "activeshops";
{
	_x call initShopLocal;
}foreach(_shops);

_shops = server getVariable "activecarshops";
{
	_x call initCarShopLocal;
}foreach(_shops);

_shops = server getVariable "activedealers";
{
	_x call initGunDealerLocal;
}foreach(_shops);

_mSize = 350;
if(_town in AIT_capitals) then {//larger search radius
	_mSize = 700;
};
_houses = [];
{
	_houses pushback _x;
}foreach(nearestObjects [_pos, AIT_spawnHouses, _mSize+100]);
_house = _houses call BIS_Fnc_arrayShuffle;
_house = _houses call BIS_Fnc_selectRandom;
_housepos = getpos _house;

//_carshop = (nearestObjects [_housepos, AIT_carshops, _mSize]) select 0;
//_pos =  [server getVariable format["crimleader%1",_town], 0, 10, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_pos = [_housepos, 0, 75, 1, 0, 0, 0] call BIS_fnc_findSafePos;


_house setVariable ["owner",player,true];
player setVariable ["home",_house,true];

//put a marker on home
_mrk = createMarkerLocal [format["home-%1",getPlayerUID player],_housepos];
_mrk setMarkerShape "ICON";
_mrk setMarkerType "loc_Tourism";
_mrk setMarkerColor "ColorWhite";
_mrk setMarkerAlpha 0;
_mrk setMarkerAlphaLocal 1;

player setCaptive true;
player setPos _pos;
titleText ["", "BLACK IN", 5];

_furniture = (_house call spawnTemplate) select 0;

{
	_x addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
}foreach(_furniture);


player addEventHandler ["GetInMan", {
	_veh = _this select 2;
	_owner = _veh getvariable "owner";
	if(isNil "_owner") then {
		_veh setVariable ["owner",player,true];
	};
}];

[] execVM "setupPlayer.sqf";