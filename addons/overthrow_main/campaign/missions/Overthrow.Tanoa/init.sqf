/*
 * Overthrow 
 * By ARMAzac
 * 
 * https://github.com/armazac/Overthrow.Tanoa
 */


inGameUISetEventHandler ["PrevAction", ""];
inGameUISetEventHandler ["Action", ""];
inGameUISetEventHandler ["NextAction", ""];

if(!isMultiplayer) then {       
    //VCOM AI, huge credits to Genesis, without VCOM this mission would be so much less
    [] execVM "VCOMAI\init.sqf";
    
    //Advanced towing script, credits to Duda http://www.armaholic.com/page.php?id=30575
    [] execVM "funcs\fn_advancedTowingInit.sqf";
    
    call compile preprocessFileLineNumbers "initFuncs.sqf";
    call compile preprocessFileLineNumbers "initVar.sqf";

    //SINGLE PLAYER init    
    waitUntil {sleep 1;server getVariable ["StartupType",""] != ""};
    [] execVM "initEconomyLoad.sqf";
        
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
    [] execVM "virtualization.sqf"; 
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
