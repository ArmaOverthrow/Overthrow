private ["_CraterList"];

_CraterList = position _this nearObjects ["#crater",100];

//Check if an enemy is close to the AI or not.
_Enemy = _this call VCOMAI_ClosestEnemy;
if (isNil "_Enemy") then {_Enemy = [0,0,0]};

if (_Enemy distance _this > 1000) then {_CraterList = [];};

_CraterList