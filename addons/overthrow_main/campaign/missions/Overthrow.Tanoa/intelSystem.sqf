private ["_eh","_handler"];

if(isMultiplayer) then {
	onEachFrame {
		{
			if !(_x isEqualTo player) then {
				drawIcon3D ["a3\ui_f\data\map\groupicons\selector_selectable_ca.paa", [1,1,1,0.5], getPos _x, 1, 1, 0, format["%1 (%2m)",name _x,round(_x distance player)], 0, 0.02, "TahomaB", "center", true];
			};
		}foreach(allPlayers);	
	};
};

_handler = {
	private ["_vehs","_dest","_destpos","_passengers"];
	if !(visibleMap or visibleGPS) exitWith {};
	_vehs = [];
	if(isMultiplayer) then {
		{
			_veh = vehicle _x;			
			if(_veh == _x) then {
				_color = [0,0.5,0,1];
				if!(captive _x) then {
					_color = [0.5,0,0,1];
				};
				(_this select 0) drawIcon [
					"iconMan",
					_color,
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
				_color = [0,0.5,0,1];
				if !(captive _x) then {
					_color = [0.5,0,0,1];
				};
				if(_x in groupSelectedUnits player) then {
					(_this select 0) drawIcon [
						"\A3\ui_f\data\igui\cfg\islandmap\iconplayer_ca.paa",
						_color,
						visiblePosition  _x,
						24,
						24,
						0
					]; 
				};
				if ((_dest select 1)== "LEADER PLANNED") then {
					(_this select 0) drawLine [
						getPos _x,
						_destpos,
						_color
					];
					(_this select 0) drawIcon [
						"\A3\ui_f\data\map\groupicons\waypoint.paa",
						_color,
						_destpos,
						24,
						24,
						0
					]; 
				};
				
				
				(_this select 0) drawIcon [
					"iconMan",
					_color,
					visiblePosition  _x,
					24,
					24,
					getDir _x,
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
		_color = [0,0.5,0,1];
		{
			if(isPlayer _x and _x != player) then {
				_passengers = format["%1 %2",_passengers,name _x];				
			};
			if !(captive _x) then {_color = [0.5,0,0,1]};
		}foreach(crew _x);
		
		(_this select 0) drawIcon [
			getText(configFile >> "CfgVehicles" >> (typeof _x) >> "icon"),
			_color,
			visiblePosition  _x,
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
					_pos = visiblePosition  _u;					
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
					_pos = visiblePosition  _u;
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
	
	{
		if(side _x == resistance) then {
			if(_x isKindOf "StaticWeapon" and isNull attachedTo _x) then {
				_i = "\A3\ui_f\data\map\markers\nato\o_art.paa";	
				if(_x isKindOf "StaticMortar") then {_i = "\A3\ui_f\data\map\markers\nato\o_mortar.paa"};
				(_this select 0) drawIcon [
					_i,
					[0,0.5,0,1],
					position _x,
					30,
					30,
					0
				]; 
			};
		};
	}foreach(vehicles);
	
	_scale = ctrlMapScale (_this select 0);
	if(_scale <= 0.14) then {
		{
			(_this select 0) drawIcon [
				"iconObject_circle",
				[1,1,1,1],
				_x select 0,
				0.5/ctrlMapScale (_this select 0),
				0.5/ctrlMapScale (_this select 0),
				0
			]; 
		}foreach(OT_allActiveShops);
	};
	
	
	mapCenter 
};

if(!isNil "OT_OnDraw") then {
	((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw",OT_OnDraw];
};

OT_OnDraw = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", _handler];

//GPS
[_handler] spawn {	
	private ['_gps',"_handler"];
	_handler = _this select 0;
	disableSerialization;
	private _gps = controlNull;
	for '_x' from 0 to 1 step 0 do {
		{
			if !(isNil {_x displayCtrl 101}) exitWith {
				_gps = _x displayCtrl 101;
			};
		} foreach(uiNamespace getVariable "IGUI_Displays");
		uiSleep 1;
		if (!isNull _gps) exitWith {
			if(!isNil "OT_GPSOnDraw") then {			
				_gps ctrlRemoveEventHandler ['Draw',OT_GPSOnDraw];
			};
			OT_GPSOnDraw = _gps ctrlAddEventHandler ['Draw',_handler];
		};
		uiSleep 0.25;
	};
};