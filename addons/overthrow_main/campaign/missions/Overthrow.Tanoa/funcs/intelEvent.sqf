private _level = _this select 0;
private _pos = _this select 1;
private _script = {};
_notify = false;
_text = "";
_desc = "";
_icon = "scout";
if((count _this) > 2) then {
	_s = _this select 2;
	_all = _this;
	
	call {
		if((typename _s) == "STRING") exitWith {
			if((count _all) > 3) then {
				_notify = true;
				_text = _s;
				_desc = _all select 3;
				if((count _all) > 4) then {
					_icon = _all select 4;
				};
			}else{
				_script = compile preprocessFileLineNumbers _s;
			};
			
		};
		if((typename _s) == "CODE") exitWith {
			_script = _s;
		};
	};
};
_mylevel = [player,_pos] call intelLevel;
{
	_owner = _x select 0;	
	if(_owner == (getplayeruid player)) then {	
		_unit = _x select 2;
		if !(isNil "_unit") then {
			if((typename _unit == "OBJECT") and (alive _unit)) then {
				_lvl = [_unit,_pos] call intelLevel;
				if(_lvl > _mylevel) then {
					_mylevel = _lvl;
				};
			};
		};
	};
}foreach(server getVariable ["recruits",[]]);

if(_mylevel >= _level) then {
	
	if !(_notify) then {
		[] spawn _script;
	}else{
		_name = format["%1%2%3",_pos,_text,_desc];
		[player,_name,[_desc,"Intel: " + _text,_name],_pos,0,1,true,_icon,true] call BIS_fnc_taskCreate;
		_name spawn {
			sleep 1200;
			[_this, "SUCCEEDED",false] spawn BIS_fnc_taskSetState;
		};
	};
	
};