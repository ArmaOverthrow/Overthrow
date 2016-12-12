_unit = _this select 0;

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src or (_src call unitSeenNATO)) then {
			_src setCaptive false;				
		};		
	};	
}];