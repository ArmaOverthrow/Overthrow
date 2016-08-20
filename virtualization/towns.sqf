private ["_pos"];

AIT_townSpawners = [
	compileFinal preProcessFileLineNumbers "spawners\civ.sqf",
	compileFinal preProcessFileLineNumbers "spawners\townGarrison.sqf",
	compileFinal preProcessFileLineNumbers "spawners\carDealer.sqf",
	compileFinal preProcessFileLineNumbers "spawners\criminal.sqf",
	compileFinal preProcessFileLineNumbers "spawners\gunDealer.sqf",
	compileFinal preProcessFileLineNumbers "spawners\ambientVehicles.sqf"
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
						[_groups,_town call _x] call BIS_fnc_arrayPushStack;
					}foreach(AIT_townSpawners);
				}else{
					//NATO
					_need = server getVariable [format ["garrisonadd%1",_town],0];			
					if(_need > 1) then {		
						server setVariable[format ["garrisonadd%1",_town],_need-2,false];
						server setVariable[format ["garrison%1",_town],_numNATO+2,false];
					};
					
					//CRIM
					_newpos = server getVariable format["crimnew%1",_town];
					_addnum = server getVariable format["crimadd%1",_town];
					_current = server getVariable format["numcrims%1",_town];
					if((typename "_newpos") == "ARRAY") then {
						server setVariable [format["crimleader%1",_town],_newpos,false];	
						server setVariable [format["crimnew%1",_town],false,false];
					};
					server setVariable [format["numcrims%1",_town],_current+_addnum,false];	
					server setVariable [format["crimadd%1",_town],0,false];						
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
					if((typename _newpos) == "ARRAY") then {				
						server setVariable [format["crimleader%1",_town],_newpos,true];
						_new = [_newpos,_addnum,_town] call newleader;
						[_soldiers,_new] call BIS_fnc_arrayPushStack;
						_groups pushback group(_new select 0);
					}else{
						if(_addnum > 0) then {
							_new = [_addnum,_town] call sendCrims;
							[_soldiers,_new] call BIS_fnc_arrayPushStack;
							_groups pushback group(_new select 0);
						};
					};
					server setVariable [format["crimnew%1",_town],false,false];
					_current = server getVariable [format["numcrims%1",_town],0];
					server setVariable [format["numcrims%1",_town],_current+_addnum,false];	
					server setVariable [format["crimadd%1",_town],0,false];					
				}else{		
					_active = false;
					//Tear it all down
					{	
						if(typename _x == "GROUP") then {
							{
								sleep 0.05;				
								if !(_x call hasOwner) then {
									deleteVehicle _x;
								};	
							}foreach(units _x);
							deleteGroup _x;					
						}else{
							deleteVehicle _x;
						};		
						sleep 0.05;
					}foreach(_groups);
					_groups = [];
				};
			};
		};
	},_x] call AIT_fnc_registerSpawner;	
}foreach(AIT_allTowns);