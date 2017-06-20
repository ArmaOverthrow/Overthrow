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

    class FactionWeapons
    {
        target = "Faction";
        repeatable = 1;
        condition = "_inSpawnDistance and _standing < 50";
        script = "\ot\missions\factionweapons.sqf";
        chance = 100;
    };

    class Fugitive
    {
        target = "Faction";
        repeatable = 1;
        condition = "_standing > 0";
        script = "\ot\missions\fugitive.sqf";
        chance = 10;
    };
};
