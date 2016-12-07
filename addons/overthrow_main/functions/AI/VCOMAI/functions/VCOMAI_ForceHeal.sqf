_Unitgroup = group _this;
{
	if (damage _x > 0) then 
	{
			while {alive _x && {alive _this} && {_this distance _x > 3}} do 
			{
				_this domove (getposATL _x);
				_this forcespeed -1;				
				sleep 5;
				if (VCOM_AIDEBUG isEqualTo 1) then
				{
					[_this,"Moving to heal. Like a good medic.",5,20000] remoteExec ["3DText",0];
				};				
			};
			if (alive _x && alive _this && _this distance _x <= 3) then
			{
				_this action ["HealSoldier",_x];
				_this forcespeed -1;
				if (VCOM_AIDEBUG isEqualTo 1) then
				{
					[_this,"Healing. Like a good medic.",15,20000] remoteExec ["3DText",0];
				};				
			};
	}; 
} foreach (units _Unitgroup);