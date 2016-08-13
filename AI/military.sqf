_unit = _this select 0;

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(isPlayer _src) then {
		if((vehicle _src) != _src or (_src call unitSeenNATO)) then {
			_src setCaptive false;	
			{
				if(side _x == west) then {
					_x reveal [_src,1.5];						
				};
			}foreach(_src nearentities ["Man",50]);
		};		
	};	
}];