params ["_unit"];

"You are unconscious. You can either wait for assistance or respawn through the ESC menu." call OT_fnc_notifyMinor;

[format["%1 has fallen unconscious and is waiting for assistance at GRIDREF: %2",name _unit, mapGridPosition _unit] remoteExec ["systemChat",[0,-2] select isDedicated];
