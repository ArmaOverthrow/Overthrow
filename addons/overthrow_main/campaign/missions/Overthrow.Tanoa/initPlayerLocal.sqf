private ["_town","_house","_housepos","_pos","_pop","_houses","_mrk","_furniture"];
waitUntil {!isNull player};
waitUntil {player == player};

if(isNil "bigboss") then {bigboss = player;publicVariable "bigboss";};

removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;
removeBackpack player;
removeHeadgear player;
removeVest player;

player linkItem "ItemMap";

server setVariable [format["name%1",getplayeruid player],name player,true];
server setVariable [format["uid%1",name player],getplayeruid player,true];
spawner setVariable [format["%1",getplayeruid player],player,true];

if(isMultiplayer and (!isServer)) then {
    call compile preprocessFileLineNumbers "initFuncs.sqf";
    call compile preprocessFileLineNumbers "initVar.sqf";
};

_start = [1385.17,505.453,1.88826];
_introcam = "camera" camCreate _start;
_introcam camSetTarget [1420,535,5.8];
_introcam cameraEffect ["internal", "BACK"];
_introcam camSetFocus [15, 1];
_introcam camsetfov 1.1;
_introcam camCommit 0;
waitUntil {camCommitted _introcam};
introcam = _introcam;


if(player == bigboss and (server getVariable ["StartupType",""] == "")) then {
    waitUntil {!(isnull (findDisplay 46))};
    sleep 1;
    _nul = createDialog "OT_dialog_start";
}else{
	"Loading" call blackFaded;    
};
waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
player forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);
_startup = server getVariable "StartupType";
_newplayer = true;
_furniture = [];
_town = "";
_pos = [];
_housepos = [];

if(isMultiplayer or _startup == "LOAD") then {
	player remoteExec ["loadPlayerData",2,false];
    waitUntil{sleep 0.5;player getVariable ["OT_loaded",false]};
	_newplayer = player getVariable ["OT_newplayer",true];
	
	if(!_newplayer) then {
		_housepos = player getVariable "home";		
		if(isNil "_housepos") exitWith {_newplayer = true};
		_town = _housepos call nearestTown;
		_pos = server getVariable _town;
		
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
				[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _civ];
				[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _civ];            
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
    _clothes = (OT_clothes_guerilla call BIS_fnc_selectRandom);
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
    }foreach(OT_allTowns);

    _town = server getVariable "spawntown";
    if(OT_randomSpawnTown) then {
        _town = OT_spawnTowns call BIS_fnc_selectRandom;
    };
    _pos = server getVariable _town;

    _house = [_pos,OT_spawnHouses] call getRandomBuilding;
    if(isNil "_house") then {
		//Spawn town is full, make a new one
        _town = (OT_spawnTowns - [_town]) call BIS_fnc_selectrandom;
        server setVariable ["spawntown",_town,true];
        _pos = server getvariable _town;
        _house = [_pos,OT_spawnHouses] call getRandomBuilding;
    };
    _housepos = getpos _house;
    
    //Put a light on at home
    _light = "#lightpoint" createVehicle [_housepos select 0,_housepos select 1,(_housepos select 2)+2.2];
    _light setLightBrightness 0.11;
    _light setLightAmbient[.9, .9, .6];
    _light setLightColor[.5, .5, .4];

    _house setVariable ["owner",getPlayerUID player,true];
    player setVariable ["home",_housepos,true];

    _furniture = (_house call spawnTemplate) select 0;

    {
        if(typeof _x == OT_item_Map) then {
            _x setObjectTextureGlobal [0,"dialogs\maptanoa.paa"];
        };        
        if(typeof _x == OT_item_Desk) then {
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
			if((_owner == getplayeruid player) or (typeof _x == OT_item_Map)) then {
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

waitUntil {!isNil "OT_SystemInitDone"};
titleText ["Loading Session", "BLACK FADED", 0];
player setCaptive true;
player setPos _housepos;
titleText ["", "BLACK IN", 5];

player addEventHandler ["WeaponAssembled",{
	_me = _this select 0;
	_wpn = _this select 1;
	_pos = position _wpn;
	if(typeof _wpn in OT_staticMachineGuns) then {		
		_wpn remoteExec["initStaticMGLocal",0,_wpn];
	};
	if(typeof _wpn in OT_staticWeapons) then {
		if(_me call unitSeen) then {
			_me setCaptive false;
		};
	};
	if(isplayer _me) then {
		_wpn setVariable ["owner",getplayeruid _me,true];
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
		};
	};
	_g = _v getVariable ["vehgarrison",false];
	if(typename _g == "STRING") then {
		_vg = server getVariable format["vehgarrison%1",_g];
		_vg deleteAt (_vg find (typeof _veh));
		server setVariable [format["vehgarrison%1",_g],_vg,false];
		_veh setVariable ["vehgarrison",nil,true];
		{
			_x setCaptive false;
		}foreach(units _veh);
		_veh spawn revealToNATO;
	};
	_g = _v getVariable ["airgarrison",false];
	if(typename _g == "STRING") then {
		_vg = server getVariable format["airgarrison%1",_g];
		_vg deleteAt (_vg find (typeof _veh));
		server setVariable [format["airgarrison%1",_g],_vg,false];
		_veh setVariable ["airgarrison",nil,true];
		{
			_x setCaptive false;
		}foreach(units _veh);
		_veh spawn revealToNATO;
	};	
}];

if(_newplayer) then {
	if!(player getVariable ["tute",false]) then {
		createDialog "OT_dialog_tute";
		player setVariable ["tute",true,true];
	};
};
_introcam cameraEffect ["Terminate", "BACK" ];
_introcam = nil;

[] spawn setupKeyHandler;
[] execVM "setupPlayer.sqf";