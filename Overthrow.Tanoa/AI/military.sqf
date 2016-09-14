_unit = _this select 0;

[_unit, (AIT_faces_western call BIS_fnc_selectRandom)] remoteExec ["setFace", 0, _unit];
[_unit, (AIT_voices_western call BIS_fnc_selectRandom)] remoteExec ["setSpeaker", 0, _unit];

_unit addEventHandler ["HandleDamage", {
	_me = _this select 0;
	_src = _this select 3;
	if(captive _src) then {
		if((vehicle _src) != _src or (_src call unitSeenNATO)) then {
			_src setCaptive false;				
		};		
	};	
}];