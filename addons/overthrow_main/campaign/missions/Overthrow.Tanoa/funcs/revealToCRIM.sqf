private _unit = _this;
{
	if(side _x == east) then {
		_x reveal [_unit,1.5];					
	};
	sleep 0.1;
}foreach(_unit nearentities ["Man",800]);