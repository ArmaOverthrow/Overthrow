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

server setVariable [format["name%1",getplayeruid player],name player,true];

if(isMultiplayer and (!isServer)) then {
    call compile preprocessFileLineNumbers "initFuncs.sqf";
    call compile preprocessFileLineNumbers "initVar.sqf";
};

player forceAddUniform (AIT_clothes_locals call BIS_fnc_selectRandom);

if(player == bigboss and (server getVariable ["StartupType",""] == "")) then {
    waitUntil {!(isnull (findDisplay 46))};
    sleep 1;
    _nul = createDialog "AIT_dialog_start";
}else{
    titleText ["Waiting for host...", "BLACK FADED", 0];    
};
waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};

_startup = server getVariable "StartupType";
_newplayer = true;
_furniture = [];
_town = "";
_pos = [];
_housepos = [];

if(isMultiplayer or _startup == "LOAD") then {
    _data = server getvariable (getplayeruid player);
    if !(isNil "_data") then {
        _newplayer = false;
        {
            _key = _x select 0;
            _val = _x select 1;
            if(_key == "home") then {
                _val = nearestBuilding _val;
            };
            if(_key == "camp" and typename _val == "ARRAY") then {              
                _val = createVehicle [AIT_item_tent, _val, [], 0, "CAN_COLLIDE"];
                _val setVariable ["owner",getplayeruid player,true];
                _val call initObjectLocal;
                
                _v = "Land_ClutterCutter_large_F" createVehicle (getpos _val);
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
        
        _recruits = server getVariable ["recruits",[]];
        _newrecruits = [];
        {
            _owner = _x select 0;
            _name = _x select 1;    
            _civ = _x select 2;                 
            _rank = _x select 3;                
            _loadout = _x select 4;
            _type = _x select 5;    
            if(_owner == (getplayeruid player)) then {                          
                if(typename _civ == "ARRAY") then {
                    _civ =  group player createUnit [_type,_civ,[],0,"NONE"];
					_civ setVariable ["owner",getplayeruid player,true];
					[_civ, (AIT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _civ];
					[_civ, (AIT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _civ];            
                    _civ setUnitLoadout _loadout;
                    _civ spawn wantedSystem;
                    _civ setName _name;
                    [_civ] joinSilent (group player);
                }else{
                    [_civ] joinSilent (group player);
                };              
            };
            _newrecruits pushback [_owner,_name,_civ,_rank,_loadout,_type];
        }foreach (_recruits);
        server setVariable ["recruits",_newrecruits,true];
    };

    //JIP interactions
    {
		if((typename(_x getVariable ["shop",false])) == "STRING") then {
			_x call initShopLocal;
		};
		if(_x getVariable ["gundealer",false]) then {
			_x call initGunDealerLocal;
		};
		if(_x getVariable ["carshop",false]) then {
			_x call initCarShopLocal;
		};
		if(_x getVariable ["harbor",false]) then {
			_x call initHarborLocal;
		};
	}foreach(allUnits);
};

if (_newplayer) then {
    _clothes = (AIT_clothes_guerilla call BIS_fnc_selectRandom);
    player setVariable ["uniform",_clothes,true];
    player setVariable ["money",100,true];
    player setVariable ["owner",getplayerUID player,true];
    if(!isMultiplayer) then {
        {
            if(! (isPlayer _x) ) then {
             deleteVehicle _x;
            };
        } foreach switchableUnits;
    };
    player createDiaryRecord ["Diary", ["Quick Start", "You can press Y to open a menu with various options that affect your immediate surroundings. The menu is different according to context, ie if you are in a vehicle or have recruits selected. Your house is marked on the map and contains items with further options. Small towns with low stability generally offer more opportunities early on for bounties and trade. Cars can be purchased from the car dealers at fuel stations and in larger towns. If you need a weapon try asking around at shops, you may need to check the town info on your whiteboard at home to find where they are."]];
    player createDiaryRecord ["Diary", ["Standing", "Each player also has a local and global standing that affects prices and your notoriety amongst NATO and underworld elements. Your standing will increase when you kill known criminals or perform tasks that the public support, and decrease when you cause instability or chaos."]]; 
    player createDiaryRecord ["Diary", ["Stability", "Each town in Tanoa has a stability percentage that affects local prices and the garrison strength of the town. An unstable town may attract underworld elements or sink into total anarchy if NATO is unable to establish order there."]]; 
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
        if(typeof _x == AIT_item_Map) then {
            _x setObjectTextureGlobal [0,"dialogs\maptanoa.paa"];
        };
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
titleText ["Loading session...", "BLACK FADED", 0];    
sleep 0.2;
_count = 0;
{   
    if(_x call hasOwner) then {
        _owner = _x getVariable ["owner",""];
        if((_owner == getplayeruid player) or (typeof _x == AIT_item_Map)) then {
            _x call initObjectLocal;
        };
    };  
	if(_count > 5000) then {
		_count = 0;
		titleText ["Loading session... please wait", "BLACK FADED", 0];   
	};
	_count = _count + 1;
}foreach((allMissionObjects "Building") + vehicles);

player setCaptive true;
player setPos _housepos;

titleText ["", "BLACK IN", 5];

if (isMultiplayer) then {
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
    ["InitializeGroup", [player,playerSide,true]] call BIS_fnc_dynamicGroups;
};

player addEventHandler ["WeaponAssembled",{
	_me = _this select 0;
	_wpn = _this select 1;
	if(typeof _wpn in AIT_staticMachineGuns) then {
		_wpn addAction ["Rearm",{		
			_w = _this select 0;
			_p = _this select 1;
			if(_p call unitSeen) then {
				_p setCaptive false;
			};
			_ammocount = {_x == AIT_ammo_50cal} count (magazineCargo _p);
			if(_ammocount >= 4) then {
				disableUserInput true;
				_p removeMagazineGlobal AIT_ammo_50cal;
				_p removeMagazineGlobal AIT_ammo_50cal;
				_p removeMagazineGlobal AIT_ammo_50cal;
				_p removeMagazineGlobal AIT_ammo_50cal;
				_w spawn {					
					"Rearming MG..." call notify_minor;
					[15,false] call progressBar;
					sleep 15;
					[_this,1] remoteExec ["setVehicleAmmoDef",_this];
					"MG rearmed" call notify_minor;
					disableUserInput false;
				};				
			}else{
				"You need 4 x 12.7mm M2 HMG Belts to rearm this MG" call notify_minor;
			};			
		},_civ,1.5,false,true,"","(alive _target) and !(someAmmo _target)",5];
	};
	if(typeof _wpn in AIT_staticWeapons) then {
		if(_me call unitSeen) then {
			_me setCaptive false;
		};
	};
}];

[] spawn setupKeyHandler;
[] execVM "intelSystem.sqf";
[] execVM "setupPlayer.sqf";