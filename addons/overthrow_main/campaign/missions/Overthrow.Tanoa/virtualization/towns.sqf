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
			private _spawntown = _this;
			private _g = [];
			{					
				{
					_g pushback _x;
				}foreach(_spawntown call _x);									
			}foreach(OT_townSpawners);
			_g;
	},_town] call OT_fnc_registerSpawner;
}foreach(OT_allTowns);