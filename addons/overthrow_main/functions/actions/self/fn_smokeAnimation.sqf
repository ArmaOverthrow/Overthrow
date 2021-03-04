params ["_unit"];

if (!alive _unit || vehicle _unit != _unit) exitWith {};

if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

private _animation = animationState _unit;

if (stance _unit isEqualTo "STAND" && isClass (configFile >> "CfgPatches" >> "ewk_cigs")) then {
    [_unit, "EWK_CIGS_SMOKING_ERC_CTS"] remoteExec ["switchMove"];

    private _time = time;
    while {time < _time + 3} do {
        if (!alive _unit) exitWith {
            [_unit, ""] remoteExec ["switchMove"];
        };
        sleep (1/60);
    };
} else {
    private _time = time;
    while {time < _time + 3} do {
        _unit playActionNow "Gear";
        sleep (1/60);
    };
};

if (alive _unit && !(_unit getVariable ["ACE_isUnconscious", false])) then {
    [_unit, _animation] remoteExec ["switchMove"];
};
