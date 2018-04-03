//This function aims to set a variable upon the AI of what static weapon they may have upon their backs.
//Last edit on: 8/7/2017 @ 1902
//Work Done: Optimized the function and added in dynamic support
private _CurrentBackPack = backpack _this;

if (isNil "_CurrentBackPack") exitWith {};
_class = [_CurrentBackPack] call VCOMAI_Classvehicle;
if (isNil "_class") exitWith {_ReturnVariable = [false,false,""];_ReturnVariable};

private _VCOM_HASSTATIC = false;

private _parents = [_class,true] call BIS_fnc_returnParents;
if (("StaticWeapon" in _parents) || {("Weapon_Bag_Base" in _parents)}) then 
{
	_VCOM_HASSTATIC = true;
	if !(_this getVariable ["VCOM_StaticClassName",""] isEqualTo _CurrentBackpack) then
	{
		_this setVariable ["VCOM_StaticClassName",_CurrentBackPack,false];
		if (["UAV",_CurrentBackPack,false] call BIS_fnc_inString) then {_this setVariable ["VCOM_UAV",true,false];};
	};
};


_ReturnVariable = [_VCOM_HASSTATIC,_this getVariable ["VCOM_UAV",false],_CurrentBackPack];

_ReturnVariable