_item = _this;

_owner = _item getVariable "owner";
_r = false;
if !(isNil "_owner") then {
	if((typename _owner) == "OBJECT") then {_r = true};
};

_r