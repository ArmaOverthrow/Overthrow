class CfgOverthrowMissions
{
    class MedicalSupplies
    {
        target = "Town";
        repeatable = 1;
        condition = "_inSpawnDistance and _stability < 50";
        script = "\ot\missions\medicalsupplies.sqf";
    };
};
