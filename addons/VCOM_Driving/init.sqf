//Compile important functions for this script.
VCOM_DRIVE_DEBUG = 0;
VCOM_fnc_VehicleDetection = compile preprocessFile "addons\VCOM_Driving\Functions\VCOM_fnc_VehicleDetection.sqf";
VCOM_fnc_IsDriver = compile preprocessFile "addons\VCOM_Driving\Functions\VCOM_fnc_IsDriver.sqf";

[] spawn 
{
  if (!(isDedicated)) then 
  {
    waitUntil {!isNil "BIS_fnc_init"};
    waitUntil {!(isnull (findDisplay 46))};
  };
  
  while {true} do 
  {
    
    sleep 0.25;
    {
      if (local _x) then 
      {
      _CheckVariable = _x getVariable "VCOM_FSMRunning";
      if (isNil ("_CheckVariable")) then {_CheckVariable = 0;};
      if (!(isplayer _x) && (_CheckVariable isEqualTo 0)) then {null = [_x] execFSM "addons\VCOM_Driving\Functions\AIDRIVEBEHAVIOR.fsm";};
      };
    } forEach allUnits;
    sleep 5;
  };
};