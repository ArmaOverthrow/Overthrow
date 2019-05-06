disableSerialization;

private _currentCls = server getVariable ["GEURproducing",""];

private _text = "<t size='0.8' align='center'>Factory is not currently produce anything. Add to the queue above or Reverse-Engineer nearby items to gain blueprints.</t><br/>";
private _currentPic = "";
private _currentName = "";

if(_currentCls != "") then {
	_text = format["<t size='0.8' align='center'>Currently Producing</t><br/><t size='1.1' align='center'>%1</t><br/><br/>",_currentCls call OT_fnc_anythingGetName];
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

	private _cost = cost getVariable[_currentCls,[]];
	if(count _cost > 0) then {
		_cost params ["_base","_wood","_steel",["_plastic",0]];
		private _b = 1;
		if(_base > 240) then {
	        _b = 10;
	    };
	    if(_base > 10000) then {
	        _b = 20;
	    };
	    if(_base > 20000) then {
	        _b = 30;
	    };
	    if(_base > 50000) then {
	        _b = 60;
	    };
	    private _timetoproduce = _b + (round (_wood+1)) + (round(_steel * 0.2)) + (round (_plastic * 5));
		if(_timetoproduce > 360) then {_timetoproduce = 360};
		if(_timetoproduce < 5) then {_timetoproduce = 5};

		private _timespent = server getVariable ["GEURproducetime",0];

		private _numtoproduce = 1;
		if(_wood < 1 && _wood > 0) then {
			_numtoproduce = round (1 / _wood);
			_wood = 1;
		};
		if(_steel < 1 && _steel > 0) then {
			_numtoproduce = round (1 / _steel);
			_steel = 1;
		};
		if(_plastic < 1 && _plastic > 0) then {
			_numtoproduce = round (1 / _plastic);
			_plastic = 1;
		};
		_text = _text + format["<t size='0.65' align='center'>Input: $%1 + ",round((_base * _numtoproduce) * 0.8)];
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

private _textctrl = (findDisplay 8000) displayCtrl 1103;
_textctrl ctrlSetStructuredText parseText _text;
lbClear 1501;
{
	_x params ["_cls","_qty"];
	_idx = lbAdd [1501,format["%1 x %2",_qty,_cls call OT_fnc_anythingGetName]];
	lbSetData [1501,_idx,_cls];
}foreach(server getVariable ["factoryQueue",[]]);

private _index = lbCurSel 1500;
private _cls = lbData [1500,_index];

private _pic = "";
private _txt = "";
private _desc = "";

[_cls] call {
	params["_cls"];
	if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
		_txt = _cls call OT_fnc_magazineGetName;
		_pic = _cls call OT_fnc_magazineGetPic;
		_desc = _cls call OT_fnc_magazineGetDescription;
	};
	if(_cls isKindOf "All") exitWith {
		_txt = _cls call OT_fnc_vehicleGetName;
		_pic = getText(configFile >> "cfgVehicles" >> _cls >> "editorPreview");
		_desc = getText(configFile >> "cfgVehicles" >> _cls >> "Library" >> "libTextDesc");
	};
	if(isClass (configFile >> "CfgGlasses" >> _cls)) exitWith {
		_txt = gettext(configFile >> "CfgGlasses" >> _cls >> "displayName");
		_pic = gettext(configFile >> "CfgGlasses" >> _cls >> "picture");
	};
	if(_cls isKindOf "Bag_Base") exitWith {
		_txt = _cls call OT_fnc_vehicleGetName;
		_pic = _cls call OT_fnc_vehicleGetPic;
		_desc = _cls call OT_fnc_vehicleGetDescription;
	};
	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) exitWith {
		_txt = _cls call OT_fnc_weaponGetName;
		_pic = _cls call OT_fnc_weaponGetPic;
		_desc = format["%1<br/>%2",getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort"),_cls call OT_fnc_magazineGetDescription];
	};
};

if !(_pic isEqualTo "") then {
	ctrlSetText [1200,_pic];
};

private _cost = cost getVariable[_cls,[]];
private _recipe = "";
if(count _cost > 0) then {
    _cost params ["_base","_wood","_steel",["_plastic",0]];
    private _b = 1;
    if(_base > 240) then {
        _b = 10;
    };
    if(_base > 10000) then {
        _b = 20;
    };
    if(_base > 20000) then {
        _b = 30;
    };
    if(_base > 50000) then {
        _b = 60;
    };
    private _timetoproduce = _b + (round (_wood+1)) + (round(_steel * 0.2)) + (round (_plastic * 5));
    if(_timetoproduce > 360) then {_timetoproduce = 360};
    if(_timetoproduce < 5) then {_timetoproduce = 5};

    private _numtoproduce = 1;
    if(_wood < 1 && _wood > 0) then {
        _numtoproduce = round (1 / _wood);
        _wood = 1;
    };
    if(_steel < 1 && _steel > 0) then {
        _numtoproduce = round (1 / _steel);
        _steel = 1;
    };
    if(_plastic < 1 && _plastic > 0) then {
        _numtoproduce = round (1 / _plastic);
        _plastic = 1;
    };
    _recipe = format["<t size='0.65' align='center'>Input: $%1 + ",round((_base * _numtoproduce) * 0.6)];
    if(_wood > 0) then {
        _recipe = _recipe + format["%1 x wood ",_wood];
    };
    if(_steel > 0) then {
        _recipe = _recipe + format["%1 x steel ",_steel];
    };
    if(_plastic > 0) then {
        _recipe = _recipe + format["%1 x plastic",_plastic];
    };
    _recipe = _recipe + "<br/>";
    _recipe = _recipe + format["Time: %1 mins<br/>",_timetoproduce];
    _recipe = _recipe + format["Output: %1 x %2<br/></t>",_numtoproduce,_cls call OT_fnc_anythingGetName];
};

((findDisplay 8000) displayCtrl 1100) ctrlSetStructuredText parseText format["
	<t align='center' size='0.9'>%1</t><br/>
	%3
",_txt,_desc,_recipe];
