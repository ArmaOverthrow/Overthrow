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

private _seen = "";
if(_player call OT_fnc_unitSeenNATO) then {
	_seen = "<t color='#5D8AA8'>o_o</t>";
}else{
	if(_player call OT_fnc_unitSeenCRIM) then {
		_seen = "<t color='#B2282f'>o_o</t>";
	};
};
private _qrf = "";
private _attacking = server getVariable ["NATOattacking",OT_nation];
if(!isNil "OT_QRFstart" && (time - OT_QRFstart) < 600) then {
	private _secs = 600 - round(time - OT_QRFstart);
	private _mins = 0;
	if(_secs > 59) then {
		_mins = floor(_secs / 60);
		_secs = round(_secs % 60);
	};
	if(_mins < 10) then {_mins = format["0%1",_mins]};
	if(_secs < 10) then {_secs = format["0%1",_secs]};
	_qrf = format["<t size='0.7'>Battle of %1</t><br/>Starting (%2:%3)",_attacking,_mins,_secs];
};

if(!isNil "OT_QRFstart" && (time - OT_QRFstart) > 600) then {
	private _progress = server getVariable ["QRFprogress",0];
	if(_progress > 0) then {
		_qrf = format["<t size='0.7'>Battle of %1</t><br/><t color='#5D8AA8'>(%2%3)</t>",_attacking,round (_progress * 100),'%'];
	}else{
		_qrf = format["<t size='0.7'>Battle of %1</t><br/><t color='#008000'>(%2%3)</t>",_attacking,round abs (_progress * 100),'%'];
	}
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
