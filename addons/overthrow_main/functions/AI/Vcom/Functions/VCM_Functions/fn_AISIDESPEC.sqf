//Reallocates skill variables before group skill settings are applied
VCM_AIDIFWEST = [['aimingAccuracy',VCM_AISKILL_AIMINGACCURACY_W],['aimingShake',VCM_AISKILL_AIMINGSHAKE_W],['aimingSpeed',VCM_AISKILL_AIMINGSPEED_W],['commanding',1],['courage',1],['endurance',1],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];
VCM_AIDIFEAST = [['aimingAccuracy',VCM_AISKILL_AIMINGACCURACY_E],['aimingShake',VCM_AISKILL_AIMINGSHAKE_E],['aimingSpeed',VCM_AISKILL_AIMINGSPEED_E],['commanding',1],['courage',1],['endurance',1],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];
VCM_AIDIFRESISTANCE = [['aimingAccuracy',VCM_AISKILL_AIMINGACCURACY_R],['aimingShake',VCM_AISKILL_AIMINGSHAKE_R],['aimingSpeed',VCM_AISKILL_AIMINGSPEED_R],['commanding',1],['courage',1],['endurance',1],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];

private _Side = (side (group _this));
switch (_Side) do {
	case west:
	{
		{
			_this setSkill _x;
		} forEach VCM_AIDIFWEST;
	};
	case east:
	{
		{
			_this setSkill _x;
		} forEach VCM_AIDIFEAST;
	};
	case resistance:
	{
		{
			_this setSkill _x;
		} forEach VCM_AIDIFRESISTANCE;
	};
};