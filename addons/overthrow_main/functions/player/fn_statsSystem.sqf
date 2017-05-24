private ["_txt","_currentTxt","_display","_setText"];
disableSerialization;
//1 cutRsc ["H8erHUD","PLAIN",0,false];
_layer = ["stats"] call bis_fnc_rscLayer;
_layer cutRsc ["OT_statsHUD","PLAIN",0,false];
waitUntil {!isNull (uiNameSpace getVariable "OT_statsHUD")};

_display = uiNameSpace getVariable "OT_statsHUD";
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
	if(player call OT_fnc_unitSeenNATO) then {
		_seen = "<t color='#5D8AA8'>o_o</t>";

		_replim = 50;
		_skill = player getVariable ["OT_stealth",0];
		if(_skill == 1) then {_replim = 75};
		if(_skill == 2) then {_replim = 100};
		if(_skill == 3) then {_replim = 150};
		if(_skill == 4) then {_replim = 200};
		if(_skill < 5) then {
			if(_rep < -_replim) then {
				_seen = "<t color='#5D8AA8'>O_O</t>";
			};
		};
	}else{
		if(player call OT_fnc_unitSeenCRIM) then {
			_seen = "<t color='#B2282f'>o_o</t>";
			_totalrep = (abs _rep);
			_replim = 50;
			_skill = player getVariable ["OT_stealth",0];
			if(_skill == 1) then {_replim = 75};
			if(_skill == 2) then {_replim = 100};
			if(_skill == 3) then {_replim = 150};
			if(_skill == 4) then {_replim = 200};
			if(_skill < 5) then {
				if(_totalrep > _replim) then {
					_seen = "<t color='#B2282f'>O_O</t>";
				};
			};
		};
	};
	_qrf = "";
	_qrfstart = server getVariable "QRFstart";
	if(!isNil "_qrfstart") then {
		if((time - _qrfstart) < 300) then {
			_secs = 300 - round(time - _qrfstart);
			_mins = 0;
			if(_secs > 59) then {
				_mins = floor(_secs / 60);
				_secs = round(_secs % 60);
			};
			if(_secs < 10) then {_secs = format["0%1",_secs]};
			_qrf = format["Battle start in 0%1:%2",_mins,_secs];
		};
	};

	_txt = format ["<t size='0.9' align='right'>$%1<br/>%2<br/>%3<br/>%4</t>", [player getVariable "money", 1, 0, true] call CBA_fnc_formatNumber,_seen,_wanted,_qrf];
	_setText ctrlSetStructuredText (parseText format ["%1", _txt]);
	_setText ctrlCommit 0;
	_currentTxt = _txt;

	sleep 1;
}
