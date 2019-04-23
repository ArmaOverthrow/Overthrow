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

private _owner = _this call OT_fnc_getOwner;
if (!isNil "_owner" && { _owner isEqualType "" } && {_owner != "self"}) exitWith {
	true
};
false
