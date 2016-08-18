private ["_eh","_handler"];

_handler = {
	private ["_vehs","_dest","_destpos","_passengers"];
	if !(visibleMap or visibleGPS) exitWith {};
	_vehs = [];
	if(isMultiplayer) then {
		{
			_veh = vehicle _x;			
			if(_veh == _x) then {
				if!(captive _x) then {
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\groupicons\waypoint.paa",
						[0,0.5,0,1],
						getpos _x,
						24,
						24,
						getdir _x
					];
				};
				(_this select 0) drawIcon [
					"iconMan",
					[0,0.5,0,1],
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
	_t = 1;
	{
		if (!(isPlayer _x)) then {
			_veh = vehicle _x;
			if(_veh == _x) then {
				_dest = expectedDestination _x;
				_destpos = _dest select 0;
				
				if(_x in groupSelectedUnits player) then {
					(_this select 0) drawIcon [
						"\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa",
						[0,0.5,0,1],
						getpos _x,
						24,
						24,
						0
					]; 
				};
				if ((_dest select 1)== "LEADER PLANNED") then {
					(_this select 0) drawLine [
						getPos _x,
						_destpos,
						[0,0.5,0,1]
					];
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\groupicons\waypoint.paa",
						[0,0.5,0,1],
						_destpos,
						24,
						24,
						0
					]; 
				};
				
				_size = 24;
				_icon = "iconMan";
				_dir = getDir _x;
				if !(captive _x) then {
					_icon = "\A3\ui_f\data\map\groupicons\waypoint.paa";
					_size = 30;
					_dir = 0;
				};
				(_this select 0) drawIcon [
					_icon,
					[0,0.5,0,1],
					getpos _x,
					_size,
					_size,
					_dir,
					format["%1",_t]
				];
			}else{
				if !(_veh in _vehs) then {
					_vehs pushback _veh;
				};
			};
		};
		_t = _t + 1;
	}foreach(units (group player));
	
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
				if(_ka > 1.4) then {
					_opacity = (_ka-1.4) / 1;
					if(_opacity > 1) then {_opacity = 1};
					_pos = getpos _u;					
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\markers\nato\b_inf.paa",
						[0,0.3,0.59,_opacity],
						_pos,
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
				if(_ka > 1.4) then {
					_opacity = (_ka-1.4) / 1;
					if(_opacity > 1) then {_opacity = 1};
					_pos = getpos _u;
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\markers\nato\b_inf.paa",
						[0.5,0,0,_opacity],
						_pos,
						30,
						30,
						0
					]; 
				};
			}
		};
		
	}foreach(allGroups);	
};

_eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", _handler];

[_handler] spawn {	
	private ['_gps',"_handler"];
	_handler = _this select 0;
	disableSerialization;
	_gps = controlNull;
	for '_x' from 0 to 1 step 0 do {
		{
			if !(isNil {_x displayCtrl 101}) then {
				_gps = _x displayCtrl 101;
			};
		} count (uiNamespace getVariable 'IGUI_Displays');
		uiSleep 1;
		if (!isNull _gps) exitWith {
			_gps ctrlAddEventHandler ['Draw',_handler];
		};
		uiSleep 0.25;
	};
};