/*
 * Overthrow
 * By ARMAzac
 *
 * https://github.com/armazac/Overthrow.Tanoa
 */
if !(isClass (configFile >> "CfgPatches" >> "OT_Overthrow_Main")) exitWith {
	_txt = format ["<t size='0.5' color='#000000'>Overthrow addon not detected, you must add @Overthrow to your -mod commandline</t>",_this];
    [_txt, 0, 0.2, 30, 0, 0, 2] spawn bis_fnc_dynamicText;
};

inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

if(!isMultiplayer) then {

    //Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
    [] execVM "funcs\fn_advancedTowingInit.sqf";

	//TFAR Support, thanks to Dedmen for the help
	[] call OT_fnc_initTFAR;
	if (OT_hasTFAR) then {
	   player linkItem "tf_anprc148jem";
	};

    call compile preprocessFileLineNumbers "initFuncs.sqf";
    call compile preprocessFileLineNumbers "initVar.sqf";

    //SINGLE PLAYER init
    waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
    [] spawn OT_fnc_initEconomyLoad;

	if(OT_fastTime) then {
		setTimeMultiplier 4;
	};

    //Init factions
	[] call OT_fnc_initNATO;
    [] execVM "factions\NATO.sqf";
	[] execVM "factions\GUER.sqf";
    [] execVM "factions\CRIM.sqf";
    waitUntil {!isNil "OT_NATOInitDone"};
    waitUntil {!isNil "OT_CRIMInitDone"};

    //Game systems
	[] spawn OT_fnc_propagandaSystem;
	[] spawn OT_fnc_weatherSystem;

    //Init virtualization
    [] spawn OT_fnc_runVirtualization;
    waitUntil {!isNil "OT_economyLoadDone" and !isNil "OT_fnc_registerSpawner"};
    [] execVM "virtualization\towns.sqf";
    [] execVM "virtualization\military.sqf";
    [] execVM "virtualization\mobsters.sqf";
	[] execVM "virtualization\economy.sqf";
	[] execVM "virtualization\factions.sqf";

    missionNamespace setVariable [getplayeruid player,player,true];

	["ace_cargoLoaded",OT_fnc_cargoLoadedHandler] call CBA_fnc_addEventHandler;
	["ace_common_setFuel",OT_fnc_refuelHandler] call CBA_fnc_addEventHandler;
	["ace_explosives_place",OT_fnc_explosivesPlacedHandler] call CBA_fnc_addEventHandler;

	//Setup fuel pumps for interaction
	{
		[_x,0] call ace_interact_menu_fnc_addMainAction;
	}foreach(OT_fuelPumps);


    OT_serverInitDone = true;
    publicVariable "OT_serverInitDone";
};
