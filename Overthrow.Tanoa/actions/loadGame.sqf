private ["_data"];

//get all server data
"Please wait.. loading persistent save" remoteExec['blackFaded',0];

_data = profileNameSpace getVariable ["Overthrow.save.001",""];
if(typename _data != "ARRAY") exitWith {
	[] execVM "initEconomy.sqf";
	"No save found, starting new game" remoteExec ["hint",bigboss,true];
};
{
	_key = _x select 0;
	_val = _x select 1;
	_set = true;
	if(_key == "bases") then {
		{
			_pos = _x select 0;
			_name = _x select 1;
			_owner = _x select 2;
			
			_veh = createVehicle [OT_Item_Flag, _pos, [], 0, "CAN_COLLIDE"];
			_veh setVariable ["owner",_owner,true];
			_veh = createVehicle ["Land_ClutterCutter_large_F", _pos, [], 0, "CAN_COLLIDE"];
			
			_mrkid = format["%1-base",_pos];
			createMarker [_mrkid,_pos];
			_mrkid setMarkerShape "ICON";
			_mrkid setMarkerType "mil_Flag";
			_mrkid setMarkerColor "ColorWhite";
			_mrkid setMarkerAlpha 1;
			_mrkid setMarkerText _name;
		}foreach(_val);
	};
	if(_key == "vehicles") then {
		_set = false;
		{
			_type = _x select 0;
			if !(_type isKindOf "Man") then {
				_pos = _x select 1;
				_dir = _x select 2;
				_stock = _x select 3;
				_owner = _x select 4;
				_name = "";
				if(count _x > 5) then {
					_name = _x select 5;
				};
				
				_veh = createVehicle [_type,[0,0,0],[],0,"CAN_COLLIDE"];
				_veh setPos _pos;
				_veh setDir _dir;
				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearBackpackCargoGlobal _veh;
				clearItemCargoGlobal _veh;	
				_veh setVariable ["name",_name,true];
				
				if(_type == OT_item_Map) then {
					_veh setObjectTextureGlobal [0,"dialogs\maptanoa.paa"];
				};
				
				if(_type in OT_staticMachineGuns) then {		
					_veh remoteExec["initStaticMGLocal",0,_veh];
				};
			
				_veh setVariable ["owner",_owner,true];
				{
					_cls = _x select 0;
					_num = _x select 1;
					if(_cls in OT_allWeapons) then {
						_veh addWeaponCargoGlobal _x;
					}else{
						if(_cls in OT_allMagazines) then {
							_veh addMagazineCargoGlobal _x;
						}else{
							_veh addItemCargoGlobal _x;
						};
					};				
				}foreach(_stock);
				
				if(count _x > 6) then {
					_code = (_x select 6);
					if(_code != "") then {
						[_veh] execVM _code;
					};
				};
			};
		}foreach(_val);
	};
	
	if(_set) then {
		server setvariable [_key,_val,true];
	};	
}foreach(_data);
sleep 2; //let the variables propagate
server setVariable ["StartupType","LOAD",true];
hint "Persistent Save Loaded";