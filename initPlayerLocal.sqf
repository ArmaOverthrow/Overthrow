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

player forceAddUniform (AIT_clothes_locals call BIS_fnc_selectRandom);

if(player == bigboss) then {
	waitUntil {!(isnull (findDisplay 46))};
	sleep 1;
	_nul = createDialog "AIT_dialog_start";
}else{
	titleText ["Waiting for host...", "BLACK FADED", 0];	
};
waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};

_newplayer = true;
_furniture = [];
_town = "";
_pos = [];
_housepos = [];

player addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_dmg = _this select 2;
	_src = _this select 3;
	_proj = _this select 4;
	_veh = vehicle _src;
	if(_veh != _src) then {
		if((driver _veh) == _src) then {
			_dmg = _dmg * 0.01;
		};
	};
	_dmg;
}];

if(isMultiplayer || (server getVariable "StartupType") == "LOAD") then {
	_data = server getvariable (getplayeruid player);
	if !(isNil "_data") then {
		_newplayer = false;
		{
			_key = _x select 0;
			_val = _x select 1;
			if(_key == "home") then {
				_val = nearestBuilding _val;
			};
			if(_key == "owned") then {
				_d = [];
				{
					_d pushback nearestBuilding _x;
				}foreach(_val);
				_val = _d;
			};
			player setVariable [_key,_val,true];
		}foreach(_data);		
		
		_house = player getVariable "home";
		_town = (getpos _house) call nearestTown;
		_pos = server getVariable _town;
		_housepos = getpos _house;
		
		_owned = player getVariable "owned";
		{
			_x setVariable ["owner",getPlayerUID player,true];
			_mrkName = format["%1",_x];
			if((markerpos _mrkName) select 0 == 0) then {
				_mrkName = createMarkerLocal [_mrkName,getpos _x];
				_mrkName setMarkerShape "ICON";
				_mrkName setMarkerType "loc_Tourism";
				_mrkName setMarkerColor "ColorWhite";
				_mrkName setMarkerAlpha 0;
			};
			_mrkName setMarkerAlphaLocal 1;
		}foreach(_owned);		
		
		{
			if(_x call hasOwner) then {
				if ((_x getVariable "owner" == getPlayerUID player) and !(_x isKindOf "LandVehicle") and !(_x isKindOf "Building")) then {
					_furniture pushback _x					
				};
			};	
		}foreach(_housepos nearObjects 50);
	};

	//JIP interactions
	_shops = spawner getVariable ["activeshops",[]];
	{
		_x call initShopLocal;
	}foreach(_shops);

	_shops = spawner getVariable ["activecarshops",[]];
	{
		_x call initCarShopLocal;
	}foreach(_shops);

	_shops = spawner getVariable ["activedealers",[]];
	{
		_x call initGunDealerLocal;
	}foreach(_shops);
};

if (_newplayer) then {
	player setVariable ["money",100,true];
	player setVariable ["owner",getplayerUID player,true];
	if(!isMultiplayer) then	{
		{
			if(! (isPlayer _x) ) then {
			 deleteVehicle _x;
			};
		} foreach switchableUnits;
	};
	player createDiaryRecord ["Diary", ["Quick Start", "You can press Y to open a menu with various options that affect your immediate surroundings. Your house is marked on the map and contains items with further options. Small towns with low stability generally offer more opportunities early on for bounties and trade. Cars can be purchased from the car dealers at fuel stations and in larger towns. If you need a weapon try asking around at shops, you may need to check the town info on your whiteboard at home to find where they are."]];
	player createDiaryRecord ["Diary", ["Standing", "Each player also has a local and global standing that affects prices. Standing is increased by killing criminal elements (red, opfor) or by throwing lots of money around buying real estate, walking up to civilians and giving it to them, or hiring them. Standing will decrease when you commit crime."]]; 
	player createDiaryRecord ["Diary", ["Stability", "Each town in Tanoa has a stability percentage that affects local prices and the garrison strength of the town. When it is below 50% you will see a red marker on the map that increases in visibility as stability gets lower. NATO will decide to abandon a town if it drops too low and they are unable to establish order. Stability is only increased by killing criminal elements, which will continue to arrive after NATO has abandoned a town even if stability is high. Stability will decrease when NATO or civilians are killed."]]; 
	player createDiaryRecord ["Diary", ["Background", "NATO forces are occupying Tanoa after removing an evil dictator. Various smaller towns are still in a state of disarray but order has been achieved for the most part and the economy has started to recover, however many start to grow weary about the lack of local leadership and various criminal elements have been spotted in the less stable regions of the country. The time is ripe for revolution. It's time to take Tanoa back."]]; 
	
	
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

	_house setVariable ["owner",getPlayerUID player,true];
	player setVariable ["home",_house,true];

	_furniture = (_house call spawnTemplate) select 0;

	{
		if(typeof _x == AIT_item_Storage) then {
			_x addWeaponCargo [AIT_item_BasicGun,1];
			_x addMagazineCargo [AIT_item_BasicAmmo,5];
			_box = _x;
			{
				_box addItemCargo [_x,5];
			}foreach(AIT_consumableItems);
		};
		if(typeof _x == AIT_item_Desk) then {
			_deskobjects = [_x,template_playerDesk] call spawnTemplateAttached;
		};
		_x setVariable ["owner",getplayerUID player,true];
	}foreach(_furniture);	
	player setVariable ["owned",[_house],true];
	
	_mrkName = format["home-%1",getPlayerUID player];
	if((markerpos _mrkName) select 0 == 0) then {
		_mrkName = createMarker [_mrkName,_housepos];
		_mrkName setMarkerShape "ICON";
		_mrkName setMarkerType "loc_Tourism";
		_mrkName setMarkerColor "ColorWhite";
		_mrkName setMarkerAlpha 0;
	};
	_mrkName setMarkerAlphaLocal 1;

};

{	
	if(typeof _x == AIT_item_Map) then {
		_x addAction ["Town Info", "actions\townInfo.sqf",nil,0,false,true,"",""];
		_x addAction ["Most Wanted", "actions\mostWanted.sqf",nil,0,false,true,"",""];
		if(player == bigboss) then {
			_x addAction ["Options", {
				closedialog 0;			
				_nul = createDialog "AIT_dialog_options";
			},nil,0,false,true,"",""];			
		};
	};
	if(typeof _x == AIT_item_Repair) then {
		_x addAction ["Repair Nearby Vehicles", "actions\repairAll.sqf",nil,0,false,true,"",""];
	};
	_x addAction ["Move this", "actions\move.sqf",nil,0,false,true,"",""];
}foreach(_furniture);

player setCaptive true;
player setPos _housepos;
titleText ["", "BLACK IN", 5];

if (isMultiplayer) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
	["InitializeGroup", [player,playerSide,true]] call BIS_fnc_dynamicGroups;
};

[] spawn setupKeyHandler;

[] execVM "setupPlayer.sqf";