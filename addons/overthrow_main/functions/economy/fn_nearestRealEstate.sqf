private ["_buildings","_building","_gotbuilding","_price","_lease","_sell","_totaloccupants"];

private _buildings =  _this nearObjects ["Building",30];
private _gotbuilding = false;
private _building = objNULL;

private _sorted = [_buildings,[_this],{_x distance _input0},"ASCEND"] call BIS_fnc_SortBy;

if(!isNil "modeTarget") then {
	_sorted = _sorted - [modeTarget];
};

{
	if ((typeof _x) in OT_allBuyableBuildings) exitWith {
		_building = _x;
	};
}foreach(_sorted);
_ret = false;
if(_gotbuilding) then {
	_ret = _building call OT_fnc_getRealEstateData;
};
_ret
