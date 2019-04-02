
switch (OT_autoSave_time) do {
  case 0: {OT_autoSave_time = 5};
  case 5: {OT_autoSave_time = 10};
  case 10: {OT_autoSave_time = 15};
  case 15: {OT_autoSave_time = 30};
  case 30: {OT_autoSave_time = 45};
  case 45: {OT_autoSave_time = 60};
  case 60: {OT_autoSave_time = 0};
};

[parseText format["<t font='PuristaBold' size='1.15'>AUTOSAVE TIME:<br/>%1 Minutes</t>",OT_autoSave_time]] remoteExec ["hint",[0,-2] select isDedicated];
