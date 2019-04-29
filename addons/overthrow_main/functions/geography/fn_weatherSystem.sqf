ot_weather_getWeather = {
	private _forecast = _this;
	private _wavetarget = 0;
	private _fogtarget = 0;
	private _overtarget = 0;
	private _raintarget = 0;
	private _lightning = 0;
	private _temp = 30;
	private _hour = date select 3;
	_this call {
		if(_this == "Storm") exitWith {
			_overtarget = 1;
			_fogtarget = 0.01;
			_wavetarget = 1;
			_raintarget = 0.8 + (random 0.2);
			_lightning = random 1;
		};
		if(_this == "Rain") exitWith {
			_overtarget = 0.7 + (random 0.1);
			_fogtarget = 0.002;
			_wavetarget = 0.3 + (random 0.4);
			_raintarget = 0.6 + (random 0.2);
			_lightning = 0;
		};
		if(_this == "Cloudy") exitWith {
			_overtarget = 0.3 + (random 0.7);
			_fogtarget = 0.001;
			_wavetarget = 0 + (random 0.2);
			_raintarget = 0;
			_lightning = 0;
		};
		if(_this == "Clear") exitWith {
			_overtarget = random 0.2;
			_fogtarget = 0;
			_wavetarget = random 0.2;
			_raintarget = 0;
			_lightning = 0;
		};
	};
	if(_hour > 8 && _hour < 18) then {
		_temp = 28 + round(random 5);
	}else{
		_temp = 16 + round(random 5);
		if(_hour isEqualTo 6) then {
			//morning fog
			_fogtarget = _fogtarget + 0.002;
		};
	};
	if(_overtarget > 0.5) then {
		_temp = _temp - 2;
	};
	if(_raintarget > 0.5) then {
		_temp = _temp - 3;
	};
	[_overtarget,_fogtarget,_wavetarget,_raintarget,_lightning,_temp]
};

ot_weather_change_forecast = "Clear";

if((server getVariable "StartupType") == "NEW" || (server getVariable ["weatherversion",0]) < 1) then {
	server setVariable ["weatherversion",1,false];

	_mode = ["Clear","Cloudy"] call BIS_fnc_selectRandom;
	_weather = _mode call ot_weather_getWeather;
	_newOvercast = _weather select 0;

	skiptime -24;
	86400 setOvercast _newOvercast;
	86400 setFog 0;
	86400 setWaves (_weather select 2);
	86400 setLightnings (_weather select 4);
	86400 setWindForce (_newOvercast * 0.3);
	86400 setGusts _newOvercast;
	86400 setRain (_weather select 3);
	86400 setWindDir (85 + random 10); //https://en.wikipedia.org/wiki/Trade_winds
	skiptime 24;

	simulWeatherSync;
	(_weather select 3) spawn {
		sleep 2;
		10 setRain _this;
	};

	server setVariable ["temperature",(_weather select 5),true];
	server setVariable ["forecast",_mode,true];
	ot_weather_change_forecast = _mode;
	_count = 0;
}else{
	ot_weather_change_forecast = server getVariable ["forecast","Clear"];
	_weather = ot_weather_change_forecast call ot_weather_getWeather;
	_newOvercast = _weather select 0;
	skiptime -24;
	86400 setOvercast _newOvercast;
	86400 setFog 0;
	86400 setWaves (_weather select 2);
	86400 setLightnings (_weather select 4);
	86400 setRain (_weather select 3);
	86400 setWindForce (_newOvercast * 0.3);
	86400 setGusts _newOvercast;
	86400 setWindDir (85 + random 10); //https://en.wikipedia.org/wiki/Trade_winds
	skiptime 24;

	(_weather select 3) spawn {
		sleep 2;
		10 setRain _this;
	};

	_date = server getVariable ["timedate",OT_startDate];
	setdate _date;
	0 setfog 0; //Tanoa fog wtf
	forceWeatherChange;
	simulWeatherSync;
};

OT_SystemInitDone = true;
publicVariable "OT_SystemInitDone";

ot_weather_change_time = 350 + (random 600);

//Fog killer
[{0 setfog 0;}, [], 100] call CBA_fnc_waitAndExecute;

["unique_ID","(ot_weather_change_time - time) <= 0","
private _month = date select 1;

private _stormchance = 1;
private _rainchance = 2;
private _cloudychance = 4;

if(_month < 5 || _month > 10) then {
	_stormchance = 2;
	_rainchance = 5;
	_cloudychance = 20;
};

private _mode = ot_weather_change_forecast;
ot_weather_change_forecast = ""Clear"";
_count = 0;
[_mode, _stormchance, _cloudychance, _rainchance] call {
	params [""_mode"", ""_stormchance"", ""_cloudychance"", ""_rainchance""];
	if(_mode isEqualTo ""Clear"") exitWith {
		if((random 100) < _cloudychance) exitWith {ot_weather_change_forecast = ""Cloudy""};
	};
	if(_mode isEqualTo ""Storm"") exitWith {
		ot_weather_change_forecast = ""Rain"";
	};
	if(_mode isEqualTo ""Rain"") exitWith {
		if((random 100) < _stormchance) exitWith {ot_weather_change_forecast = ""Storm""};
		if((random 100) < 50) exitWith {ot_weather_change_forecast = ""Cloudy""};
	};
	if(_mode isEqualTo ""Cloudy"") exitWith {
		if((random 100) < _rainchance) exitWith {ot_weather_change_forecast = ""Rain""};
		if((random 100) > _cloudychance) exitWith {ot_weather_change_forecast = ""Clear""};
	};
};
_weather = ot_weather_change_forecast call ot_weather_getWeather;

_newOvercast = (_weather select 0);
120 setOvercast _newOvercast;
120 setFog 0;
120 setWaves (_weather select 2);
120 setRain (_weather select 3);
120 setLightnings (_weather select 4);
120 setWindForce (_newOvercast * 0.3);
120 setGusts _newOvercast;
120 setWindDir (85 + random 10);

server setVariable [""temperature"",(_weather select 5),true];
ot_weather_change_time = time + (350 + (random 600));
"] call OT_fnc_addActionLoop;
