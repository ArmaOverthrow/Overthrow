OT_townSpawners = [
	compileFinal preProcessFileLineNumbers "spawners\civ.sqf",
	compileFinal preProcessFileLineNumbers "spawners\townGarrison.sqf",
	compileFinal preProcessFileLineNumbers "spawners\police.sqf",
	compileFinal preProcessFileLineNumbers "spawners\carDealer.sqf",
	compileFinal preProcessFileLineNumbers "spawners\criminal.sqf",
	compileFinal preProcessFileLineNumbers "spawners\gunDealer.sqf",
	compileFinal preProcessFileLineNumbers "spawners\ambientVehicles.sqf",
	compileFinal preProcessFileLineNumbers "spawners\shop.sqf",
	compileFinal preProcessFileLineNumbers "spawners\harbor.sqf"
];

{	
	private _pos = server getVariable _x;
	private _town = _x;
	[_pos,{			
			params ["_spawntown","_spawnid"];
			private _g = [];
			{					
				{
					_g pushback _x;
					if(typename _x == "GROUP") then {
						_x call distributeAILoad;
					};
				}foreach(_spawntown call _x);	
				sleep 0.2;
			}foreach(OT_townSpawners);
			spawner setvariable [_spawnid,_g,false];
	},[_town]] call OT_fnc_registerSpawner;
}foreach(OT_allTowns);