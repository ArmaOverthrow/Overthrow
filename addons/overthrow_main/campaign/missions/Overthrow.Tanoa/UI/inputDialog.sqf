private _text = _this select 0;
private _default = _this select 1;

createDialog "OT_dialog_input";
uiSleep 0.01;
disableSerialization;

private _ctrl = (findDisplay 8001) displayCtrl 1100;

_ctrl ctrlSetStructuredText parseText _text;
ctrlSetText [1400,format["%1",_default]];