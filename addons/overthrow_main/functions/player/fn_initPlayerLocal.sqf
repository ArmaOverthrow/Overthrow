if (!hasInterface) exitWith {};

if !(isClass (configFile >> "CfgPatches" >> "OT_Overthrow_Main")) exitWith {
	[
        format ["<t size='0.5' color='#000000'>Overthrow addon not detected, you must add @Overthrow to your -mod commandline</t>",_this],
        0,
        0.2,
        30,
        0,
        0,
        2
    ] spawn BIS_fnc_dynamicText;
};

waitUntil {!isNull player && player isEqualTo player};

enableSaving [false,false];
enableEnvironment [false,true];
setViewDistance 15;

if(isServer) then {
	missionNameSpace setVariable ["OT_HOST", player, true];
};

if(isNil {server getVariable "generals"}) then {
	server setVariable ["generals",[getplayeruid player]]
};

OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

if(isMultiplayer && (!isServer)) then {
	//TFAR Support, thanks to Dedmen for the help
	[] call OT_fnc_initTFAR;

	// both done on server too, no need to execute them again
	call compile preprocessFileLineNumbers "initVar.sqf";
	call OT_fnc_initVar;
}else{
	OT_varInitDone = true;
};

private _highCommandModule = (createGroup sideLogic) createUnit ["HighCommand",[0,0,0],[],0,"NONE"];
_highCommandModule synchronizeObjectsAdd [player];
missionNameSpace setVariable [format["%1_hc_module",getPlayerUID player],_highCommandModule,true];

private _start = OT_startCameraPos;
private _introcam = "camera" camCreate _start;
_introcam camSetTarget OT_startCameraTarget;
_introcam cameraEffect ["internal", "BACK"];
_introcam camSetFocus [15, 1];
_introcam camsetfov 1.1;
_introcam camCommit 0;
waitUntil {camCommitted _introcam};
showCinemaBorder false;

if(!isMultiplayer) exitWith {
	"Overthrow currently does not work very well in Single Player mode. Please host a LAN game for solo play. See the wiki at http://armaoverthrow.com/" call OT_fnc_notifyMinor;
};

if((isServer || count ([] call CBA_fnc_players) == 1) && (server getVariable ["StartupType",""] isEqualTo "")) then {
    waitUntil {!(isnull (findDisplay 46)) && OT_varInitDone};

	if (isServer || count ([] call CBA_fnc_players) == 1) then {
		sleep 1;
		if ((["ot_start_autoload", 0] call BIS_fnc_getParamValue) == 1) then {
			server setVariable ["OT_difficulty",["ot_start_difficulty", 1] call BIS_fnc_getParamValue,true];
			server setVariable ["OT_fastTravelType",["ot_start_fasttravel", 1] call BIS_fnc_getParamValue,true];
			[] remoteExec ['OT_fnc_loadGame',2,false];
		} else {
			createDialog "OT_dialog_start";
		};
	};
}else{
	"Loading" call OT_fnc_notifyStart;
};
waitUntil {sleep 1;!isNil "OT_NATOInitDone"};

private _aplayers = players_NS getVariable ["OT_allplayers",[]];
if ((_aplayers find (getplayeruid player)) isEqualTo -1) then {
	_aplayers pushback (getplayeruid player);
	players_NS setVariable ["OT_allplayers",_aplayers,true];
};
if(!isMultiplayer) then {
	private _generals = server getVariable ["generals",[]];
	if ((_generals find (getplayeruid player)) isEqualTo -1) then {
		_generals pushback (getplayeruid player);
		server setVariable ["generals",_generals,true];
	};
};
players_NS setVariable [format["name%1",getplayeruid player],name player,true];
players_NS setVariable [format["uid%1",name player],getplayeruid player,true];
spawner setVariable [format["%1",getplayeruid player],player,true];

player forceAddUniform (OT_clothes_locals call BIS_fnc_selectRandom);
// clear player
removeAllWeapons player;
removeAllAssignedItems player;
removeGoggles player;
removeBackpack player;
removeHeadgear player;
removeVest player;
player linkItem "ItemMap";

private _startup = server getVariable "StartupType";
private _newplayer = true;
private _furniture = [];
private _town = "";
private _pos = [];
private _housepos = [];

if(isMultiplayer || _startup == "LOAD") then {
	player remoteExec ["OT_fnc_loadPlayerData",2,false];
  waitUntil{sleep 0.5;player getVariable ["OT_loaded",false]};

	if (player getVariable["home",false] isEqualType []) then {
	  _newplayer = false;
	}else{
	  _newplayer = true;
	};


	if(isMultiplayer) then {
		//ensure player is in own group, not one someone else left
		private  _group = creategroup resistance;
		[player] joinSilent _group;
	};

	if(!_newplayer) then {
		_housepos = player getVariable "home";
		if(isNil "_housepos") exitWith {_newplayer = true};
		_town = _housepos call OT_fnc_nearestTown;
		_pos = server getVariable _town;
		{
			if(_x call OT_fnc_hasOwner) then {
				if ((_x call OT_fnc_playerIsOwner) && !(_x isKindOf "LandVehicle") && !(_x isKindOf "Building")) then {
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
		_xp = _x select 6;
		if(_owner isEqualTo (getplayeruid player)) then {
			if(typename _civ isEqualTo "ARRAY") then {
				_civ =  group player createUnit [_type,_civ,[],0,"NONE"];
				[_civ,getplayeruid player] call OT_fnc_setOwner;
				_civ setVariable ["OT_xp",_xp,true];
				_civ setVariable ["NOAI",true,true];
				_civ setRank _rank;
				if(_rank isEqualTo "PRIVATE") then {_civ setSkill 0.2 + (random 0.3)};
				if(_rank isEqualTo "CORPORAL") then {_civ setSkill 0.3 + (random 0.3)};
				if(_rank isEqualTo "SERGEANT") then {_civ setSkill 0.4 + (random 0.3)};
				if(_rank isEqualTo "LIEUTENANT") then {_civ setSkill 0.6 + (random 0.3)};
				if(_rank isEqualTo "CAPTAIN") then {_civ setSkill 0.7 + (random 0.3)};
				if(_rank isEqualTo "MAJOR") then {_civ setSkill 0.8 + (random 0.2)};
				[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
				[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
				_civ setUnitLoadout _loadout;
				_civ spawn OT_fnc_wantedSystem;
				_civ setName _name;
				_civ setVariable ["OT_spawntrack",true,true];

				[_civ] joinSilent nil;
				[_civ] joinSilent (group player);

				commandStop _civ;
			}else{
				if(_civ call OT_fnc_playerIsOwner) then {
					[_civ] joinSilent (group player);
				};
			};
		};
		_newrecruits pushback [_owner,_name,_civ,_rank,_loadout,_type];
	}foreach (_recruits);
	server setVariable ["recruits",_newrecruits,true];

	_squads = server getVariable ["squads",[]];
	_newsquads = [];
	_cc = 1;
	{
		_x params ["_owner","_cls","_group","_units"];
		if(_owner isEqualTo (getplayeruid player)) then {
			if(typename _group != "GROUP") then {
				_name = _cls;
				if(count _x > 4) then {
					_name = _x select 4;
				}else{
					{
						if((_x select 0) isEqualTo _cls) then {
							_name = _x select 2;
						};
					}foreach(OT_Squadables);
				};
				_group = creategroup resistance;
				_group setGroupIdGlobal [_name];
				{
					_x params ["_type","_pos","_loadout"];
					_civ = _group createUnit [_type,_pos,[],0,"NONE"];
					_civ setSkill 0.5 + (random 0.4);
					_civ setUnitLoadout _loadout;
					[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
					[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
					_civ setVariable ["OT_spawntrack",true,true];
				}foreach(_units);
			};
			player hcSetGroup [_group,groupId _group,"teamgreen"];
			_cc = _cc + 1;
		};
		_newsquads pushback [_owner,_cls,_group,[]];
	}foreach (_squads);
	player setVariable ["OT_squadcount",_cc,true];
	server setVariable ["squads",_newsquads,true];
};

if (_newplayer) then {
    _clothes = (OT_clothes_guerilla call BIS_fnc_selectRandom);
	player forceAddUniform _clothes;
    player setVariable ["uniform",_clothes,true];
	private _money = 100;
	private _diff = server getVariable ["OT_difficulty",1];
	if(_diff isEqualTo 0) then {
		_money = 1000;
	};
	if(_diff isEqualTo 2) then {
		_money = 0;
	};
    player setVariable ["money",_money,true];
    [player,getplayeruid player] call OT_fnc_setOwner;
    if(!isMultiplayer) then {
        {
            if(_x != player) then {
             	deleteVehicle _x;
            };
        } foreach switchableUnits;
    };

    _town = server getVariable "spawntown";
    if(OT_randomSpawnTown) then {
        _town = OT_spawnTowns call BIS_fnc_selectRandom;
    };
	_house = _town call OT_fnc_getPlayerHome;
    _housepos = getpos _house;

    //Put a light on at home
    _light = "#lightpoint" createVehicle [_housepos select 0,_housepos select 1,(_housepos select 2)+2.2];
    _light setLightBrightness 0.11;
    _light setLightAmbient[.9, .9, .6];
    _light setLightColor[.5, .5, .4];

	//Free quad
	_pos = _housepos findEmptyPosition [5,100,"C_Quadbike_01_F"];

	if (count _pos > 0) then {
		_veh = "C_Quadbike_01_F" createVehicle _pos;
		[_veh,getPlayerUID player] call OT_fnc_setOwner;
		clearWeaponCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;
		clearItemCargoGlobal _veh;
		player reveal _veh;
	};

    [_house,getplayeruid player] call OT_fnc_setOwner;
    player setVariable ["home",_housepos,true];

    _furniture = (_house call OT_fnc_spawnTemplate) select 0;

    {
		if(typeof _x isEqualTo OT_item_Storage) then {
            _x addItemCargoGlobal ["ToolKit", 1];
			_x addBackpackCargoGlobal ["B_AssaultPack_khk", 1];
			_x addItemCargoGlobal ["NVGoggles_INDEP", 1];
        };
        [_x,getplayeruid player] call OT_fnc_setOwner;
    }foreach(_furniture);
    player setVariable ["owned",[[_house] call OT_fnc_getBuildID],true];

};
_count = 0;
{
	if !(_x isKindOf "Vehicle") then {
		if(_x call OT_fnc_hasOwner) then {
			_x call OT_fnc_initObjectLocal;
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
[_housepos,_newplayer] spawn {
	params ["_housepos","_newplayer"];
	setViewDistance -1;
	waitUntil{ preloadCamera _housepos};
	titleText ["", "BLACK IN", 5];
	sleep 1;
	if(_newplayer) then {
		if!(player getVariable ["OT_tute",false]) then {
			createDialog "OT_dialog_tute";
			player setVariable ["OT_tute",true,true];
			player setVariable ["OT_tute_trigger",false,true];
		} else {
			player setVariable ["OT_tute_trigger",false,true];
		};
	} else {
		player setVariable ["OT_tute_trigger",false,true];
	};
	[[[format["%1, %2",(getpos player) call OT_fnc_nearestTown,OT_nation],"align = 'center' size = '0.7' font='PuristaBold'"],["","<br/>"],[format["%1/%2/%3",date#2,date#1,date#0]],["","<br/>"],[format["%1",[daytime,"HH:MM"] call BIS_fnc_timeToString],"align = 'center' size = '0.7'"],["s","<br/>"]]] spawn BIS_fnc_typeText2;
};

[] spawn {
	waitUntil{!(isNull (findDisplay 46))};
	(findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this#1) isEqualTo 1) then { [player] call OT_fnc_savePlayerData;	};"];
};

player addEventHandler ["WeaponAssembled",{
	params ["_me","_wpn"];
	private _pos = getPosATL _wpn;
	if(typeof _wpn in OT_staticMachineGuns) then {
		_wpn remoteExec["OT_fnc_initStaticMGLocal",0,_wpn];
	};
	if(typeof _wpn in OT_staticWeapons) then {
		if(_me call OT_fnc_unitSeen) then {
			_me setCaptive false;
		};
	};
	if(isplayer _me) then {
		[_wpn,getplayeruid player] call OT_fnc_setOwner;
	};
}];

player addEventHandler ["InventoryOpened", {
	params ["","_veh"];
	if(
		(_veh getVariable ["OT_locked",false])
		&&
		{ !((_veh call OT_fnc_getOwner) isEqualTo getplayeruid player) }
	) exitWith {
		format["This inventory has been locked by %1",server getVariable ("name"+(_veh call OT_fnc_getOwner))] call OT_fnc_notifyMinor;
		true
	};
	false
}];

player addEventHandler ["GetInMan",{
	params ["_unit","_position","_veh"];

	call OT_fnc_notifyVehicle;

	if(_position == "driver") then {
		if !(_veh call OT_fnc_hasOwner) then {
			[_veh,getplayeruid player] call OT_fnc_setOwner;
			_veh setVariable ["stolen",true,true];
			if((_veh getVariable ["ambient",false]) && (player call OT_fnc_unitSeenAny)) then {
				[(getpos player) call OT_fnc_nearestTown,-5,"Stolen vehicle",player] call OT_fnc_support;
				if(player call OT_fnc_unitSeenNATO) then {
					player setCaptive false;
					[player] call OT_fnc_revealToNATO;
				};
			};
		}else{
			if !(_veh call OT_fnc_playerIsOwner) then {
				private _isgen = call OT_fnc_playerIsGeneral;
				if(!_isgen && (_veh getVariable ["OT_locked",false])) then {
					moveOut player;
					format["This vehicle has been locked by %1",server getVariable "name"+(_veh call OT_fnc_getOwner)] call OT_fnc_notifyMinor;
				};
			};
		};
	};
	_g = _veh getVariable ["vehgarrison",false];
	if(_g isEqualType "") then {
		_vg = server getVariable format["vehgarrison%1",_g];
		_vg deleteAt (_vg find (typeof _veh));
		server setVariable [format["vehgarrison%1",_g],_vg,false];
		_veh setVariable ["vehgarrison",nil,true];
		{
			_x setCaptive false;
		}foreach(crew _veh);
		[_veh] call OT_fnc_revealToNATO;
	};
	_g = _veh getVariable ["airgarrison",false];
	if(_g isEqualType "") then {
		_vg = server getVariable format["airgarrison%1",_g];
		_vg deleteAt (_vg find (typeof _veh));
		server setVariable [format["airgarrison%1",_g],_vg,false];
		_veh setVariable ["airgarrison",nil,true];
		{
			_x setCaptive false;
		}foreach(crew _veh);
		[_veh] call OT_fnc_revealToNATO;
	};
}];

{
	_pos = buildingpositions getVariable [_x,[]];
	if(count _pos isEqualTo 0) then {
		_bdg = OT_centerPos nearestObject parseNumber _x;
		_pos = position _bdg;
		buildingpositions setVariable [_x,_pos,true];
	};
}foreach(player getvariable ["owned",[]]);

if(isMultiplayer) then {
	player addEventHandler ["Respawn",OT_fnc_respawnHandler];
};

OT_keyHandlerID = [21, [false, false, false], OT_fnc_keyHandler] call CBA_fnc_addKeyHandler;
[] call OT_fnc_setupPlayer;
_introcam cameraEffect ["Terminate", "BACK" ];
camDestroy _introcam;
