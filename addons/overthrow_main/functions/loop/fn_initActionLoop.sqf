
/*
=============================================================================================================================
  FILE: fn_initActionLoop.sqf
  AUTHOR: Asaayu
  DESCRIPTION: Start the action loop for this machine. Needs to be run on both the client & server.
  CALL: [] call OT_fnc_initActionLoop;
=============================================================================================================================
*/

if !(isNil "action_loop") exitWith {};

action_loop = [];
[] spawn {
  private _counter = 0;
  for "_i" from 0 to 1 step 0 do {
    {
      _x params ["_id",["_condition",{false}],["_code",{}]];
        if (_id isEqualTo "OT_autosave_loop") then {
          if (!(OT_autoSave_time isEqualTo 0) && (OT_autoSave_last_time - time) <= 0) then {
            ["<t align='center' font='PuristaBold' size='1.3'>MISSION WILL AUTOSAVE IN 60 SECONDS...</t>", 10, true, "click"] spawn OT_fnc_topMessage;
            [] spawn {
              OT_autoSave_last_time = (time + (OT_autoSave_time*60)) + 60;
              sleep 60;
              if !(OT_autoSave_time isEqualTo 0) then {
                [objNull,false,true] remoteExec ['OT_fnc_saveGame',2,false];
              };
            };
          };
        }else{
          if (call _condition) then {
            call _code;
          };
        };
    } forEach action_loop;

    uiSleep 0.5;
    _counter = _counter + 0.5;
    if (_counter >= 10) then {
      _counter = 0;
    };
  };
};
