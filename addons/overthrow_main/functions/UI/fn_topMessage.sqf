disableSerialization;
/*
=============================================================================================================================
  FILE: fn_topMessage.sqf
  AUTHOR: Asaayu
  DESCRIPTION: Show message that appears form the top of the screen for X minutes and then moves back out of frame.
  CALL: ["<t align='center' font='PuristaBold' size='1.5'>Example Message</t>", 10, true, "click"] spawn OT_fnc_topMessage;
=============================================================================================================================
*/

params [
  ["_text2show","ERROR"],
  ["_time",8],
  ["_playSound",false],
  ["_sound","click"]
];

if !(hasInterface) exitWith {
  diag_log format["'%1' was canceled from running on a client that has no interface",__FILE__];
};

private _display = findDisplay 46;
private _ctrl = _display ctrlCreate ["RscStructuredText",-1];
_ctrl ctrlSetPosition [0 * safezoneW + safezoneX,-1 * safezoneH + safezoneY,1 * safezoneW,0.066 * safezoneH];
_ctrl ctrlSetStructuredText parseText _text2show;
_ctrl ctrlCommit 0;
[_ctrl] call BIS_fnc_CtrlFitToTextHeight;
private _origPos = ctrlPosition _ctrl;

_ctrl ctrlSetPosition [(ctrlPosition _ctrl)#0,(-0.05-(ctrlPosition _ctrl)#3) * safezoneH + safezoneY,(ctrlPosition _ctrl)#2,(ctrlPosition _ctrl)#3];
_ctrl ctrlCommit 0;


_ctrl ctrlSetPosition [0 * safezoneW + safezoneX,0 * safezoneH + safezoneY];
_ctrl ctrlCommit 0.25;

if (_playSound) then {
  playSound [_sound, false];
};

uiSleep (_time );

_ctrl ctrlSetPosition [(ctrlPosition _ctrl)#0,(((ctrlPosition _ctrl)#3) * -1) * safezoneH + safezoneY,(ctrlPosition _ctrl)#2,(ctrlPosition _ctrl)#3];
_ctrl ctrlCommit 0.25;

uiSleep 0.35;

ctrlDelete _ctrl;
