params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", ["_shooter",objNull], ["_projectile",objNull]];

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

_shooter setCaptive false;
if !((vehicle _shooter) == _shooter) then {
    {
        _x setCaptive false;
    }foreach(crew vehicle _shooter);
};
