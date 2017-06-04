disableSerialization;

private _currentCls = server getVariable ["GEURproducing",""];

private _text = "";
private _currentPic = "";

if(_currentCls != "") then {
	private _currentName = "";
	if(_currentCls isKindOf "AllVehicles") then {
		_currentName = _currentCls call OT_fnc_vehicleGetName;
		_currentPic = _currentCls call OT_fnc_vehicleGetPic;
	};
	if(_currentCls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_currentName = _currentCls call OT_fnc_weaponGetName;
		_currentPic = _currentCls call OT_fnc_weaponGetPic;
	};
	if(_currentCls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
		_currentName = _currentCls call OT_fnc_magazineGetName;
		_currentPic = _currentCls call OT_fnc_magazineGetPic;
	};
	if(_currentCls isKindOf "Bag_Base") then {
		_currentName = _currentCls call OT_fnc_vehicleGetName;
		_currentPic = _currentCls call OT_fnc_vehicleGetPic;
	};


	_cost = cost getVariable[_currentCls,[]];
	if(count _cost > 0) then {
		_cost params ["_base","_wood","_steel","_plastic"];
		if(isNil "_plastic") then {
			_plastic = 0;
		};
		_b = _base;
		if(_base > 240) then {
			_b = 30;
		};
		if(_base > 10000) then {
			_b = 60;
		};
		if(_base > 20000) then {
			_b = 120;
		};
		if(_base > 50000) then {
			_b = 240;
		};
		_timetoproduce = _b + (round (_wood+1)) + (round (_steel * 2)) + (round (_plastic * 5));
		if(_timetoproduce > 360) then {_timetoproduce = 360};
		if(_timetoproduce < 5) then {_timetoproduce = 5};

		_timespent = server getVariable ["GEURproducetime",0];

		_numtoproduce = 1;
		if(_wood < 1 and _wood > 0) then {
			_numtoproduce = round (1 / _wood);
			_wood = 1;
		};
		if(_steel < 1 and _steel > 0) then {
			_numtoproduce = round (1 / _steel);
			_steel = 1;
		};
		if(_plastic < 1 and _plastic > 0) then {
			_numtoproduce = round (1 / _plastic);
			_plastic = 1;
		};
		_text = format["<t size='0.65' align='center'>Input: $%1 + ",round((_base * _numtoproduce) * 0.8)];
		if(_wood > 0) then {
			_text = _text + format["%1 x wood ",_wood];
		};
		if(_steel > 0) then {
			_text = _text + format["%1 x steel ",_steel];
		};
		if(_plastic > 0) then {
			_text = _text + format["%1 x plastic",_plastic];
		};
		_text = _text + "<br/>";
		_text = _text + format["Time: %1 of %2 mins<br/>",_timespent,_timetoproduce];
		_text = _text + format["Output: %1 x %2<br/></t>",_numtoproduce,_currentName];
	};
};

ctrlSetText [1200,_currentPic];

private _textctrl = (findDisplay 8000) displayCtrl 1102;
_textctrl ctrlSetStructuredText parseText _text;
