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
        condition = "params['_inSpawnDistance','_standing'];_standing < 50";
        script = "\overthrow_main\missions\factionweapons.sqf";
        chance = 5;
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
        repeatable = 1;
        condition = "params['_inSpawnDistance', '_standing', '_town', '_stability'];_stability < 50 && !(_town in (server getVariable ['NATOabandoned',[]]))";
        script = "\overthrow_main\missions\captureTown.sqf";
        chance = 100;
    };
};
