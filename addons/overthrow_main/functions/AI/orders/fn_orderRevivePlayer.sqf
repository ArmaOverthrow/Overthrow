params ["_medic","_unit"];

_medic doMove getPosATL _unit;
[
	{
		params ["_medic","_unit"];
		!alive _medic
		||
		{!alive _unit}
		||
		{(_medic distance _unit < 5)}
		||
		{!(_unit getVariable ["ACE_isUnconscious",false])}
	},
	{
		params ["_medic","_unit"];
		if(!alive _unit || !(_unit getVariable ["ACE_isUnconscious",false])) exitWith {};
		if(!alive _medic) exitWith {
			private _otherMedics = (_unit getVariable ["OT_informedMedics",0]) - 1;
			_unit setVariable ["OT_informedMedics",_otherMedics];

			if (_otherMedics <= 0) then {
				[_unit] call OT_fnc_unconsciousNoHelpPossible;
			};
		};
		// play anim and get him back alive
		_medic action ["HealSoldier", _unit];
		[_medic,"AinvPknlMstpSnonWnonDnon_medic_1"] remoteExec ["playMove",_medic,false];
		[
			{
				params ["_medic","_unit"];
				if!("ACE_epinephrine" in items _medic) then {
					_unit removeItem "ACE_epinephrine";
				} else {
					_medic removeItem "ACE_epinephrine";
				};
				[_unit, false] call ACE_medical_fnc_setUnconscious;
			},
			_this,
			5
		] call CBA_fnc_waitAndExecute;
	},
	_this,
	300,
	{
		params ["","_unit"];
		private _otherMedics = (_unit getVariable ["OT_informedMedics",0]) - 1;
		_unit setVariable ["OT_informedMedics",_otherMedics];

		if (_otherMedics <= 0) then {
			[_unit] call OT_fnc_unconsciousNoHelpPossible;
		};
	}
] call CBA_fnc_waitUntilAndExecute;
