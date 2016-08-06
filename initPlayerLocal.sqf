private ["_town","_house","_housepos","_pos","_pop","_houses","_mrk","_furniture"];
waitUntil {!isNull player};
waitUntil {player == player};

removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;
removeBackpack player;
removeHeadgear player;
removeVest player;

player linkItem "ItemMap";

player forceAddUniform (AIT_clothes_locals call BIS_fnc_selectRandom);

if(isMultiplayer and (!isServer)) then {
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";
};

player setVariable ["money",100,true];
player setVariable ["owner",player,true];

titleText ["", "BLACK FADED", 0];

waitUntil {!isNil "AIT_economyInitDone"};

_newplayer = true;

if(isMultiplayer) then {
	_data = server getvariable (getplayeruid player);
	if !(isNil "_data") then {
		_newplayer = false;
		{
			_key = _x select 0;
			_val = _x select 1;
			player setVariable [_key,_val,true];
		}foreach(_data);		
		
		_house = player getVariable "home";
		_town = (getpos _house) call nearestTown;
		_housepos = getpos _house;
		_furniture = _home getVariable "furniture";
		
		_owned = player getVariable "owned";
		{
			_x setVariable ["owner",player,true];
		}foreach(_owned);
	};

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
};

if (_newplayer) then {
	{
		player setVariable [format["rep%1",_x],0,true];
	}foreach(AIT_allTowns);

	AIT_stats = [] execVM "stats.sqf";

	_town = server getVariable "spawntown";
	_pos = server getVariable _town;

	_mSize = 350;
	if(_town in AIT_capitals) then {//larger search radius
		_mSize = 700;
	};
	_houses = [];
	{
		if !(_x call hasOwner) then {
			_houses pushback _x;
		}
	}foreach(nearestObjects [_pos, AIT_spawnHouses, _mSize+250]);

	if(count _houses == 0 || AIT_randomSpawnTown) then {
		//town is full, has no possible houses or has been bought out, pick another
		_towns = [];
		{
			_stability = server getvariable format["stability%1",_town];
			if((_stability > 70) and !(_name in AIT_spawnBlacklist)) then {
				_towns pushBack _x;
			};
		}foreach(AIT_allTowns);
		_town = _towns call BIS_fnc_selectRandom;
		_mSize = 350;
		if(_town in AIT_capitals) then {//larger search radius
			_mSize = 700;
		};
		_pos = server getvariable _town;
		{
			if !(_x call hasOwner) then {
				_houses pushback _x;
			}
		}foreach(nearestObjects [_pos, AIT_spawnHouses, _mSize+250]);
	};

	_house = _houses call BIS_Fnc_arrayShuffle;
	_house = _houses call BIS_Fnc_selectRandom;
	_housepos = getpos _house;

	_house setVariable ["owner",player,true];
	player setVariable ["home",_house,true];

	hint "Welcome to Overthrow!\n\nOpen the map to find out where your house is, press the Y key to fast travel there or perform other actions.";

	_furniture = (_house call spawnTemplate) select 0;
	_house setVariable ["furniture",_furniture];
	
	player setVariable ["owned",[_house],true];
};

_pos = [[[_housepos,25]]] call BIS_fnc_randomPos;
player setCaptive true;
player setPos _pos;
titleText ["", "BLACK IN", 5];

//put a marker on home
_mrk = createMarkerLocal [format["home-%1",getPlayerUID player],_housepos];
_mrk setMarkerShape "ICON";
_mrk setMarkerType "loc_Tourism";
_mrk setMarkerColor "ColorWhite";
_mrk setMarkerAlpha 0;
_mrk setMarkerAlphaLocal 1;

{
	_x addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
	_x setVariable ["owner",player,true];
}foreach(_furniture);


player addEventHandler ["GetInMan", {
	_veh = _this select 2;
	_owner = _veh getvariable "owner";
	if(isNil "_owner") then {
		_veh setVariable ["owner",player,true];
	};
}];

if (isMultiplayer) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
	["InitializeGroup", [player,playerSide,true]] call BIS_fnc_dynamicGroups;
};

[] spawn setupKeyHandler;

[] execVM "setupPlayer.sqf";