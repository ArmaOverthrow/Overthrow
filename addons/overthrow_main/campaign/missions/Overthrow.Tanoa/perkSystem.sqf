
while {alive player} do {
	sleep 2;

	private _fitness = player getVariable ["OT_fitness",1];
	if(_fitness > 1) then {
		if(ace_advanced_fatigue_anreserve < 2300) then {
			ace_advanced_fatigue_anreserve = ace_advanced_fatigue_anreserve + (_fitness * 15);
			if(_fitness == 5) then {ace_advanced_fatigue_anreserve = 2300};
		};
	};
};
