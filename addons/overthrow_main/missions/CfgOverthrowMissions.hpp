class CfgOverthrowMissions
{
    class MedicalSupplies
    {
        target = "Town";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_stability'];_inSpawnDistance && _stability < 50";
        script = "\overthrow_main\missions\medicalsupplies.sqf";
        chance = 20;
    };

    class Tagging
    {
        target = "Town";
        repeatable = 0;
        condition = "params['_inSpawnDistance','_stability','_town'];_inSpawnDistance && _stability < 50 && !(_town in (server getVariable ['NATOabandoned',[]])) && ((server getVariable [format['tagsin%1',_town],0]) < 6)";
        script = "\overthrow_main\missions\tagging.sqf";
        chance = 25;
    };

    class Informant
    {
        target = "Global";
        repeatable = 1;
        condition = "params['_numAbandoned'];_numAbandoned > 0";
        script = "\overthrow_main\missions\informant.sqf";
        chance = 5;
    };

    class FactionWeapons
    {
        target = "Faction";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_standing'];_inSpawnDistance";
        script = "\overthrow_main\missions\factionweapons.sqf";
        chance = 10;
    };

    class Fugitive
    {
        target = "Faction";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_standing'];_inSpawnDistance";
        script = "\overthrow_main\missions\fugitive.sqf";
        chance = 5;
    };

    class CaptureTown
    {
        target = "Faction";
        repeatable = 0;
        condition = "params['_inSpawnDistance', '_standing', '_town', '_stability'];_inSpawnDistance && _stability < 50 && !(_town in (server getVariable ['NATOabandoned',[]]))";
        script = "\overthrow_main\missions\captureTown.sqf";
        chance = 50;
    };

    class ReconBase
    {
        target = "Base";
        repeatable = 0;
        condition = "params['_inSpawnDistance', '_name'];!(_name in (server getVariable ['NATOabandoned',[]])) && _inSpawnDistance && (server getVariable [format[""garrison%1"",_name],0]) > 0";
        script = "\overthrow_main\missions\reconBase.sqf";
        chance = 20;
    };

    class HVT
    {
        target = "HVT";
        repeatable = 1;
        condition = "params['_inSpawnDistance', '_name'];!(_name in (server getVariable ['NATOabandoned',[]])) && _inSpawnDistance";
        script = "\overthrow_main\missions\hvt.sqf";
        chance = 5;
    };

    class NATOmission
    {
        target = "NATOmission";
        repeatable = 0;
        condition = "true";
        script = "\overthrow_main\missions\natomissions.sqf";
        chance = 25;
    };
};
