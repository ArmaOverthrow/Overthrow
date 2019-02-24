params ["","_key"];
private _name = ctrltext 1400;
if(_key == 28 and _name != "") exitWith {
	[] call OT_fnc_onNameDone;
	true
};