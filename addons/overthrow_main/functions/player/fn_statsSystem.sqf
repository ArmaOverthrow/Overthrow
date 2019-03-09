disableSerialization;

private _layer = ["stats"] call bis_fnc_rscLayer;
_layer cutRsc ["OT_statsHUD","PLAIN",0,false];

[{!isNull (uiNameSpace getVariable "OT_statsHUD")},{
	
	disableSerialization;
	private _display = uiNameSpace getVariable "OT_statsHUD";
	private _setText = _display displayCtrl 1001;
	_setText ctrlSetBackgroundColor [0,0,0,0];
	private _currentTxt = "";

	[OT_fnc_statsSystemLoop,_this,1] call CBA_fnc_waitAndExecute;

},[_this]] call CBA_fnc_waitUntilAndExecute;