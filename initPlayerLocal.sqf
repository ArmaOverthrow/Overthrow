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


if(isMultiplayer and (!isServer)) then {
	call compile preprocessFileLineNumbers "initFuncs.sqf";
	call compile preprocessFileLineNumbers "initVar.sqf";
};

player setVariable ["money",100,true];
player setVariable ["owner",player,true];

if(isMultiplayer) then {
	titleText ["Waiting for server...", "BLACK FADED", 0];
}else{
	titleText ["Please wait... generating economy", "BLACK FADED", 0];
};

if !(isMultiplayer) then {
	waitUntil {!isNil "AIT_serverInitDone"};
}else{
	waitUntil {server getVariable ["spawntown",""] != ""};
};

player forceAddUniform (AIT_clothes_locals call BIS_fnc_selectRandom);

_newplayer = true;
_furniture = [];
_town = "";
_pos = [];
_housepos = [];

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
		_pos = server getVariable _town;
		_housepos = getpos _house;
		_furniture = _house getVariable "furniture";
		
		_owned = player getVariable "owned";
		{
			_x setVariable ["owner",player,true];
		}foreach(_owned + _furniture);		
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
	player setVariable ["rep",0,true];
	{
		player setVariable [format["rep%1",_x],0,true];
	}foreach(AIT_allTowns);

	_town = server getVariable "spawntown";
	if(AIT_randomSpawnTown) then {
		_town = AIT_spawnTowns call BIS_fnc_selectRandom;
	};
	_pos = server getVariable _town;

	_house = [_pos,AIT_spawnHouses] call getRandomBuilding;
	if(isNil "_house") then {
		_spawntowns = [];
		_stability = server getvariable format["stability%1",_x];
		//spawntown is full or has no houses left, move it
		if((_stability > 70) and !(_x in AIT_spawnBlacklist) and _x != _town) then {
			_spawntowns pushBack _name;
		};
		_town = _spawntowns call BIS_fnc_selectrandom;
		server setVariable ["spawntown",_town,true];
		_pos = server getvariable _town;
		_house = [_pos,AIT_spawnHouses] call getRandomBuilding;
	};
	_housepos = getpos _house;
	
	//Put a light on at home
	_light = "#lightpoint" createVehicle [_housepos select 0,_housepos select 1,(_housepos select 2)+2.2];
	_light setLightBrightness 0.09;
	_light setLightAmbient[.9, .9, .6];
	_light setLightColor[.5, .5, .4];

	_house setVariable ["owner",player,true];
	player setVariable ["home",_house,true];

	_furniture = (_house call spawnTemplate) select 0;
	_house setVariable ["furniture",_furniture];
	
	{
		if(typeof _x == AIT_item_Desk) then {
			_deskobjects = [_x,template_playerDesk] call spawnTemplateAttached;
		};
	}foreach(_furniture);	
};

{	
	if(typeof _x == AIT_item_Map) then {
		_x addAction ["Town Info", "actions\townInfo.sqf",nil,0,false,true,"",""];
		_x addAction ["Most Wanted", "actions\mostWanted.sqf",nil,0,false,true,"",""];
	};
	if(typeof _x == AIT_item_Repair) then {
		_x addAction ["Repair Nearby Vehicles", "actions\repairAll.sqf",nil,0,false,true,"",""];
	};
}foreach(_furniture);

_pos = _housepos;
{
	_x addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
	_x setVariable ["owner",player,true];
}foreach(_furniture);

player setCaptive true;
player setPos _pos;
titleText ["", "BLACK IN", 5];

//put a marker on home
_mrkName = format["home-%1",getPlayerUID player];
if((markerpos _mrkName) select 0 == 0) then {
	_mrkName = createMarker [_mrkName,_housepos];
	_mrkName setMarkerShape "ICON";
	_mrkName setMarkerType "loc_Tourism";
	_mrkName setMarkerColor "ColorWhite";
	_mrkName setMarkerAlpha 0;
};
_mrkName setMarkerAlphaLocal 1;


if (isMultiplayer) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
	["InitializeGroup", [player,playerSide,true]] call BIS_fnc_dynamicGroups;
};

[] spawn setupKeyHandler;

[] execVM "setupPlayer.sqf";