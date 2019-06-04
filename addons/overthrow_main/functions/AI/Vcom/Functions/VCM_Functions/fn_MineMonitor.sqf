
/*
	Author: Genesis

	Description:
		This function will monitor all placed Vcom mines. Better than each mine having its own spawn.

	Parameter(s):
		NONE

	Returns:
		NOTHING
*/

["OT_mine_monitor","_counter%1.5 isEqualTo 0","
	private _removeList = [];
	{
		_x params [""_mine"",""_side""];
		if (alive _mine) then {
			private _EL = [];
			private _targetSide = """";
			{
				_targetSide = side _x;
				if ([_side, _targetSide] call BIS_fnc_sideIsEnemy) then {_EL pushback _x;};
			} forEach allUnits;

			private _CE = [_EL,_mine,true,""2""] call VCM_fnc_ClstObj;

			if (_CE distance _mine < 2.5) then {
				[_mine, true] remoteExecCall [""enableSimulationGlobal"",2];
				[_mine] spawn {
					_this params [""_mine""];
					sleep 0.35;
					_mine setdamage 1;
				};
			};
		} else {
			_removeList pushback _x;
		};
	} foreach VCOM_MINEARRAY;

	{
		_x params [""_a""];
		VCOM_MINEARRAY deleteAt (VCOM_MINEARRAY findIf {_a isEqualTo _x;});
	} foreach _RemoveList;
"] call OT_fnc_addActionLoop;
