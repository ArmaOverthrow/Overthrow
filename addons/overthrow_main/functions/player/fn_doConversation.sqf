params ["_personOne","_personTwo","_lines",["_onFinish",{}],["_params",[]]];

_personOne setRandomLip false;
_personTwo setRandomLip false;
if (_lines isEqualTo []) exitWith {
	_params call _onFinish;
};

private _line = _lines deleteAt 0;
_personOne setRandomLip true;
_personOne globalChat _line;
private _wait = (ceil ((count _line) * 0.1)+1) min 5;

_this set [0,_personTwo];
_this set [1,_personOne];

[
	OT_fnc_doConversation,
	_this,
	_wait
] call CBA_fnc_waitAndExecute;
