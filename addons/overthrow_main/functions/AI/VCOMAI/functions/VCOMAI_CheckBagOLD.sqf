private ["_Unit", "_CurrentBackPack", "_class", "_parents", "_IsUAV","_VCOM_HASSTATIC","_VCOM_HASUAV","_StaticClassName"];
_Unit = _this;

_CurrentBackPack = backpack _Unit;

if (isNil "_CurrentBackPack") exitWith {};
_class = [_CurrentBackPack] call VCOMAI_Classvehicle;

_VCOM_HASUAV = false;
_VCOM_HASSTATIC = false;
_StaticClassName = "";

if (isNil "_class") exitWith {_ReturnVariable = [_VCOM_HASSTATIC,_VCOM_HASUAV,_StaticClassName];_ReturnVariable};

_parents = [_class,true] call BIS_fnc_returnParents;
if (("StaticWeapon" in _parents) || {("Weapon_Bag_Base" in _parents)}) then 
{
	_VCOM_HASSTATIC = true;
	_Unit setVariable ["VCOM_StaticClassName",_CurrentBackPack,false];
	_StaticClassName = _CurrentBackPack;
	_IsUAV = ["UAV",_CurrentBackPack,false] call BIS_fnc_inString;
	if (_IsUAV) then {_VCOM_HASUAV = true;};
} 
else 
{
	_VCOM_HASSTATIC = false;
};


_ReturnVariable = [_VCOM_HASSTATIC,_VCOM_HASUAV,_StaticClassName];

_ReturnVariable