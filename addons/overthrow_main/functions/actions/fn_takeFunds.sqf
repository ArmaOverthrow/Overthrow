closeDialog 0;
OT_inputHandler = {
	_val = parseNumber(ctrltext 1400);
	_cash = server getVariable ["money",0];
	if(_val > _cash) then {_val = _cash};
	if(_val > 0) then {
		[-_val] call OT_fnc_resistanceFunds;
        [_val] call OT_fnc_money;
	};
};

["How much to take from resistance?",1000] call OT_fnc_inputDialog;
