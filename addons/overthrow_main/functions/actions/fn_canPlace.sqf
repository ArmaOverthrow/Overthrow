params ["_pos","_typecls"];

private ["_canplace","_base","_isbase","_owner","_typecls","_estate"];
_isbase = false;
_canplace = true;

if(_typecls != "Base") then {
	private _ob = (getpos player) call OT_fnc_nearestLocation;
	if((_ob select 1) isEqualTo "Business") then {
		_obpos = (_ob select 2) select 0;
		_obname = (_ob select 0);

		if(_obpos distance _pos < 250) then {
			if(_obname in (server getVariable ["GEURowned",[]])) then {
				_isbase = true;
				_canplace = true;
			};
		};
	};
	if(_pos distance OT_factoryPos < 250) then {
		if("Factory" in (server getVariable ["GEURowned",[]])) then {
			_isbase = true;
			_canplace = true;
		};
	};
	_base = _pos call OT_fnc_nearestBase;
	if !(isNil "_base") then {
		if((_base select 0) distance _pos < 100) then {
			_isbase = true;
		};
	};
	if(!_isbase) then {
		_base = _pos call OT_fnc_nearestObjective;
		if !(isNil "_base") then {
			if(((_base select 1) in (server getvariable "NATOabandoned")) && ((_base select 0) distance _pos) < 100) then {
				_isbase = true;
			};
		};
	};
}else{
	_isbase = true;
	_base = _pos call OT_fnc_nearestBase;
	if !(isNil "_base") then {
		if((_base select 0) distance _pos < 300) then {
			_canplace = false;
		};
	};
	if(_canplace) then {
		_base = _pos call OT_fnc_nearestObjective;
		if((_base select 0) distance _pos < 300) then {
			_canplace = false;
		};
	};
};

if(!_canplace) exitWith {false};

if !(_isbase) then {
	//Building proximity check
	_estate = _pos call OT_fnc_nearestRealEstate;
	if(typename _estate isEqualTo "ARRAY") then {
		_b = _estate select 0;
		if(typeof _b isEqualTo OT_item_Tent) exitWith {_canplace = false};
		if(_b call OT_fnc_hasOwner) then {
			_owner = _b call OT_fnc_getOwner;
			if(_owner != getplayeruid player) then {
				if(_typecls != "Camp" && _typecls != "Base") then {
					_canplace = false;
				};
			}else{
				if(_typecls == "Camp"|| _typecls == "Base") then {
					_canplace = false;
				};
			};
		}else{
			_canplace = false;
		};
	}else{
		if(_typecls != "Camp" && _typecls != "Base") then {
			_canplace = false;
		};
	};
};


if(_typecls isEqualTo "Base") then {
	_town = _pos call OT_fnc_nearestTown;
	_postown = server getVariable _town;
	_dist = 200;
	if((_postown distance _pos) < _dist) then {_canplace = false};
};



_canplace
