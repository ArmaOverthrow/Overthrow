
openMap true;

gotone = false;
onMapSingleClick "posTravel = _pos;gotone=true;";
hint "Click on a town";

waitUntil {sleep 0.1; (gotone) or (not visiblemap)};

if(not visiblemap) exitWith{};

while {visibleMap} do {
	sleep 0.1;
	if(gotone) then {
		_town =  posTravel call nearestTown;
		if!(isNil "_town") then {
			_pop = server getVariable format["population%1",_town];
			_stability = server getVariable format["stability%1",_town];
			_rep = player getVariable format["rep%1",_town];
			_numshops = count(server getVariable format["shopsin%1",_town]);
			if(_numshops == 0) then {
				_numshops = "None";
			};
			_plusmin = "";
			if(_rep > -1) then {
				_plusmin = "+";
			};
			_txt = format ["<t size='1.2' color='#222222'>%1</t><br/><t size='0.5' color='#222222'>Population: %2</t><br/><t size='0.5' color='#222222'>Stability: %3%4</t><br/><t size='0.5' color='#222222'>Your Standing: %5%6</t><br/><t size='0.5' color='#222222'>Shops: %7</t>",_town,[_pop, 1, 0, true] call CBA_fnc_formatNumber,_stability,"%",_plusmin,_rep,_numshops];
			[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
		};
		gotone = false;		
	};
};


