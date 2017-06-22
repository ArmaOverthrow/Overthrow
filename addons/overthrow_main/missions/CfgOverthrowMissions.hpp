class CfgOverthrowMissions
{
    class MedicalSupplies
    {
        target = "Town";
        repeatable = 1;
        condition = "_inSpawnDistance and _stability < 50";
        script = "\ot\missions\medicalsupplies.sqf";
        chance = 100;
    };

    class Informant
    {
        target = "Global";
        repeatable = 1;
        condition = "_numAbandoned > 0";
        script = "\ot\missions\informant.sqf";
        chance = 15;
    };

    class FactionWeapons
    {
        target = "Faction";
        repeatable = 1;
        condition = "_standing < 50";
        script = "\ot\missions\factionweapons.sqf";
        chance = 100;
    };

    class Fugitive
    {
        target = "Faction";
        repeatable = 1;
        condition = "_inSpawnDistance";
        script = "\ot\missions\fugitive.sqf";
        chance = 10;
    };
};
