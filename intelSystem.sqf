

_eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {
	if !(visibleMap) exitWith {};
	_vehs = [];
	if(isMultiplayer) then {
		{
			_veh = vehicle _x;
			if(_veh == _x) then {
				(_this select 0) drawIcon [
					"iconMan",
					[1,1,1,1],
					getpos _x,
					24,
					24,
					getdir _x,
					name _x
				]; 
			}else{
				if !(_veh in _vehs) then {
					_vehs pushback _veh;
				};
			};
		}foreach(allPlayers);
	};
	
	{
		_passengers = "";
		{
			if(isPlayer _x) then {
				_passengers = format["%1 %2",_passengers,name _x]
			};
		}foreach(units _x);
		
		(_this select 0) drawIcon [
			"iconCar",
			[1,1,1,1],
			getpos _x,
			24,
			24,
			getdir _x,
			_passengers
		]; 
	}foreach(_vehs);
	
	{
		if(side _x == west) then {
			_u = leader _x;
			_alive = false;
			if(!alive _u) then {
				{
					if(alive _x) exitWith {_u = _x;_alive=true};
				}foreach(units _x);
			}else{
				_alive = true;
			};
			if(_alive) then {
				_ka = resistance knowsabout _u;
				if(_ka > 1) then {
					_opacity = (_ka-1) / 1;
					if(_opacity > 1) then {_opacity = 1};
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\markers\nato\b_inf.paa",
						[0,0.3,0.59,_opacity],
						(player targetKnowledge _u) select 6,
						30,
						30,
						0
					]; 
				};
			}
		};
		
		if(side _x == east) then {
			_u = leader _x;
			_alive = false;
			if(!alive _u) then {
				{
					if(alive _x) exitWith {_u = _x;_alive=true};
				}foreach(units _x);
			}else{
				_alive = true;
			};
			if(_alive) then {
				_ka = resistance knowsabout _u;
				if(_ka > 1) then {
					_opacity = (_ka-1) / 1;
					if(_opacity > 1) then {_opacity = 1};
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\markers\nato\b_inf.paa",
						[0.5,0,0,_opacity],
						(player targetKnowledge _u) select 6,
						30,
						30,
						0
					]; 
				};
			}
		};
		
	}foreach(allGroups);	
}];