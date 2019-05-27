private _fitness = _this getVariable ["OT_fitness",1];

if(ace_advanced_fatigue_anreserve < 2300) then {
	ace_advanced_fatigue_anreserve = ace_advanced_fatigue_anreserve + (_fitness * 12);
	if(_fitness isEqualTo 5) then {ace_advanced_fatigue_anreserve = 2300};
};

[OT_fnc_perkSystem,_this,2] call CBA_fnc_waitAndExecute;
