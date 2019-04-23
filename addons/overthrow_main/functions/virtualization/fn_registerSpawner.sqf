private ["_pos","_code","_params","_start","_end","_id"];
_pos = _this select 0;
_code = _this select 1;
_params = [];

if(count _this > 2) then {
    _params = _this select 2;
};
_start = [];
_end = [];
if((count _pos) isEqualTo 2) then {
    _start = _pos select 0;
    _end = _pos select 1;
}else{
    _start = _pos;
    _end = _pos;
};

OT_spawnUniqueCounter = OT_spawnUniqueCounter + 1;

_id = format["spawn%1",OT_spawnUniqueCounter];


if(OT_deepDebug) then {
    diag_log format ["Overthrow: Registered %1 @ %2 %3",_id,_start,_params];
};

OT_allspawners pushBack [_id,_start,_end,_code,_params,0];

OT_spawnUniqueCounter
