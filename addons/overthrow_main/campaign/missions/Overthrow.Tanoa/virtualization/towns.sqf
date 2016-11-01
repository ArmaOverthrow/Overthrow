private ["_pos"];

OT_townSpawners = [
	compileFinal preProcessFileLineNumbers "spawners\civ.sqf",
	compileFinal preProcessFileLineNumbers "spawners\townGarrison.sqf",
	compileFinal preProcessFileLineNumbers "spawners\carDealer.sqf",
	compileFinal preProcessFileLineNumbers "spawners\criminal.sqf",
	compileFinal preProcessFileLineNumbers "spawners\gunDealer.sqf",
	compileFinal preProcessFileLineNumbers "spawners\ambientVehicles.sqf",
	compileFinal preProcessFileLineNumbers "spawners\shop.sqf",
	compileFinal preProcessFileLineNumbers "spawners\distribution.sqf",
	compileFinal preProcessFileLineNumbers "spawners\harbor.sqf"
];

{	
	_pos = server getVariable _x;
	[_pos,{
		private ["_active","_groups","_town","_id"];
		_active = false;
		_id = _this select 0;
		_town = _this select 3;
		_groups = [];
		waitUntil{spawner getVariable _id};
		
		while{true} do {
			//Do any updates here that should happen whether spawned or not		
			//Main spawner
			if !(_active) then {
				if (spawner getVariable _id) then {
					_active = true;
					{
						_spawner = _x;
						[_groups,_town,_spawner] spawn {							
							private ["_g","_t","_s"];
							_g = _this select 0;
							_t = _this select 1;
							_s = _this select 2;
							sleep (random 2);
							{
								_g pushback _x;
								_grp = _x;								
							}foreach(_t call _s);
						};						
					}foreach(OT_townSpawners);
				}else{
					//NATO
					_need = server getVariable [format ["garrisonadd%1",_town],0];			
					if(_need > 1) then {		
						server setVariable[format ["garrisonadd%1",_town],_need-2,false];
						server setVariable[format ["garrison%1",_town],(server getVariable format["garrison%1",_town])+2,false];
					};
					
					//CRIM
					_newpos = server getVariable format["crimnew%1",_town];
					_addnum = server getVariable format["crimadd%1",_town];
					_current = server getVariable format["numcrims%1",_town];
					if((typename "_newpos") == "ARRAY") then {
						server setVariable [format["crimleader%1",_town],_newpos,false];	
						server setVariable [format["crimnew%1",_town],false,false];
						server setVariable [format["numcrims%1",_town],2+(random 4),false];
					};					
					server setVariable [format["crimadd%1",_town],0,false];
					server setVariable [format["crimnew%1",_town],false,false];									
				};
			}else{
				if (spawner getVariable _id) then {
					//Do updates here that should happen only while spawned
					
					//NATO
					_need = server getVariable [format ["garrisonadd%1",_town],0];			
					if(_need > 1) then {
						_town spawn reGarrisonTown;				
						server setVariable[format ["garrisonadd%1",_town],_need-2,false];
					};					
					
					//CRIM
					_newpos = server getVariable [format["crimnew%1",_town],false];
					_addnum = server getVariable [format["crimadd%1",_town],0];
					_current = server getVariable [format["numcrims%1",_town],0];
					if((typename _newpos) == "ARRAY") then {				
						server setVariable [format["crimleader%1",_town],_newpos,true];
						_new = [_newpos,_addnum,_town] call newleader;
						_groups pushback _new;
					}else{
						if(_addnum > 0) then {
							_new = [server getVariable _town,_addnum,_town] call sendCrims;
							_groups pushback _new;
							server setVariable [format["numcrims%1",_town],_current+_addnum,false];	
						};
					};
					server setVariable [format["crimnew%1",_town],false,false];
					_current = server getVariable [format["numcrims%1",_town],0];
					
					server setVariable [format["crimadd%1",_town],0,false];					
				}else{		
					_active = false;
					sleep 1;
					//Tear it all down
					{	
						if(typename _x == "GROUP") then {
							
							{		
								if !(_x call hasOwner) then {
									deleteVehicle _x;
								};	
							}foreach(units _x);
							deleteGroup _x;					
						}else{
							if !(_x call hasOwner) then {
								deleteVehicle _x;
							};	
						};			
						sleep 0.05;
					}foreach(_groups);
					_groups = [];
				};
			};
			sleep 0.5;
		};
	},_x] call OT_fnc_registerSpawner;	
}foreach(OT_allTowns);