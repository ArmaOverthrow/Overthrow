if !(captive player) exitWith {"You cannot recruit while wanted" call OT_fnc_notifyMinor};

if(({side _x isEqualTo west || side _x isEqualTo east} count ((getpos player) nearEntities 50)) > 0) exitWith {
	"You cannot recruit with enemies nearby" call OT_fnc_notifyMinor;
};

private _price = [OT_nation,"CIV",100] call OT_fnc_getPrice;
private _money = player getVariable ["money",0];

if(_money < _price) exitWith {format ["You need $%1",_price] call OT_fnc_notifyMinor};
playSound "3DEN_notificationDefault";
[-_price] call OT_fnc_money;

private _pos = [[[getPos player,30]]] call BIS_fnc_randomPos;
private _civ = (group player) createUnit [OT_civType_local, _pos, [],0, "NONE"];
_civ setBehaviour "SAFE";
[_civ,call OT_fnc_randomLocalIdentity] call OT_fnc_applyIdentity;

removeAllWeapons _civ;
removeAllAssignedItems _civ;
removeGoggles _civ;
removeBackpack _civ;
removeHeadgear _civ;
removeVest _civ;
_civ setSkill 0.2 + (random 0.3);

[_civ,getPlayerUID player] call OT_fnc_setOwner;
[_civ] call OT_fnc_initRecruit;
_civ setRank "PRIVATE";
