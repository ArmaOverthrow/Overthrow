if (!isServer) exitwith {};

private["_players","_playersalive","_town","_posPlayer","_posTown","_distance","_pop","_group","_count","_numCiv","_type"],;

AIT_spawnDistance = 1400;
AIT_civTypes_gunDealers = ["CUP_C_C_Profiteer_01","CUP_C_C_Profiteer_02","CUP_C_C_Profiteer_03","CUP_C_C_Profiteer_04"];
AIT_civTypes_locals = ["C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_man_sport_1_F_tanoan","C_man_sport_2_F_tanoan","C_man_sport_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan","C_Man_casual_6_F_tanoan","C_man_p_beggar_F_afro","C_Man_casual_1_F_afro","C_Man_casual_3_F_afro","C_man_sport_1_F_afro","C_man_sport_3_F_afro","C_Man_casual_4_F_afro","C_Man_casual_5_F_afro","C_Man_casual_6_F_afro","C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_shorts_1_F_afro"];
AIT_civTypes_expats = ["CUP_C_C_Citizen_02","CUP_C_C_Citizen_01","CUP_C_C_Citizen_04","CUP_C_C_Citizen_03","CUP_C_C_Rocker_01","CUP_C_C_Rocker_03","CUP_C_C_Rocker_02","CUP_C_C_Rocker_04","C_man_p_beggar_F","C_man_1","C_Man_casual_1_F","C_Man_casual_2_F","C_Man_casual_3_F","C_man_sport_1_F","C_man_sport_2_F","C_man_sport_3_F","C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_beggar_F_asia","C_Man_casual_1_F_asia","C_Man_casual_2_F_asia","C_Man_casual_3_F_asia","C_man_sport_1_F_asia","C_man_sport_2_F_asia","C_man_sport_3_F_asia","C_Man_casual_4_F_asia","C_Man_casual_5_F_asia","C_Man_casual_6_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia","C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia"];
AIT_civTypes_tourists = ["C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro","C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro"];
AIT_vehTypes_civ = ["CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Datsun","CUP_C_Datsun_4seat","CUP_C_Datsun_Covered","CUP_C_Datsun_Plain","CUP_C_Datsun_Tubeframe","CUP_C_LR_Transport_CTK","C_man_hunter_1_F"];

diag_log format["-- AGENTSPAWNER initialise ------------------------"];

null = [] spawn agentDeleter;
diag_log format["-- AGENTSPAWNER GC started..."];

waitUntil{not isNil "AIT_economyInitDone"};
sleep 1;
_tiempo = time;

if(!isServer) exitWith{};
private ["_towns","_townNames","_workerAgents","_sizeX","_sizeY","_name","_pos","_mSize","_pop"];

_townNames = [];
_workerAgents = [];

diag_log format["-- AGENTSPAWNER ready and waiting for players -----"];

while {true} do {
	if (time - _tiempo >= 0.5) then {sleep 0.1} else {sleep 0.5 - (time - _tiempo)};
	_tiempo = time;
	_players = playableUnits;
	
	if(!isMultiplayer) then
	{
		_players = [player];
	};
	
		
	{
		_town = _x;		
		_posTown = server getVariable _town;
						
		_playersalive = false;
		{
			if(isPlayer _x && alive _x) then {
				_posPlayer = getpos _x;
				if((_posTown distance _posPlayer) < AIT_spawnDistance) exitWith {_playersalive = true};
			}			
		}foreach(_players);
			
		if !(spawner getVariable _town) then {
			if(_playersalive) then {
				[_town] spawn spawnCiv;				
			};			
		}else{
			if(!_playersalive) then {
				spawner setVariable [_town,false,true];
			}
		}
	}foreach(AIT_allTowns);
};

