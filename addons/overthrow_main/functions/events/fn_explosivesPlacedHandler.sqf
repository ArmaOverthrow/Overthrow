params ["_exp","_dir","_pitch","_unit"];

if !((side _unit == resistance) or (captive _unit)) exitWith {};
if(_unit call OT_fnc_unitSeen) then {
    _unit setCaptive false;
    if((random 100) > 70 and ((typeof _exp) select [0,3] == "IED")) then {
        [[_exp], -3] call ace_explosives_fnc_scriptedExplosive;
    };
};
