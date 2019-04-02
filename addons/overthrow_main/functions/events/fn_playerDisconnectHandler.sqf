params ["_id", "_uid", "_name", "_jip", "_owner"];

private _highCommandModule = missionNameSpace getVariable [format["%1_hc_module",_uid],objNull];

deleteVehicle _highCommandModule;
missionNameSpace setVariable [format["%1_hc_module",_uid],objNull,true];
