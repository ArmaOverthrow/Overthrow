private [];
_mode = "Clear";
_forecast = "";

_raintarget = rain;
_overtarget = overcast;
_fogTarget = fog;
_wavetarget = waves;

_count = 0;
_nextchange = 0;

while {true} do {
	_month = date select 1;
	
	//This is a south pacific climate (or thereabouts)
	//Dry season:
	_stormchance = 3;
	_rainchance = 8;
	_cloudychance = 20;

	if(_month < 5 or _month > 10) then {
		//Wet season
		_stormchance = 15;
		_rainchance = 20;
		_cloudychance = 50;
	};
	//Yeh thats about it..
	
	if(_count > _nextchange) then {
		_mode = _forecast;
		_forecast = "Clear";
		_count = 0;
		call {
			if(_mode == "Clear") exitWith {
				if((random 100) < _stormchance) exitWith {_forecast = "Storm"};
				if((random 100) < _rainchance) exitWith {_forecast = "Rain"};
				if((random 100) < _cloudychance) exitWith {_forecast = "Cloudy"};
			};
			if(_mode == "Storm") exitWith {				
				_forecast = "Rain";
			};
			if(_mode == "Rain") exitWith {				
				if((random 100) < _stormchance) exitWith {_forecast = "Storm"};
				if((random 100) > _rainchance) exitWith {_forecast = "Clear"};
				if((random 100) < 50) exitWith {_forecast = "Cloudy"};
			};
			if(_mode == "Cloudy") exitWith {				
				if((random 100) < _stormchance) exitWith {_forecast = "Storm"};
				if((random 100) < _rainchance) exitWith {_forecast = "Rain"};
				if((random 100) > _cloudychance) exitWith {_forecast = "Clear"};
			};
		};
		_nextchange = 240 + random 480;
		call {
			if(_forecast == "Storm") exitWith {
				_raintarget = 1;
				_overtarget = 1;
				_fogtarget = 0.005;
				_wavetarget = 1;
			};
			if(_forecast == "Rain") exitWith {
				_raintarget = 0.5;
				_overtarget = 1;
				_fogtarget = 0.002;
				_wavetarget = 0.5;
			};
			if(_forecast == "Cloudy") exitWith {
				_raintarget = 0;
				_overtarget = 0.7;
				_fogtarget = 0.001;
				_wavetarget = 0.2;
			};
			if(_forecast == "Clear") exitWith {
				_raintarget = 0;
				_overtarget = random 0.2;
				_fogtarget = 0;
				_wavetarget = random 0.2;
			};
		};
		server setVariable ["forecast",_forecast];
	};

	_rain = rain;
	_over = overcast;
	_fog = fog;
	_waves = waves;

	if(_raintarget > rain) then {_rain = _rain + 0.1};
	if(_raintarget < rain) then {_rain = _rain - 0.1};
	if(_overtarget > overcast) then {_over = _over + 0.3};
	if(_overtarget < overcast) then {_over = _over - 0.3};
	if(_fogTarget > fog) then {_fog = _fog + 0.0001};
	if(_fogTarget < fog) then {_fog = _fog - 0.0001};
	if(_wavetarget > waves) then {_waves = _waves + 0.1};
	if(_wavetarget < waves) then {_waves = _waves - 0.1};

	if(_rain > 1) then {_rain = 1};
	if(_rain < 0) then {_rain = 0};
	if(_over > 1) then {_over = 1};
	if(_over < 0) then {_over = 0};
	if(_fog < 0) then {_fog = 0};
	if(_waves > 1) then {_waves = 1};
	if(_waves < 0) then {_waves = 0};
	
	if(overcast < 0.7) then {
		_fog = 0;
		_rain = 0;		
	};
	
	0 setRain _rain;
	0 setOvercast _over;
	0 setFog _fog;
	0 setWaves _waves;
	_count = _count + 1;
	sleep 5;
	
};