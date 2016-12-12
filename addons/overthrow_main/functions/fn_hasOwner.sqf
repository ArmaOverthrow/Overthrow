/* ----------------------------------------------------------------------------
Function: OT_fnc_hasOwner
Description:
    Returns if an object is owned
Parameters:
    _item   - Object <OBJECT>
Returns:
    _ret 	- Is owned <BOOL>
Author:
    ARMAzac
-----------------------------------------------------------------------------*/

private _item = _this;

private _owner = _item getVariable "owner";
private _ret = false;
if !(isNil "_owner") then {
	if(typename _owner == "STRING") then {
		if(_owner != "self") then {
			_ret = true;
		};
	};
};

_ret;
