	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2013-2015 Nicolas BOITEUX

	Real weather for MP GAMES v 1.4
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

	private ["_lastrain", "_rain", "_fog", "_mintime", "_maxtime", "_overcast", "_realtime", "_random","_startingdate", "_startingweather", "_timeforecast", "_daytimeratio", "_nighttimeratio", "_timesync", "_wind"];
	
	// Real time vs fast time
	// true: Real time is more realistic weather conditions change slowly (ideal for persistent game)
	// false: fast time give more different weather conditions (ideal for non persistent game) 
	_realtime = true;

	// Random time before new forecast
	// true: forecast happens bewteen mintime and maxtime
	// false: forecast happens at mintime
	_random = true;

	// Min time seconds (real time) before a new weather forecast
	_mintime = 600;

	// Max time seconds (real time) before a new weather forecast
	_maxtime = 1200;

	// If Fastime is on
	// Ratio 1 real time second for x game time seconds
	// Default: 1 real second = 6 second in game
	_daytimeratio = 6;
	_nighttimeratio = 24;

	// send sync data across the network each xxx seconds
	// 60 real seconds by default is a good value
	// shortest time do not improve weather sync
	_timesync = 60;

	// Mission starting date is 25/09/2013 at 12:00
	_startingdate = [2015, 07, 01, 08, 30];

	// Mission starting weather "CLEAR|CLOUDY|RAIN";
	_startingweather = ["CLEAR"] call BIS_fnc_selectRandom;

	/////////////////////////////////////////////////////////////////
	// Do not edit below
	/////////////////////////////////////////////////////////////////
	
	if(_mintime > _maxtime) exitwith {hint format["Real weather: Max time: %1 can no be higher than Min time: %2", _maxtime, _mintime];};
	_timeforecast = _mintime;

	setdate _startingdate;
	switch(toUpper(_startingweather)) do {
		case "CLEAR": {
			wcweather = [0, 0, 0, [random 3, random 3, true], date];
		};
		
		case "CLOUDY": {
			wcweather = [0, 0, 0.02, [random 3, random 3, true], date];
		};
		
		case "RAIN": {
			wcweather = [1, 0, 0.03, [random 3, random 3, true], date];
		};

		default {
			// clear
			wcweather = [0, 0, 0, [random 3, random 3, true], date];
			diag_log "Real weather: wrong starting weather";
		};
	};

	// add handler
	if (local player) then {
		wcweatherstart = true;
		"wcweather" addPublicVariableEventHandler {
			// first JIP synchronization
			if(wcweatherstart) then {
				wcweatherstart = false;
				skipTime -24;
				86400 setRain (wcweather select 0);
				86400 setfog 0;
				86400 setOvercast (wcweather select 2);
				skipTime 24;
				simulweatherSync;
				setwind (wcweather select 3);
				setdate (wcweather select 4);
			}else{
				wcweather = _this select 1;
				60 setRain (wcweather select 0);
				60 setfog 0;
				60 setOvercast (wcweather select 2);
				setwind (wcweather select 3);
				setdate (wcweather select 4);
			};
		};
	};

	// SERVER SIDE SCRIPT
	if (!isServer) exitWith{};

	// apply weather
	skipTime -24;
	86400 setRain (wcweather select 0);
	86400 setfog 0;
	86400 setOvercast (wcweather select 2);
	skipTime 24;
	simulweatherSync;
	setwind (wcweather select 3);
	setdate (wcweather select 4);

	// sync server & client weather & time
	[_realtime, _timesync, _daytimeratio, _nighttimeratio] spawn {
		private["_realtime", "_timesync", "_daytimeratio", "_nighttimeratio"];
		
		_realtime = _this select 0;
		_timesync = _this select 1;
		_daytimeratio = _this select 2;
		_nighttimeratio =  _this select 3;

		while { true } do {
			wcweather set [4, date];
			publicvariable "wcweather";
			if(!_realtime) then { 
				if((date select 3 > 16) or (date select 3 <6)) then {
					setTimeMultiplier _nighttimeratio;
				} else {
					setTimeMultiplier _daytimeratio;
				};
			};
			sleep _timesync;
		};
	};

	_lastrain = 0;
	_rain = 0;
	_overcast = 0;
	while {true} do {
		_overcast = random 1;
		if(_overcast > 0.70) then {
			_rain = random 1;
		} else {
			_rain = 0;
		};
		if((date select 3 > 2) and (date select 3 <8)) then {
			if(random 1 > 0.75) then {
				_fog = 0.02 + (random 0.03);
			} else {
				_fog = 0.05 + (random 0.02);
			};
		} else {
			if((_lastrain > 0.6) and (_rain < 0.2)) then {
				_fog = random 0.02;
			} else {
				_fog = 0;
			};
		};
		if(random 1 > 0.95) then {
			_wind = [random 7, random 7, true];
		} else {
			_wind = [random 3, random 3, true];
		};
		_lastrain = _rain;
		
		wcweather = [_rain, _fog, _overcast, _wind, date];
		60 setRain (wcweather select 0);
		60 setfog 0;
		60 setOvercast (wcweather select 2);
		setwind (wcweather select 3);
		if(_random) then {
			_timeforecast = _mintime + (random (_maxtime - _mintime));
		};
		sleep _timeforecast;
	};