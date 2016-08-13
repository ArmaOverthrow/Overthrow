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

while {alive player} do {
	_wanted = "<br/>";
	if !(captive player) then {
		_hiding = player getVariable "hiding";
		if((_hiding > 0) and (_hiding < 30)) then {
			_wanted = format["(%1) WANTED",_hiding];
		}else{
			_wanted = "WANTED";
		};		
	};
	_standing = "";
	_rep = player getVariable "rep";
	if(_rep > -1) then {
		_standing = format["+%1",_rep];
	}else{
		_standing = format["%1",_rep];
	};

	_seen = "";
	if(player call unitSeenNATO) then {
		_seen = "<t color='#5D8AA8'>o_o</t>";
		if(_rep < -50) then {
			_seen = "<t color='#5D8AA8'>O_O</t>";
		};
	}else{
		if(player call unitSeenCRIM) then {
			_seen = "<t color='#B2282f'>o_o</t>";
			if((abs _rep) > 50) then {
				_seen = "<t color='#B2282f'>O_O</t>";
			};
		};
	};
	_txt = format ["<t size='0.7'>$%1<br/>%2<br/>%3<br/>%4</t>", [player getVariable "money", 1, 0, true] call CBA_fnc_formatNumber,_standing,_seen,_wanted];
	if (_txt != _currentTxt) then {			
		_setText ctrlSetStructuredText (parseText format ["%1", _txt]);
		_setText ctrlCommit 0;
		_currentTxt = _txt;
	};
	sleep 0.5;
};
