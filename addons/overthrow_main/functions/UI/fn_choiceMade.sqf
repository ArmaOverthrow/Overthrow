private _choice = OT_choices select _this;
_choice params ["_text","_code","_args"];
if (isNil "_args") then { _args = [_text]; };

[_code,_args] call CBA_fnc_waitAndExecute;
