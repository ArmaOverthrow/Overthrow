_item = _this;

_owner = _item getVariable "owner";

if !(isNil "_owner") then {
	if(_owner != "self") exitWith {true};
};

false