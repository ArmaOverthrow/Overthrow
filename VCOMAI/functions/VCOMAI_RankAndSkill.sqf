_Unit = _this;

if (VCOM_AISkillEnabled) then 
{
	_RankReturn = [_Unit] call VcomAI_DetermineRank;
	switch (_RankReturn) do {
			case 0: {[_Unit] call AccuracyFunctionRank0;};
			case 1: { [_Unit] call AccuracyFunctionRank1; };
			case 2: { [_Unit] call AccuracyFunctionRank2; };
			case 3: { [_Unit] call AccuracyFunctionRank3; };
			case 4: { [_Unit] call AccuracyFunctionRank4; };
			case 5: { [_Unit] call AccuracyFunctionRank5; };
			case 6: { [_Unit] call AccuracyFunctionRank6; };
	};
};