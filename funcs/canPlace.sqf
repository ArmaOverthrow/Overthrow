private ["_canplace","_base","_isbase","_owner","_typecls","_estate","_pos","_typecls"];

_pos = _this select 0;
_typecls = _this select 1;

_isbase = false;
_canplace = true;

if(_typecls != "Base") then {
	_base = _pos call nearestBase;
	if !(isNil "_base") then {
		if((_base select 0) distance _pos < 100) then {		
			_isbase = true;
		};
	};
}else{
	_base = _pos call nearestBase;
	if !(isNil "_base") then {
		if((_base select 0) distance _pos < 1500) then {
			_canplace = false;
		};
	};
};

if(!_canplace) exitWith {false};

if !(_isbase) then {
	//Building proximity check
	_estate = _pos call getNearestRealEstate;
	if(typename _estate == "ARRAY") then {
		_b = _estate select 0;
		if(_b call hasOwner) then {
			_owner = _b getVariable "owner";
			if(_owner != getplayeruid player) then {
				if(_typecls != "Camp" and _typecls != "Base") then {
					_canplace = false;
				};
			}else{
				if(_typecls == "Camp" or _typecls == "Base") then {
					_canplace = false;
				};
			};
		}else{		
			_canplace = false;
		};
	}else{
		if(_typecls != "Camp" and _typecls != "Base") then {
			_canplace = false;
		};
	};
};


if(_typecls == "Base") then {
	_town = _pos call nearestTown;
	_postown = server getVariable _town;
	_dist = 400;
	if(_town == "Georgetown") then {_dist = 950};
	if((_postown distance _pos) < _dist) then {_canplace = false};
};

_canplace