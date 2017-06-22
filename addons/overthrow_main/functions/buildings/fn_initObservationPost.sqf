private _pos = _this select 0;
private _lospos = ATLtoASL ([_pos,[0,0,5.5]] call BIS_fnc_vectorAdd);
private _post = (_pos nearObjects ["Land_Cargo_Patrol_V4_F",10]) select 0;

private _group = creategroup resistance;
private _dir = ((getdir _post)+180);
_group setFormDir _dir;


private _posleft = [_pos,[[-1.5104,-0.4,4.34404], (getDir _post)-180] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd;
private _civ =  _group createUnit ["I_Spotter_F",_posleft,[],0,"NONE"];
[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _civ];
[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];
_civ disableAI "MOVE";
_civ disableAI "AUTOCOMBAT";
_civ setVariable ["NOAI",true,false];

_civ setDir (_dir+35);

removeAllWeapons _civ;
removeAllItems _civ;
removeAllAssignedItems _civ;
removeUniform _civ;
removeVest _civ;
removeBackpack _civ;
removeHeadgear _civ;
removeGoggles _civ;

_civ forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);
_civ addWeapon "Rangefinder";
_civ selectWeapon "Rangefinder";
_civ linkItem "ItemMap";
_civ linkItem "ItemCompass";
_civ linkItem "ItemWatch";
if(OT_hasTFAR) then {
	_civ linkItem "tf_anprc148jem";
}else{
	_civ linkItem "ItemRadio";
};

private _posright = [_pos,[[1.5104,-0.4,4.34404], (getDir _post)-180] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd;
_civ =  _group createUnit ["I_Spotter_F",_posright,[],0,"NONE"];
[_civ, (OT_faces_local call BIS_fnc_selectRandom)] remoteExec ["setAIFace", 0, _civ];
[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExec ["setAISpeaker", 0, _civ];
_civ disableAI "MOVE";
_civ disableAI "AUTOCOMBAT";
_civ setVariable ["NOAI",true,false];

_civ setDir (_dir-35);

removeAllWeapons _civ;
removeAllItems _civ;
removeAllAssignedItems _civ;
removeUniform _civ;
removeVest _civ;
removeBackpack _civ;
removeHeadgear _civ;
removeGoggles _civ;

_civ forceAddUniform (OT_clothes_guerilla call BIS_fnc_selectRandom);
_civ addWeapon "Rangefinder";
_civ selectWeapon "Rangefinder";
_civ linkItem "ItemMap";
_civ linkItem "ItemCompass";
_civ linkItem "ItemWatch";
_civ linkItem "ItemRadio";

while {true} do {
	sleep 5;
	if(count (units _group) == 0) exitWith {deleteGroup _group};

	private _spotDistance = OT_spawnDistance;
	_hour = date select 3;
	if(_hour > 19 or _hour < 6) then {_spotDistance = _spotDistance * 0.7};
	if(rain > 0) then {_spotDistance = _spotDistance * 0.8};
	if(overcast > 0.5) then {_spotDistance = _spotDistance * 0.9};
	_upos = "UP";
	{
		if(side _x == west or side _x == east) then {
			_lead = leader _x;
			if((_lead distance _lospos) < _spotDistance) then {
				if((_lead distance _lospos) < 300) then {
					_upos = "MIDDLE";
					_group reveal [_lead,4];
				}else{
					if(([_post, "VIEW"] checkVisibility [_lospos,getposasl _lead]) > 0) then {
						_group reveal [_lead,4];
					};
				};
			};
		};
		sleep 0.2;
	}foreach(allgroups);

	{
		_x setUnitPos _upos;
	}foreach(units _group);
};
