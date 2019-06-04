params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", ["_shooter",objNull], ["_projectile",objNull]];
_unit enableAI "PATH";
if !(isNull _projectile) then {
    private _shotParents = getShotParents _projectile;
    _shooter = _shotParents select 1;
};
if(isNull _shooter) then {
    private _aceSource = _me getVariable ["ace_medical_lastDamageSource", objNull];
	if ((!isNull _aceSource) && {_aceSource != _unit}) then {
		_shooter = _aceSource;
	};
};
if ((typeOf _shooter) isKindOf "CAManBase") then {
    [_shooter,false] remoteExecCall ["setCaptive",_shooter];
    if !((vehicle _shooter) isEqualTo _shooter) then {
        {
            [_x,false] remoteExecCall ["setCaptive",_x];
        }foreach(crew vehicle _shooter);
    };
};
