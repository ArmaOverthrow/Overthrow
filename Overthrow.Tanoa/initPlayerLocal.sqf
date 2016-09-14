player createDiaryRecord ["Diary", ["Quick Start", "You can press Y to open a menu with various options that affect your immediate surroundings. The menu is different according to context, ie if you are in a vehicle or have recruits selected. Your house is marked on the map and contains items with further options. Small towns with low stability generally offer more opportunities early on for bounties and trade. Cars can be purchased from the car dealers at fuel stations and in larger towns. If you need a weapon try asking around at shops, you may need to check the town info on your whiteboard at home to find where they are."]];
player createDiaryRecord ["Diary", ["Standing", "Each player also has a local and global standing that affects prices and your notoriety amongst NATO and underworld elements. Your standing will increase when you kill known criminals or perform tasks that the public support, and decrease when you cause instability or chaos."]]; 
player createDiaryRecord ["Diary", ["Stability", "Each town in Tanoa has a stability percentage that affects local prices and the garrison strength of the town. An unstable town may attract underworld elements or sink into total anarchy if NATO is unable to establish order there."]]; 
player createDiaryRecord ["Diary", ["Background", "The year is 2025. Tanoa, a small pacific nation of only about 5000 people has been under occupation by NATO forces for almost five years. In 2020, international pressure mounted to remove a brutal dictator from the country and the international military consortium was put into action. A short and effective campaign saw the dictator fleeing to nearby Samoa after only a few hours of NATO air strikes. But five years have passed under international military rule. There have been minimal efforts at rebuilding the nation's once proud shipping industry and unemployment is at ridiculous levels. Political leaders from the east and west cannot agree on the future of Tanoa and the citizens are starting to wonder why it is even up to them at all. In these tense times, protests started forming in the less-populated south of Tanoa, centered around the capitals Balavu and Katkoula. A strong leader emerges from one of the many unorganized groups and he calls for a mass protest in the nation's capital Georgetown, with all disparate and misaligned groups to attend under the one banner of 'Free Tanoa'. That protest was last night, and that leader was shot live on international television by an unknown assailant. Tanoa awakes this morning to a strange new feeling of uncertainty. Was NATO ordered to carry out the assasination? If not, then who was responsible? One thing is definitely certain and it's written all over the signs now covered in blood in Georgetown. It's time for NATO to go. It's time to Free Tanoa."]]; 
    

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



if(player == bigboss and (server getVariable ["StartupType",""] == "")) then {
    waitUntil {!(isnull (findDisplay 46))};
    sleep 1;
    _nul = createDialog "AIT_dialog_start";
}else{
    titleText ["Waiting for host...", "BLACK FADED", 0];    
};
waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
player forceAddUniform (AIT_clothes_locals call BIS_fnc_selectRandom);
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
					[_civ] joinSilent grpNull;
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
		//Spawn town is full, make a new one
        _town = (AIT_spawnTowns - [_town]) call BIS_fnc_selectrandom;
        server setVariable ["spawntown",_town,true];
        _pos = server getvariable _town;
        _house = [_pos,AIT_spawnHouses] call getRandomBuilding;
    };
    _housepos = getpos _house;
    
    //Put a light on at home
    _light = "#lightpoint" createVehicle [_housepos select 0,_housepos select 1,(_housepos select 2)+2.2];
    _light setLightBrightness 0.11;
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
_count = 0;
{ 
	if !(_x isKindOf "Vehicle") then {
		if(_x call hasOwner) then {
			_owner = _x getVariable ["owner",""];
			if((_owner == getplayeruid player) or (typeof _x == AIT_item_Map)) then {
				_x call initObjectLocal;
			};
		}; 
	};
	if(_count > 5000) then {
		_count = 0;
		titleText ["Loading... please wait", "BLACK FADED", 0];   
	};
	_count = _count + 1;
}foreach((allMissionObjects "Building") + vehicles);

player setCaptive true;
player setPos _housepos;

waitUntil {!isNil "AIT_SystemInitDone"};
titleText ["", "BLACK IN", 5];

if (isMultiplayer) then {
    ["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
};

player addEventHandler ["WieaponAssembled",{
	_me = _this select 0;
	_wpn = _this select 1;
	if(typeof _wpn in AIT_staticMachineGuns) then {		
		_wpn remoteExec["initStaticMGLocal",0,_wpn];
	};
	if(typeof _wpn in AIT_staticWeapons) then {
		if(_me call unitSeen) then {
			_me setCaptive false;
		};
	};
}];

player addEventHandler ["GetInMan",{						
	_unit = _this select 0;
	_position = _this select 1;
	_veh = _this select 2;
	_notified = false;
	
	if(_position == "driver") then {
		if !(_veh call hasOwner) then {
			_veh setVariable ["owner",getplayeruid player,true];
			_veh setVariable ["stolen",true,true];
			if(_unit call unitSeenNATO) then {
				_notified = true;
				{
					_x setCaptive false;
				}foreach(units _veh);
				_veh spawn revealToNATO;
			};
		};
	};
	_g = _v getVariable ["vehgarrison",false];
	if(typename _g == "STRING") then {
		_vg = server getVariable format["vehgarrison%1",_g];
		_vg deleteAt (_vg find (typeof _veh));
		server setVariable [format["vehgarrison%1",_g],_vg,false];
		_veh setVariable ["vehgarrison",nil,true];
	};
	_g = _v getVariable ["airgarrison",false];
	if(typename _g == "STRING") then {
		_vg = server getVariable format["airgarrison%1",_g];
		_vg deleteAt (_vg find (typeof _veh));
		server setVariable [format["airgarrison%1",_g],_vg,false];
		_veh setVariable ["airgarrison",nil,true];
	};
	
	if !(_notified) then {
		if (!(_veh call hasOwner) or !((typeof _veh) in AIT_allVehicles)) then {
			if(_unit call unitSeenNATO) then {
				_notified = true;
				{
					_x setCaptive false;
				}foreach(units _veh);
				_veh spawn revealToNATO;
			};
		};
	};
}];

[] execVM "stats.sqf";
[] spawn setupKeyHandler;
[] execVM "intelSystem.sqf";
[] execVM "setupPlayer.sqf";