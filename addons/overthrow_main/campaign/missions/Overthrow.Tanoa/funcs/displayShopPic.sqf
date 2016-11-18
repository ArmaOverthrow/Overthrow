params ["_ctrl","_index"];

disableSerialization;

_cls = _ctrl lbData _index;
_price = [_ctrl lbValue _index, 1, 0, true] call CBA_fnc_formatNumber; 
 
_pic = "";
_txt = "";
_desc = "";

call {
	if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) then {
		_txt = _cls call ISSE_Cfg_Magazine_GetName;
		_pic = _cls call ISSE_Cfg_Magazine_GetPic;
		_desc = _cls call ISSE_Cfg_Magazine_GetDesc;	
	};
	if(isClass (configFile >> "CfgGlasses" >> _cls)) exitWith {
		_txt = gettext(configFile >> "CfgGlasses" >> _cls >> "displayName");
		_pic = gettext(configFile >> "CfgGlasses" >> _cls >> "picture");		
	};
	if(_cls in (OT_allVehicles + OT_allBoats)) exitWith {
		_txt = _cls call ISSE_Cfg_Vehicle_GetName;
		_pic = getText(configFile >> "cfgVehicles" >> _cls >> "editorPreview");
		_desc = getText(configFile >> "cfgVehicles" >> _cls >> "Library" >> "libTextDesc");
	};
	if(_cls isKindOf "Bag_Base") exitWith {
		_txt = _cls call ISSE_Cfg_Vehicle_GetName;
		_pic = _cls call ISSE_Cfg_Vehicle_GetPic;
		_desc = _cls call ISSE_Cfg_Vehicle_GetDesc;
	};
	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
		_txt = _cls call ISSE_Cfg_Weapons_GetName;
		_pic = _cls call ISSE_Cfg_Weapons_GetPic;
		_desc = format["%1<br/>%2",getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort"),_cls call ISSE_Cfg_Magazine_GetDesc];
	};

	if(_cls isKindOf "Man") exitWith {
		_txt = _cls call ISSE_Cfg_Vehicle_GetName;
		_price = format["%1 + gear",_price];
		_desc = "Will recruit this soldier into your group fully equipped using the warehouse where possible.";
	};
	if(_cls in OT_allSquads) exitWith {	
		_txt = _cls;
		_price = format["%1 + gear",_price];
		_desc = "Will recruit this squad into your High-Command bar, accessible with ctrl-space.";
	};
};
if !(isNil "_pic") then {
	ctrlSetText [1200,_pic];
};

_textctrl = (findDisplay 8000) displayCtrl 1100;

_textctrl ctrlSetStructuredText parseText format["
	<t align='center' size='1.5'>%1</t><br/>
	<t align='center' size='1.2'>$%3</t><br/><br/>
	<t align='center' size='0.8'>%2</t>	
",_txt,_desc,_price];
