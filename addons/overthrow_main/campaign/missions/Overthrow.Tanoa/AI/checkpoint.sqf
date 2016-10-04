private ["_inrange","_searching","_searched","_gone","_vehs"];

_group = _this;


_start = getpos ((units _group) select 0);

_wp = _group addWaypoint [_start,0];
_wp setWaypointType "GUARD";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "LIMITED";

_outerRange = 80;
_innerRange = 20;

_inrange = [];
_searching = [];
_searched = [];
_gone = [];
_vehs = [];

while {!(isNull _group) and count (units _group) > 0} do {
	{
		_unit = _x;
		_iscar = false;
		if(_unit isKindOf "LandVehicle") then {
			_unit = driver _unit;
			_iscar = true;
			_vehs pushBack [_unit,_x];
		};
		if !(_unit in _inrange) then {
			_inrange pushback _unit;
			if((isPlayer _unit) and (captive _unit)) then {
				if(_iscar) then {
					"Please approach the checkpoint slowly, do NOT exit your vehicle" remoteExec ["notify_talk",_unit,true];
				}else{
					"Please approach the checkpoint for a search, citizen" remoteExec ["notify_talk",_unit,true];
				};			
			};
		};		
	}foreach(_start nearentities [["Man","LandVehicle"],_outerRange]);
	
	_gone = [];
	{		
		
		if(_x distance _start > _outerRange) then {
			//Unit has left the area
			_gone pushback _x;				
			if(isPlayer _x and !(_x in _searched)) then {				
				_x setCaptive false;
				_x spawn revealToNATO;
			};
		}else{
			_iscar = false;
			_veh = false;
			if(isPlayer _x) then {
				_unit = _x;				
				{					
					if(_x select 0 == _unit) then {
						_veh = _x select 1;
						_iscar = true;
						if(vehicle _unit != _veh) then {
							//Player exited the vehicle... sigh
							_unit setCaptive false;
							{
								if(side _x == west) then {
									_x reveal [_unit,1.5];
									sleep 0.2;
								};
							}foreach(_start nearentities ["Man",500]);
							_gone pushback _unit;
						};
					};
				}foreach(_vehs);
			};
			if(_x distance _start < _innerRange) then {
				if !(_x in _searching or _x in _searched) then {
					if(isPlayer _x) then {
						_searching pushback _x;
						"Searching..." remoteExec ["notify_talk",_x,true];
					};
				}else{
					if(isPlayer _x and !(_x in _searched)) then {
						_brokenlaw = false;
						_msg = "Search complete, be on your way";
						_items = [];
						_unit = _x;
						if(_iscar) then {
							_items = _veh call unitStock;
							_unit = driver _veh;
						}else{
							_items = _x call unitStock;
						};
						
						{
							_cls = _x select 0;
							if(_cls in OT_allWeapons + OT_allMagazines + OT_illegalHeadgear + OT_illegalVests + OT_illegalItems + OT_allStaticBackpacks) exitWith {
								_msg = "NATO found illegal items";
								_unit setCaptive false;
								{
									if(side _x == west) then {
										_x reveal [_unit,1.5];
										sleep 0.2;
									};
								}foreach(_start nearentities ["Man",500]);						
							};
						}foreach(_items);
						_msg remoteExec ["notify_talk",_x,true];
						_searched pushback _x;
						_searching deleteAt(_searching find _x);
					};
				};
			}else{
				if (_x in _searching and isPlayer _x) then {
					"Return to the checkpoint immediately and wait while you are searched" remoteExec ["notify_talk",_x,true];
					_searching deleteAt(_searching find _x);
				}
			};
		};
	}foreach(_inrange);
	
	{
		_inrange deleteAt (_inrange find _x);
		if(_x in _searched) then {
			_searched deleteAt (_searched find _x);
		};
	}foreach(_gone);
	sleep 3;
};
