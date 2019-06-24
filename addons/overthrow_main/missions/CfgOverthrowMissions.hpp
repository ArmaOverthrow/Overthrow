class CfgOverthrowMissions
{
    class MedicalSupplies
    {
        target = "Town";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_stability'];_inSpawnDistance && _stability < 50";
        script = "\overthrow_main\missions\medicalsupplies.sqf";
        chance = 20;
        expires = 24;
        requestable = 0;
    };

    class Tagging
    {
        target = "Town";
        repeatable = 0;
        condition = "params['','','_town'];!(_town in (server getVariable ['NATOabandoned',[]])) && ((server getVariable [format['tagsin%1',_town],0]) < 6)";
        script = "\overthrow_main\missions\tagging.sqf";
        chance = 25;
        expires = 6;
        requestable = 1;
    };

    class KillNATO
    {
        target = "Town";
        repeatable = 0;
        condition = "params['','','_town'];!(_town in (server getVariable ['NATOabandoned',[]]))";
        script = "\overthrow_main\missions\kill.sqf";
        chance = 100;
        expires = 2;
        requestable = 1;
    };

    class Informant
    {
        target = "Global";
        repeatable = 1;
        condition = "params['_numAbandoned'];_numAbandoned > 0";
        script = "\overthrow_main\missions\informant.sqf";
        chance = 5;
        expires = 24;
        requestable = 0;
    };

    class FactionWeapons
    {
        target = "Faction";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_standing'];_inSpawnDistance";
        script = "\overthrow_main\missions\factionweapons.sqf";
        chance = 10;
        expires = 24;
        requestable = 0;
    };

    class Fugitive
    {
        target = "Faction";
        repeatable = 1;
        condition = "params['_inSpawnDistance','_standing'];_inSpawnDistance";
        script = "\overthrow_main\missions\fugitive.sqf";
        chance = 5;
        expires = 24;
        requestable = 0;
    };

    class CaptureTown
    {
        target = "Faction";
        repeatable = 0;
        condition = "params['_inSpawnDistance', '', '_town', '', '_population'];_inSpawnDistance && (_population > 100) && !(_town in (server getVariable ['NATOabandoned',[]]))";
        script = "\overthrow_main\missions\captureTown.sqf";
        chance = 50;
        expires = 0;
        requestable = 0;
    };

    class TransportOperative
    {
        target = "Faction";
        repeatable = 1;
        condition = "true";
        script = "\overthrow_main\missions\transportvip.sqf";
        chance = 100;
        expires = 12;
        requestable = 1;
    };

    class ReconBase
    {
        target = "Base";
        repeatable = 0;
        condition = "params['_inSpawnDistance', '_name'];!(_name in (server getVariable ['NATOabandoned',[]])) && (server getVariable [format[""garrison%1"",_name],0]) > 0";
        script = "\overthrow_main\missions\reconBase.sqf";
        chance = 20;
        expires = 0;
        requestable = 1;
    };

    class HVT
    {
        target = "HVT";
        repeatable = 1;
        condition = "params['_inSpawnDistance', '_name'];!(_name in (server getVariable ['NATOabandoned',[]])) && _inSpawnDistance";
        script = "\overthrow_main\missions\hvt.sqf";
        chance = 5;
        expires = 0;
        requestable = 0;
    };

    class NATOmission
    {
        target = "NATOmission";
        repeatable = 0;
        condition = "true";
        script = "\overthrow_main\missions\natomissions.sqf";
        chance = 25;
        expires = 0;
        requestable = 0;
    };

    class GangDrugRun
    {
        target = "Gang";
        repeatable = 1;
        condition = "true";
        script = "\overthrow_main\missions\gangdrugrun.sqf";
        chance = 100;
        expires = 6;
        requestable = 1;
    };

    class GangWeaponRun
    {
        target = "Gang";
        repeatable = 1;
        condition = "true";
        script = "\overthrow_main\missions\gangweaponrun.sqf";
        chance = 100;
        expires = 6;
        requestable = 1;
    };

    class ShopDelivery
    {
        target = "Shop";
        repeatable = 1;
        condition = "true";
        script = "\overthrow_main\missions\shopdelivery.sqf";
        chance = 100;
        expires = 6;
        requestable = 1;
    };
};
