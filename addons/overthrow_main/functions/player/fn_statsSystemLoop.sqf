params ["_player"];
if !(alive _player) exitWith {};

private _wanted = "<br/>";
if !(captive _player) then {
	private _hiding = _player getVariable ["OT_hiding", 0];
	if((_hiding > 0) && (_hiding < 30)) then {
		_wanted = format["(%1) WANTED",_hiding];
	}else{
		_wanted = "WANTED";
	};
};
private _rep = _player getVariable ["rep",0];
private _standing = format["%2%1",_rep,["","+"] select (_rep > 0)];

private _seen = "";
if(_player call OT_fnc_unitSeenNATO) then {
	_seen = "<t color='#5D8AA8'>o_o</t>";

	private _skill = _player getVariable ["OT_stealth",0];
	private _replim = _skill call {
		if(_this isEqualTo 1) exitWith {75};
		if(_this isEqualTo 2) exitWith {100};
		if(_this isEqualTo 3) exitWith {150};
		if(_this isEqualTo 4) exitWith {200};
		50
	};
	if(_skill < 5 && _rep < -_replim) then {
		_seen = "<t color='#5D8AA8'>O_O</t>";
	};
}else{
	if(_player call OT_fnc_unitSeenCRIM) then {
		_seen = "<t color='#B2282f'>o_o</t>";
		private _skill = _player getVariable ["OT_stealth",0];
		private _replim = _skill call {
			if(_this isEqualTo 1) exitWith {75};
			if(_this isEqualTo 2) exitWith {100};
			if(_this isEqualTo 3) exitWith {150};
			if(_this isEqualTo 4) exitWith {200};
			50
		};
		if(_skill < 5 && (abs _rep) > _replim) then {
			_seen = "<t color='#B2282f'>O_O</t>";
		};
	};
};
private _qrf = "";
private _qrfstart = server getVariable "QRFstart";
if(!isNil "_qrfstart" && (time - _qrfstart) < 600) then {
	private _secs = 600 - round(time - _qrfstart);
	private _mins = 0;
	if(_secs > 59) then {
		_mins = floor(_secs / 60);
		_secs = round(_secs % 60);
	};
	if(_secs < 10) then {_secs = format["0%1",_secs]};
	_qrf = format["Battle start in 0%1:%2",_mins,_secs];
};

private _txt = format [
	"<t size='0.9' align='right'>$%1<br/>%2<br/>%3<br/>%4</t>",
	[_player getVariable ["money",0], 1, 0, true] call CBA_fnc_formatNumber,
	_seen,
	_wanted,
	_qrf
];

private _setText = (uiNameSpace getVariable "OT_statsHUD") displayCtrl 1001;
_setText ctrlSetStructuredText (parseText format ["%1", _txt]);
_setText ctrlCommit 0;

[OT_fnc_statsSystemLoop,_this,1] call CBA_fnc_waitAndExecute;
