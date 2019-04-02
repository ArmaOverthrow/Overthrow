
/*
=============================================================================================================================
  FILE: fn_addActionLoop.sqf
  AUTHOR: Asaayu
  DESCRIPTION: Add an item to the ActionLoop either on the player or on the server.
  CALL: ["unique_ID","speed player > 5", "hint 'Your speeding!'"] call OT_fnc_addActionLoop;
=============================================================================================================================
*/

params [["_id",str (round random 156852)],["_condition","false"],["_code",""]];

if (isNil "action_loop") then {
  [] call OT_fnc_initActionLoop;
};

private _check = false;
{
  _x params ["_idLoop"];
  if (_idLoop isEqualTo _id) then {
    action_loop set [_forEachIndex,[_idLoop,compile _condition,compile _code]];
    _check = true;
  };
} forEach action_loop;

if !(_check) then {
  action_loop append [
    [
    _id,
    compile _condition,
    compile _code
    ]
  ];
};
