createDialog "OT_dialog_input";

[
	{
		disableSerialization;
		params ["_text","_default"];
		private _ctrl = (findDisplay 8001) displayCtrl 1100;
		_ctrl ctrlSetStructuredText parseText _text;
		ctrlSetText [1400,format["%1",_default]];
	},
	_this
] call CBA_fnc_waitAndExecute;
