class CfgOverthrowMissions
{
    class MedicalSupplies
    {
        target = "Town";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_stability'];_inSpawnDistance && _stability < 50";
        script = "\overthrow_main\missions\medicalsupplies.sqf";
        chance = 10;
    };

    class Informant
    {
        target = "Global";
        repeatable = 1;
        condition = "params['_numAbandoned'];_numAbandoned > 0";
        script = "\overthrow_main\missions\informant.sqf";
        chance = 1;
    };

    class FactionWeapons
    {
        target = "Faction";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_standing'];_standing < 50";
        script = "\overthrow_main\missions\factionweapons.sqf";
        chance = 3;
    };

    class Fugitive
    {
        target = "Faction";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_standing'];_inSpawnDistance";
        script = "\overthrow_main\missions\fugitive.sqf";
        chance = 2;
    };

    class CaptureTown
    {
        target = "Faction";
        repeatable = 0;
        condition = "params['_inSpawnDistance', '_standing', '_town', '_stability'];_stability < 50 && !(_town in (server getVariable ['NATOabandoned',[]]))";
        script = "\overthrow_main\missions\captureTown.sqf";
        chance = 10;
    };

    class ReconBase
    {
        target = "Base";
        repeatable = 0;
        condition = "params['_inSpawnDistance', '_name'];!(_name in (server getVariable ['NATOabandoned',[]])) && _stability < 50 && (server getVariable [format[""garrison%1"",_name],0]) > 0";
        script = "\overthrow_main\missions\reconBase.sqf";
        chance = 10;
    };

    class ReconTown
    {
        target = "Town";
        repeatable = 0;
        condition = "params['_inSpawnDistance','_stability','_name'];!(_name in (server getVariable ['NATOabandoned',[]])) && _stability < 50 && (server getVariable [format[""garrison%1"",_name],0]) > 0";
        script = "\overthrow_main\missions\reconTown.sqf";
        chance = 10;
    };
};
