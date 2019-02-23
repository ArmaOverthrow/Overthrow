private _owner = (_this call OT_fnc_getOwner);
if(isNil "_owner") exitWith {false};
_owner isEqualTo (getplayeruid player)
