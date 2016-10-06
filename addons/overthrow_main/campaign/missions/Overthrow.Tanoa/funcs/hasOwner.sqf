_item = _this;

_owner = _item getVariable "owner";
_ret = false;
if !(isNil "_owner") then {
	if(typename _owner == "STRING") then {
		if(_owner != "self" and _owner != "system") then {
			_ret = true;
		};
	};
};

_ret;
