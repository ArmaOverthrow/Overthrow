params ["_unit"];
private _ot_cigsStatesArray = [["EWK_Cig1", 0, "EWK_Cig4"], ["EWK_Cig4", 66, "EWK_Cig6"], ["EWK_Cig6", 126, "EWK_Cig3"], ["EWK_Cig3", 306], ["murshun_cigs_cig0", 0, "murshun_cigs_cig1"], ["murshun_cigs_cig1", 12, "murshun_cigs_cig2"], ["murshun_cigs_cig2", 66, "murshun_cigs_cig3"], ["murshun_cigs_cig3", 126, "murshun_cigs_cig4"], ["murshun_cigs_cig4", 306]];

private _hasGanja = false;

{
    if(_x isEqualTo "OT_Ganja") exitWith {_hasGanja = true};
}foreach(items player);
if !(_hasGanja) exitWith {"You don't have enough weed to smoke a spliff" call OT_fnc_notifyMinor};

if(player call OT_fnc_unitSeenNATO) then {
    player setcaptive false;
};
player removeItem "OT_Ganja";
// player addItem "murshun_cigs_cigpack";
// player addItem "murshun_cigs_lighter";

[_unit, "murshun_cigs_lighter_01"] call ot_fnc_playSound;
// _unit addItem "murshun_cigs_cig0";
_unit addGoggles "murshun_cigs_cig0";
if (!(local _unit)) exitWith {};

private _cigTime = 0;
private _goggles = goggles _unit;

if !(_goggles in OT_cigsArray) exitWith {};

private _gogglesCurrent = _goggles;

private _states = _ot_cigsStatesArray select {_x select 0 isEqualTo _goggles};

{
    _x params ["_cigState", "_cigStateTime", ["_cigStateNext", ""]];
    _cigTime = _cigStateTime;
} forEach _states;

if (_unit getVariable ["ot_isSmoking", false]) exitWith {};
_unit setVariable ["ot_isSmoking", true, true];
_unit setVariable ["ot_lastSmoke",time,false];


[_unit] spawn ot_fnc_smokeAnimation;

sleep (3.5 + random 2);
[_unit] remoteExec ["ot_fnc_smokePuffs"];
sleep (1 + random 1);
[_unit] remoteExec ["ot_fnc_smokePuffs"];


while {alive _unit && _gogglesCurrent in OT_cigsArray && (_unit getVariable ["ot_isSmoking", false]) && _cigTime <= 330} do {
    _gogglesCurrent = goggles _unit;
    private _gogglesNew = "";

    _states = _ot_cigsStatesArray select {_x select 0 isEqualTo _gogglesCurrent};

    {
        _x params ["_cigState", "_cigStateTime", ["_cigStateNext", ""]];
        private _statesNew = _ot_cigsStatesArray select {_x select 0 isEqualTo _cigStateNext};

        {
            _x params ["_cigState", "_cigStateTime", ["_cigStateNext", ""]];
            if (_cigTime >= _cigStateTime) then {
                _gogglesNew = _cigState;
            };
        } forEach _statesNew;
    } forEach _states;

    if (_gogglesNew != "") then {
        removeGoggles _unit;
        _unit addGoggles _gogglesNew;
        _gogglesCurrent = _gogglesNew;
    };

    private _time = (5.5 + random 2);

    _cigTime = _cigTime + _time;

    [_unit] remoteExec ["ot_fnc_smokePuffs"];
    _unit setFatigue (getFatigue _unit + 0.01);

    sleep _time;

    if (_gogglesCurrent != goggles _unit) exitWith {};
};

_unit setVariable ["ot_isSmoking", false, true];
if (_cigTime >= 330) then {
    removeGoggles _unit;
};
