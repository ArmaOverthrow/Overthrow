private ["_leader","_bounty","_time","_stability","_newbounty","_current"];

if !(isServer) exitWith {};

{
	server setVariable [format["CRIMbounty%1",_x],0,true];	
}foreach(AIT_allTowns);

while {true} do {
	{
		_leader = server getVariable [format["crimleader%1",_x],false];
		if (typename _leader == "ARRAY") then {
			_bounty = server getVariable format["CRIMbounty%1",_x];
			_time = server getVariable [format["crimtime%1",_x],0];
			_stability = server getVariable [format["stability%1",_x],0];
			if(_stability > 20) then {_stability = 20};
			_newbounty = 250 + round(500 * ((20 - _stability)/20));
			if(_time > 0) then {
				_newbounty = _newbounty + (round(_time / 2));				
			};
			if(_newbounty != _bounty) then {
				server setVariable [format["CRIMbounty%1",_x],_newbounty,true];
			};
		};		 
	}foreach(AIT_allTowns);
	sleep 240;
};