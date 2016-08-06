_item = _this;

_owner = _item getVariable "owner";

if !(isNil "_owner") then {
	if(typename _owner == "OBJECT") exitWith {true};
};

false