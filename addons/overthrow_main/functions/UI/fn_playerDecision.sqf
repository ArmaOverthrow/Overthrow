closedialog 0;
createDialog "OT_dialog_choose";
openMap false;

if(typename (_this select 0) == "STRING") then {
	disableSerialization;
	_ctrl = (findDisplay 8002) displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText (_this select 0);
	_this deleteAt 0;
}else{
	ctrlShow [1100,false];
};

OT_choices = _this;
_idc = 1600;

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

OT_choiceMade = {
	_choice = OT_choices select _this;
	_text = _choice select 0;
	_code = _choice select 1;
	if(count _choice > 2) then {
		(_choice select 2) spawn _code;
	}else{
		[_text] spawn _code;
	};
};
