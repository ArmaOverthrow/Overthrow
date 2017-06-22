
openMap true;

gotone = false;
onMapSingleClick "posTravel = _pos;gotone=true;";
hint "Click on a location";

waitUntil {sleep 0.2; (gotone) or (not visiblemap)};

if(not visiblemap) exitWith{};

while {visibleMap} do {
	sleep 0.2;
	if(gotone) then {
		_loc =  posTravel call OT_fnc_nearestLocation;
		_loc params ["_name","_type","_data"];
		_txt = "";
		call {
			if (_type == "Town") exitWith {
				_town = _name;
				_pop = server getVariable format["population%1",_town];
				_stability = server getVariable format["stability%1",_town];
				_abandon = "Under NATO Control";
				if(_town in (server getVariable ["NATOabandoned",[]])) then {
					if(_stability < 50) then {
						_abandon = "Anarchy";
					}else{
						_abandon = "Under Resistance Control";
					};
				};
				_rep = [_town] call OT_fnc_standing;
				_plusmin = "";
				if(_rep > -1) then {
					_plusmin = "+";
				};
				_txt = format ["<t size='1.2' color='#222222'>%1</t><br/><t size='0.5' color='#222222'>Status: %7</t><br/><t size='0.5' color='#222222'>Population: %2</t><br/><t size='0.5' color='#222222'>Stability: %3%4</t><br/><t size='0.5' color='#222222'>Your Standing: %5%6</t>",_town,[_pop, 1, 0, true] call CBA_fnc_formatNumber,_stability,"%",_plusmin,_rep,_abandon];
			};
			if (_type in ["Objective","Radio Tower","Airport"]) exitWith {
				_abandon = "Under NATO Control";
				if(_name in (server getVariable ["NATOabandoned",[]])) then {
					_abandon = "Under Resistance Control";
				};
				_txt = format ["<t size='1.2' color='#222222'>%1</t><br/><t size='0.5' color='#222222'>Status: %2</t>",_name,_abandon];
			};
			if (_type == "Business") exitWith {
				_abandon = "Inactive";
				if(_name in (server getVariable ["GEURowned",[]])) then {
					_abandon = "Owned";
				};
				_txt = format ["<t size='1.2' color='#222222'>%1</t><br/><t size='0.5' color='#222222'>Status: %2</t>",_name,_abandon];
			};
		};
		gotone = false;
		[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
	};
};
