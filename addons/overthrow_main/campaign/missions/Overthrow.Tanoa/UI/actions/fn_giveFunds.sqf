closeDialog 0;
inputHandler = {
	_val = parseNumber(ctrltext 1400);
	_cash = player getVariable ["money",0];
	if(_val > _cash) then {_val = _cash};
	if(_val > 0) then {
		[_val] call OT_fnc_resistanceFunds;
        [-_val] call money;
        format ["%1 donated $%2 to the resistance",name player,[_val, 1, 0, true] call CBA_fnc_formatNumber] remoteExec ["notify_minor",0,false];
	};
};

["How much to donate to resistance?",player getVariable ["money",100]] spawn inputDialog;
