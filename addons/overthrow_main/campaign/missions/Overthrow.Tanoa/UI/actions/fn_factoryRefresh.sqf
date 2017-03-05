disableSerialization;

private _currentCls = server getVariable ["GEURproducing",""];

private _text = "";
private _currentPic = "";

if(_currentCls != "") then {
	private _currentName = "";
	if(_currentCls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_currentName = _currentCls call ISSE_Cfg_Weapons_GetName;
		_currentPic = _currentCls call ISSE_Cfg_Weapons_GetPic;
	};
	if(_currentCls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
		_currentName = _currentCls call ISSE_Cfg_Magazine_GetName;
		_currentPic = _currentCls call ISSE_Cfg_Magazine_GetPic;
	};
	if(_currentCls isKindOf "Bag_Base") then {
		_currentName = _currentCls call ISSE_Cfg_Vehicle_GetName;
		_currentPic = _currentCls call ISSE_Cfg_Vehicle_GetPic;
	};
	_text = format["<t size='0.65' align='center'>%1</t><br/>",_currentName];

	_cost = cost getVariable[_currentCls,[]];
	if(count _cost > 0) then {

	};
};

ctrlSetText [1200,_currentPic];

private _textctrl = (findDisplay 8000) displayCtrl 1102;
_textctrl ctrlSetStructuredText parseText _text;
