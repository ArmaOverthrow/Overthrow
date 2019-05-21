params ["_soldier","_pos","_group",["_takeFromWarehouse",true]];
_soldier params ["_cost","_cls","_loadout","_clothes","_allitems"];
if(_cls == "Police") then {_cls = OT_Unit_Police};
//Take from warehouse
if(_takeFromWarehouse) then {
	{
		_x params ["_cls","_num"];
		[_cls,_num] call OT_fnc_removeFromWarehouse;
	}foreach(_allitems call BIS_fnc_consolidateArray);
};

private _start = [[[_pos,30]]] call BIS_fnc_randomPos;
private _civ = _group createUnit [_cls, _start, [],0, "NONE"];

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_civ,_fullname] remoteExec ["setCivName",0,false];
_civ setRank "LIEUTENANT";

[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];

if(_clothes != "") then {
	_civ forceAddUniform _clothes;
}else{
	_clothes = (OT_clothes_guerilla call BIS_fnc_selectRandom);
	_civ forceAddUniform _clothes;
};

_civ setskill ["courage",1];

removeAllWeapons _civ;
removeAllAssignedItems _civ;
removeGoggles _civ;
removeBackpack _civ;
removeHeadgear _civ;
removeVest _civ;

_civ setUnitLoadout [_loadout, false];

_civ
