_Unit = _this;
if (isPlayer _Unit) exitWith {};

while {alive _Unit && VCOM_UseMarkers} do 
{
	sleep 0.15;
	MarkerNames = random 1000;
	_marker1Names = format["marker_%1",MarkerNames];
	_marker1 = createMarker [_marker1Names,(getPosASL _Unit)];
	_marker1 setmarkershape "ELLIPSE";
	if ((side _Unit) isEqualTo EAST) then {_marker1 setmarkercolor "ColorRed";};
	if ((side _Unit) isEqualTo WEST) then {_marker1 setmarkercolor "ColorBlue";};
	_marker1 setmarkersize [1,1];
	MarkerArray pushback _marker1;
};
MarkerNames = random 1000;
_marker1Names = format["marker_%1",MarkerNames];
_marker1 = createMarker [_marker1Names,(getPosASL _Unit)];
_marker1 setmarkershape "ELLIPSE";
if ((side _Unit) isEqualTo EAST) then {_marker1 setmarkercolor "ColorOrange";};
if ((side _Unit) isEqualTo WEST) then {_marker1 setmarkercolor "ColorOrange";};
_marker1 setmarkersize [2,2];
MarkerArray pushback _marker1;

_marker1zzNames = format["markezzzzr_%1",MarkerNames];
_markerName = createmarker [_marker1zzNames,(getposASL _Unit)];
_markerName setMarkerType "hd_dot";
_markerName setMarkerText "DEAD";
_markerName setMarkerColor "ColorBlack";
_markerName setMarkerSize [0.5,0.5];
MarkerArray pushback _markerName;
