private ["_unit","_town"];

_unit = _this select 0;
_town = _this select 1;

_unit setVariable ["criminal",true,false];
_unit setVariable ["town",_town,false];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(isPlayer _src) then {
		if((vehicle _src) != _src or (_src call unitSeenCRIM)) then {
			_src setCaptive false;	
			{
				if(side _x == east) then {
					_x reveal [_src,1.5];					
				};
			}foreach(_src nearentities ["Man",50]);
		};		
	};	
}];