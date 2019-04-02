OT_context = _this select 0;
OT_inputHandler = {
	_val = parseNumber(ctrltext 1400);
	_cash = player getVariable ["money",0];
	if(_val > _cash) then {_val = _cash};
	if(_val > 0) then {
		[-_val] call OT_fnc_money;
		_in = OT_context getVariable ["money",0];
		OT_context setVariable ["money",_in + _val,true];
	};
};

["How much to put in this safe?",player getvariable ["money",100]] call OT_fnc_inputDialog;
