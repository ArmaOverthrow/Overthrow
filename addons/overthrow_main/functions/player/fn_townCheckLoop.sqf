if(!alive _this) exitWith {};

private _pos = getPosASL _this;
if(OT_Map_EachFrameLastTownCheckPos distance2D _pos < 50) exitWith {
	[OT_fnc_townCheckLoop, _this, 5] call CBA_fnc_waitAndExecute;
};
OT_Map_EachFrameLastTownCheckPos = _pos;

private _town = _pos call OT_fnc_nearestTown;
if (!isNil "_town" && {OT_Map_EachFrameLastTown != _town}) then {
	OT_Map_EachFrameLastTown = _town;
	private _pop = server getVariable format["population%1",_town];
	if(!isNil "_pop") then {
		if(OT_showTownChange) then {
			private _stability = server getVariable format["stability%1",_town];
			private _rep = [_town] call OT_fnc_support;
			private _abandon = "NATO Controlled";
			if(_town in (server getVariable ["NATOabandoned",[]])) then {
				private _garrison = server getVariable [format['police%1',_town],0];
				if(_garrison > 0) then {
					_abandon = "Resistance Controlled";
				}else{
					_abandon = "Anarchy";
				};
			};
			private _plusmin = ["","+"] select (_rep > -1);

			[format [
				"<t align='left' size='1.2' color='#eeeeee'>%1</t><br/>
				<t align='left' size='0.5' color='#bbbbbb'>Status: %7</t><br/>
				<t align='left' size='0.5' color='#bbbbbb'>Population: %2</t><br/>
				<t align='left' size='0.5' color='#bbbbbb'>Stability: %3%4</t><br/>
				<t align='left' size='0.5' color='#bbbbbb'>Resistance Support: %5%6</t>",
				_town,
				[_pop, 1, 0, true] call CBA_fnc_formatNumber,
				_stability,
				"%",
				_plusmin,
				_rep,
				_abandon
			], -0.5, 1, 5, 1, 0, 5] call OT_fnc_dynamicText;
		};
	};
};
[OT_fnc_townCheckLoop, _this, 5] call CBA_fnc_waitAndExecute;
