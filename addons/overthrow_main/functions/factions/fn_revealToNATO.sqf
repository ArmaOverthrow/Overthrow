private _unit = _this;
{
	if(side _x isEqualTo west && !(units _x isEqualTo [])) then {
		private _lead = leader _x;
		if((_lead distance _unit) < 800) then {
			_lead reveal [_unit,1.5];					
		};
		sleep 0.2;
	};
}foreach(allgroups);