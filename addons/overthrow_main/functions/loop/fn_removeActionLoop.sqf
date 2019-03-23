
/*
=============================================================================================================================
  FILE: fn_removeActionLoop.sqf
  AUTHOR: Asaayu
  DESCRIPTION: Removes item from action loop with the corresponding ID.
  CALL: ["unique_ID"] spawn OT_fnc_removeActionLoop;
=============================================================================================================================
*/

params ["_id"];

if (isNil "action_loop") exitWith {};

{
  _x params ["_idLoop",["_condition",{false}],["_code",{}]];
  if (_idLoop isEqualTo _id) then {
    action_loop deleteAt _forEachIndex;
  };
} forEach action_loop;
