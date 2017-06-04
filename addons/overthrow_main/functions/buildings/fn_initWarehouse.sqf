private ["_pos","_shop"];

_pos = _this select 0;
_shop = (_pos nearObjects [OT_warehouse,10]) select 0;

_mrkid = format["%1-whouse",_pos];
createMarker [_mrkid,_pos];
_mrkid setMarkerShape "ICON";
_mrkid setMarkerType "ot_Warehouse";
_mrkid setMarkerColor "ColorWhite";
_mrkid setMarkerAlpha 1;

