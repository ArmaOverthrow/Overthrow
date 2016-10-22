private ["_ret","_unit","_know"];
_unit = _this;
_ret = false;
{
	if(side _x == east) then {
		if((_x distance _unit) < 20) then {
			_ret = true;
		}else{
			_know = _x targetKnowledge _unit;
			_lastSeen = _know select 2;
			if(_lastSeen > 1 and (time - _lastSeen) < 10) then {
				_ret = true;
			};
		};
	};
	if(_ret) exitWith {};
}foreach(_unit nearentities ["Man",1200]);

_ret;