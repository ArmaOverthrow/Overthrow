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
    [] execVM "initEconomyLoad.sqf";

	if(OT_fastTime) then {
		setTimeMultiplier 4;
	};

    //Init factions
    [] execVM "factions\NATO.sqf";
	[] execVM "factions\GUER.sqf";
    [] execVM "factions\CRIM.sqf";
    waitUntil {!isNil "OT_NATOInitDone"};
    waitUntil {!isNil "OT_CRIMInitDone"};

    //Game systems
    [] execVM "bountySystem.sqf";
	[] execVM "propagandaSystem.sqf";
	[] execVM "weather.sqf";

    //Init virtualization
    [] spawn OT_fnc_runVirtualization;
    waitUntil {!isNil "OT_economyLoadDone" and !isNil "OT_fnc_registerSpawner"};
    [] execVM "virtualization\towns.sqf";
    [] execVM "virtualization\military.sqf";
    [] execVM "virtualization\mobsters.sqf";

    missionNamespace setVariable [getplayeruid player,player,true];
    if(OT_hasAce) then {
        //ACE events
        ["ace_cargoLoaded",compile preprocessFileLineNumbers "events\cargoLoaded.sqf"] call CBA_fnc_addEventHandler;
    };

    OT_serverInitDone = true;
    publicVariable "OT_serverInitDone";
};
