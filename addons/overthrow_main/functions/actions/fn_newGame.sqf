closeDialog 0;
"Generating economy" remoteExec['blackFaded',0,false];
[] execVM "initEconomy.sqf";
waitUntil {!isNil "OT_economyInitDone"};
server setVariable["StartupType","NEW",true];
