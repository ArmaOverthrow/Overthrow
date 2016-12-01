if(count allunits > 300) exitWith {[]}; //dont spawn civs at all when under load.. just no point

params ["_town","_spawnid"];

private _count = 0;

private _groups = [];
			
private _pop = server getVariable format["population%1",_town];
private _stability = server getVariable format ["stability%1",_town];
private _posTown = server getVariable _town;

private _mSize = 350;
if(_town in OT_capitals) then {
	_mSize = 800;
};
private _numciv = 0;

if(_pop > 5) then {
	_numCiv = round(_pop * OT_spawnCivPercentage);
	if(_numCiv < 5) then {
		_numCiv = 5;
	};
}else {
	_numCiv = _pop;
};

if(_numCiv > 20) then {
	_numCiv = 20;
};

_hour = date select 3;

private _church = server getVariable [format["churchin%1",_town],[]];
if !(_church isEqualTo []) then {
	//spawn the priest
	_group = createGroup civilian;
	_group setBehaviour "SAFE";
	_groups pushback _group;
	_pos = [[[_church,20]]] call BIS_fnc_randomPos;
	_civ = _group createUnit [OT_civType_priest, _pos, [],0, "NONE"];
	[_civ] call initPriest;	
	sleep 0.1;
};

_count = 0;

_pergroup = 1;
if(_numCiv > 8) then {_pergroup = 2};
if(_numCiv > 16) then {_pergroup = 4};
_idd = 1;

while {_count < _numCiv} do {
	_groupcount = 0;
	_group = createGroup civilian;
	_group setBehaviour "SAFE";
	_groups pushback _group;
	_idd = _idd + 1;
		
	_home = [[[_posTown,_mSize]]] call BIS_fnc_randomPos;			
	
	if((_hour > 18 and _hour < 23) or (_hour < 9 and _hour > 5)) then {
		_home = getpos([_home,OT_allEnterableHouses] call getRandomBuilding);		
		//Put a light on at home
		_light = "#lightpoint" createVehicle [_home select 0,_home select 1,(_home select 2)+2.2];
		_light setLightBrightness 0.09;
		_light setLightAmbient[.9, .9, .6];
		_light setLightColor[.5, .5, .4];
		_groups pushback _light;
	};	
	
	while {(_groupcount < _pergroup) and (_count < _numCiv)} do {
		_pos = [[[_home,50]]] call BIS_fnc_randomPos;
		_civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
		_civ setBehaviour "SAFE";
		[_civ] call initCivilian;		
		_count = _count + 1;
		_groupcount = _groupcount + 1;	
		sleep 0.1;
	};
	_group spawn civilianGroup;
};	

spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + _groups,false];