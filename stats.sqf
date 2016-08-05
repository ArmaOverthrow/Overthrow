private ["_txt","_currentTxt","_display","_setText"];
showStatistics = false;
sleep 3;
showStatistics = true;
disableSerialization;
//1 cutRsc ["H8erHUD","PLAIN",0,false];
_layer = ["stats"] call bis_fnc_rscLayer;
_layer cutRsc ["AIT_statsHUD","PLAIN",0,false];
waitUntil {!isNull (uiNameSpace getVariable "AIT_statsHUD")};

_display = uiNameSpace getVariable "AIT_statsHUD";
_setText = _display displayCtrl 1001;
_setText ctrlSetBackgroundColor [0,0,0,0];

_currentTxt = "";

while {showStatistics} do {
	_wanted = "";
	if !(captive player) then {
		_hiding = player getVariable "hiding";
		if(_hiding > 0) then {
			_wanted = format["<br/>WANTED (%1)",_hiding];
		}else{
			_wanted = "<br/>WANTED";
		};
		
	};
	_txt = format ["<t size='0.6'>$%1 %2</t>", [player getVariable "money", 1, 0, true] call CBA_fnc_formatNumber,_wanted];
	if (_txt != _currentTxt) then {			
		_setText ctrlSetStructuredText (parseText format ["%1", _txt]);
		_setText ctrlCommit 0;
		_currentTxt = _txt;
	};
	sleep 0.5;
};
