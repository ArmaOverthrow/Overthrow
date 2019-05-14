
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
            ["<t align='center' font='PuristaBold' size='1.25'>MISSION WILL AUTOSAVE IN 60 SECONDS...</t>", 10, true, "click"] remoteExec ["OT_fnc_topMessage",[0,-2] select isDedicated,false];
            diag_log "== OVERTHROW == Autosaving mission in 60 seconds.";
            [] spawn {
              OT_autoSave_last_time = (time + (OT_autoSave_time*60)) + 60;
              uiSleep 55;
              "Autosaving Mission..." remoteExec ["systemChat",[0,-2] select isDedicated,false];
              diag_log "== OVERTHROW == Autosaving mission.";
              if !(OT_autoSave_time isEqualTo 0) then {
                [objNull,true,true] remoteExec ['OT_fnc_saveGame',2,false];
              };
            };
          };
        }else{
          if (call _condition) then {
            //private _start = time;
            call _code;
            //systemChat format["looping %1 took %2 secs",_id,time - _start];
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
