if(!isServer) exitWith {};

if !(isClass (configFile >> "CfgPatches" >> "OT_Overthrow_Main")) exitWith {
	diag_log "Overthrow addon not detected, you must add @Overthrow to your -mod commandline";
	"Overthrow addon not detected, you must add @Overthrow to your -mod commandline" call OT_fnc_notifyStart;
};

if (isDedicated) then {
	server_dedi = true;
}else{
	server_dedi = false;
};
publicVariable "server_dedi";

missionNamespace setVariable ["OT_varInitDone", false, true];

server = true call CBA_fnc_createNamespace;
publicVariable "server";
players_NS = true call CBA_fnc_createNamespace;
publicVariable "players_NS";
cost = true call CBA_fnc_createNamespace;
publicVariable "cost";
warehouse = true call CBA_fnc_createNamespace;
publicVariable "warehouse";
spawner = true call CBA_fnc_createNamespace;
publicVariable "spawner";
templates = true call CBA_fnc_createNamespace;
publicVariable "templates";
owners = true call CBA_fnc_createNamespace;
publicVariable "owners";
buildingpositions = true call CBA_fnc_createNamespace;
publicVariable "buildingpositions";
OT_civilians = true call CBA_fnc_createNamespace;
publicVariable "OT_civilians";

OT_centerPos = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

call OT_fnc_initBaseVar;
call compile preprocessFileLineNumbers "initVar.sqf";
call OT_fnc_initVar;

if(isServer) then {
    diag_log "Overthrow: Server Pre-Init";

    server setVariable ["StartupType","",true];
    call OT_fnc_initVirtualization;
};

OT_tpl_checkpoint = [] call compileFinal preProcessFileLineNumbers "data\templates\NATOcheckpoint.sqf";

//Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
[] spawn OT_fnc_advancedTowingInit;

[] spawn {
	if (false/*isDedicated && profileNamespace getVariable ["OT_autoload",false]*/) then {
		diag_log "== OVERTHROW == Mission autoloaded as per settings. Toggle in the options menu in-game to disable.";
		diag_log "== OVERTHROW == Waiting for a player to connect!";
		waitUntil{sleep 1; count (allPlayers - entities "HeadlessClient_F") > 0};
		[] spawn OT_fnc_loadGame;
	};

	waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};

	if(OT_fastTime) then {
	    setTimeMultiplier 4;
	};

	//Init factions
	[] spawn OT_fnc_initNATO;
	waitUntil {!isNil "OT_NATOInitDone"};
	[] spawn OT_fnc_factionNATO;
	[] spawn OT_fnc_factionGUER;
	[] spawn OT_fnc_factionCRIM;

	[] spawn OT_fnc_initEconomyLoad;

	//Game systems
	[] spawn OT_fnc_propagandaSystem;
	[] spawn OT_fnc_weatherSystem;
	[] spawn OT_fnc_incomeSystem;
	[] spawn OT_fnc_jobSystem;

	//Init virtualization
	waitUntil {!isNil "OT_economyLoadDone"};
	[] spawn OT_fnc_runVirtualization;

	//ACE3 Arsenal default loadouts
	{
		_x params ["_cls","_loadout"];
		[_cls call OT_fnc_vehicleGetName, _loadout] call ace_arsenal_fnc_addDefaultLoadout;
	}foreach(OT_Recruitables);
	["Police", OT_Loadout_Police] call ace_arsenal_fnc_addDefaultLoadout;

	//Subscribe to events
	if(isMultiplayer) then {
	    addMissionEventHandler ["PlayerConnected",OT_fnc_playerConnectHandler];
	    addMissionEventHandler ["HandleDisconnect",OT_fnc_playerDisconnectHandler];
	};
	["Building", "Dammaged", OT_fnc_buildingDamagedHandler] call CBA_fnc_addClassEventHandler;

	//ACE3 events
	["ace_cargoLoaded",OT_fnc_cargoLoadedHandler] call CBA_fnc_addEventHandler;
	["ace_common_setFuel",OT_fnc_refuelHandler] call CBA_fnc_addEventHandler;
	["ace_explosives_place",OT_fnc_explosivesPlacedHandler] call CBA_fnc_addEventHandler;
	["ace_tagCreated", OT_fnc_taggedHandler] call CBA_fnc_addEventHandler;

	//Overthrow events
	["OT_QRFstart", OT_fnc_QRFStartHandler] call CBA_fnc_addEventHandler;
	["OT_QRFend", OT_fnc_QRFEndHandler] call CBA_fnc_addEventHandler;

	if(isServer) then {
		addMissionEventHandler ["EntityKilled",OT_fnc_deathHandler];

		["OT_autosave_loop"] call OT_fnc_addActionLoop;
		["OT_civilian_cleanup_crew", "time > OT_cleanup_civilian_loop","
			OT_cleanup_civilian_loop = time + (5*60);
			private _totalcivs = {(side _x isEqualTo civilian) && !captive _x} count (allUnits);
			{
				if(_x getVariable [""OT_Looted"",false]) then {
					private _stock = _x call OT_fnc_unitStock;
					if((count _stock) isEqualTo 0) then {
						deleteVehicle _x;
					};
				};
			}forEach(alldeadmen);
			if(_totalcivs < 50) exitWith {};
			{
				if (side group _x isEqualTo civilian && {!(isPlayer _x)} && {!(_x getVariable [""shopcheck"",false])} && { ({side _x isEqualTo civilian} count ((getPos _x) nearObjects [""CAManBase"",150])) > round(150*OT_spawnCivPercentage) } ) then {
					private _group = group _x;
					private _unit = _x;
					deleteVehicle _unit;
					if (count units _group < 1) then {
						deleteGroup _group;
					};
				};
			}forEach (allUnits);
		"] call OT_fnc_addActionLoop;
	};

	OT_serverInitDone = true;
	publicVariable "OT_serverInitDone";
	if(isServer) then {
	    diag_log "Overthrow: Server Pre-Init Done";
	};
};
