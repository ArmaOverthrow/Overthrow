OT_hasTFAR = false;
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    OT_hasTFAR = true;
    tf_radio_channel_name = "TaskForceRadio";
    if(hasInterface) then {
      ["init_TFAR","_counter%3 isEqualTo 0", "
        call TFAR_fnc_sendVersionInfo;
        ""task_force_radio_pipe"" callExtension ""dummy~"";
        sleep 3;
      "] call OT_fnc_addActionLoop;
    };
};
