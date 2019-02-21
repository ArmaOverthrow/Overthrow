while {true} do
{
	sleep 0.25;
	//systemchat format ["VcomAI_UnitQueue: %1",VcomAI_UnitQueue];
	if !(VcomAI_UnitQueue isEqualTo []) then
	{
		private _ConsideringUnit = VcomAI_UnitQueue select 0;
		private _Disabled = _ConsideringUnit getVariable ["VCOM_NOAI",false];
		if ((vehicle _ConsideringUnit) isKindOf "Plane") then {_Disabled = true;_ConsideringUnit setvariable ["VCOM_NOAI",true];};
		if (!(isNull _ConsideringUnit) && !(_Disabled)) then 
		{
			if (side _ConsideringUnit in VCOM_SideBasedExecution) then
			{
				[_ConsideringUnit] execFSM "VCOMAI\AIBEHAVIORNEW.fsm";
			};
				VcomAI_ActiveList pushback _ConsideringUnit;
				VcomAI_UnitQueue deleteAt 0;
		}
		else
		{
				VcomAI_UnitQueue deleteAt 0;		
		};
		

		{
			if (isNull _x) then {VcomAI_ActiveList = VcomAI_ActiveList - [_x];};
		} foreach VcomAI_ActiveList;		
	};

	
	//systemchat format ["VcomAI_ActiveList: %1",VcomAI_ActiveList];

	
};