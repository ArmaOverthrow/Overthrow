params ["_medic","_unit"];

_unit setVariable ["OT_healed",true,true];

_medic doMove (position _unit);

waitUntil {!(alive _medic) or (_medic distance _unit < 5)};

if(!alive _medic) exitWith {_unit setVariable ["OT_healed",false,true]};

_medic action ["HealSoldier", _unit];
[_medic,"AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["playMove",_medic,false];
sleep 5;

_medic removeItem "ACE_epinephrine";

_unit setVariable ["ACE_isUnconscious", false];
_unit setVariable ["OT_healed",false,true];
