_Unitgroup = group _this;
{
	if (damage _x > 0) then 
	{
			while {alive _x && {alive _this} && {_this distance _x > 3}} do 
			{
				_this domove (getposATL _x);
				sleep 5;
			};
			if (alive _x && alive _this && _this distance _x <= 3) then
			{
				_this action ["HealSoldier",_x];
			};
	}; 
} foreach (units _Unitgroup);