params ["_unit",["_dis",800]];
{
	if(side _x isEqualTo east && !(units _x isEqualTo [])) then {
		private _lead = leader _x;
		if((_lead distance _unit) < _dis) then {
			_lead reveal [_unit,1.5];					
		};
	};
}foreach(allgroups);