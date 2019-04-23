if (profileNamespace getVariable ["OT_autoload",false]) then {
  profileNamespace setVariable ["OT_autoload",false];
  [parseText format["<t font='PuristaBold' size='1.15'>AUTOLOAD:<br/>DISABLED</t>",OT_autoSave_time]] remoteExec ["hint",[0,-2] select isDedicated];
}else{
  profileNamespace setVariable ["OT_autoload",true];
  [parseText format["<t font='PuristaBold' size='1.15'>AUTOLOAD:<br/>ENABLED</t>",OT_autoSave_time]] remoteExec ["hint",[0,-2] select isDedicated];
};
saveProfileNamespace;
