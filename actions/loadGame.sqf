private ["_data"];

//get all server data
"Please wait.. loading persistent save" remoteExec['blackFaded',0];

_data = profileNameSpace getVariable ["Overthrow.save.001",""];
if(typename _data != "ARRAY") exitWith {
	server setVariable ["StartupType","NEW",true];
	hint "No save found, starting new game";
};
{
	_key = _x select 0;
	_val = _x select 1;
	_set = true;
	if(_key == "vehicles") then {
		_set = false;
		{
			_type = _x select 0;
			_pos = _x select 1;
			_dir = _x select 2;
			_stock = _x select 3;
			_owner = _x select 4;
			_veh = _type createVehicle _pos;
			_veh setDir _dir;
			clearWeaponCargoGlobal _veh;
			clearMagazineCargoGlobal _veh;
			clearBackpackCargoGlobal _veh;
			clearItemCargoGlobal _veh;	
			
			_veh setVariable ["owner",_owner];
			{
				_cls = _x select 0;
				_num = _x select 1;
				if(_cls in AIT_allWeapons) then {
					_veh addWeaponCargo _x;
				}else{
					if(_cls in AIT_allMagazines) then {
						_veh addMagazineCargo _x;
					}else{
						_veh addItemCargo _x;
					};
				};				
			}foreach(_stock);
		}foreach(_val);
	};
	
	if(_set) then {
		server setvariable [_key,_val,true];
	};	
}foreach(_data);
sleep 2; //let the variables propagate
server setVariable ["StartupType","LOAD",true];
hint "Persistent Save Loaded";