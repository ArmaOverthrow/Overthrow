_buildings =  _this nearObjects ["Building",30];
_gotbuilding = false;
_building = objNULL;
_sorted = [_buildings,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
{
	if ((typeof _x) in OT_allBuyableBuildings and _x call hasOwner) then {
		_owner = _x getVariable "owner";
		if(_owner == getplayeruid player) then {
			_gotbuilding = true;
			_building = _x;
		};
	};
	if(_gotbuilding) exitWith{};
}foreach(_sorted);
_ret = false;
if(_gotbuilding) then {
	_ret = _building;
};
_ret