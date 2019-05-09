params["_unit",["_dis",800]];
{
	if(side _x isEqualTo resistance && !(units _x isEqualTo [])) then {
		private _lead = leader _x;
		if((_lead distance2D _unit) < _dis) then {
			_lead reveal [_unit,4];
		};
	};
}foreach(allgroups);
