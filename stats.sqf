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
	_wanted = "<br/>";
	if !(captive player) then {
		_hiding = player getVariable "hiding";
		if((_hiding > 0) and (_hiding < 30)) then {
			_wanted = format["(%1) WANTED",_hiding];
		}else{
			_wanted = "WANTED";
		};		
	};
	_knows = (blufor knowsabout player);
	_seen = "";
	if(player call unitSeen) then {
		_seen = "o_o";
	};	
	_txt = format ["<t size='0.6'>$%1<br/>%2<br/>%3</t>", [player getVariable "money", 1, 0, true] call CBA_fnc_formatNumber,_seen,_wanted];
	if (_txt != _currentTxt) then {			
		_setText ctrlSetStructuredText (parseText format ["%1", _txt]);
		_setText ctrlCommit 0;
		_currentTxt = _txt;
	};
	sleep 0.5;
};
