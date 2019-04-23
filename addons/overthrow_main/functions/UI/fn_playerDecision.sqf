closedialog 0;
openMap false;
createDialog "OT_dialog_choose";

if((_this select 0) isEqualType "") then {
	disableSerialization;
	private _ctrl = (findDisplay 8002) displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText (_this select 0);
	_this deleteAt 0;
}else{
	ctrlShow [1100,false];
};

OT_choices = _this;

private _idc = 1600;
{
	private _text = _x select 0;
	ctrlSetText [_idc,_text];

	_idc = _idc + 1;
	if(_idc > 1605) exitWith {};
}foreach(OT_choices);

if(_idc < 1606) then {
	while{_idc < 1606} do {
		ctrlShow [_idc,false];
		_idc = _idc + 1;
	};
};
