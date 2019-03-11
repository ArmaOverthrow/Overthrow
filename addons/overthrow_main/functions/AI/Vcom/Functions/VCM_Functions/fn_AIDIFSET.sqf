//Skip if Vcom Skillchange is disabled
if (!VCM_SKILLCHANGE) exitWith {};
{
	private _unit = _x;
	_unit setSkill 0.9;
	_unit allowFleeing 0;
	{
		_unit setSkill _x;
	} forEach VCM_AIDIFA;


	if (VCM_CLASSNAMESPECIFIC && {count VCM_SKILL_CLASSNAMES > 0}) then
	{
		{
			if (typeOf _unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_unit setSkill ["aimingShake",((_x select 1) select 1)];_unit setSkill ["spotDistance",((_x select 1) select 2)];_unit setSkill ["spotTime",((_x select 1) select 3)];_unit setSkill ["courage",((_x select 1) select 4)];_unit setSkill ["commanding",((_x select 1) select 5)];	_unit setSkill ["aimingSpeed",((_x select 1) select 6)];_unit setSkill ["general",((_x select 1) select 7)];_unit setSkill ["endurance",((_x select 1) select 8)];_unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCM_SKILL_CLASSNAMES;
	};

	if (VCM_SIDESPECIFICSKILL) then
	{
		_unit call VCM_fnc_AISIDESPEC;
	};

} forEach (units _this);