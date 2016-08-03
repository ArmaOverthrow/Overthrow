

_unit = _this select 0;
_cls = _this select 1;

_mass = getNumber(configfile >> "CfgWeapons" >> _cls >> "ItemInfo" >> "Mass");
_totalfit = 0;
_uniform = uniform _unit;
_vest = vest _unit;
_backpack = backpack _unit;

if(_uniform != "") then {
	_totalfit = _totalfit + ((1.0 - (loadUniform _unit)) * (_uniform call totalCarry));
};
if(_vest != "") then {
	_totalfit = _totalfit + ((1.0 - (loadVest _unit)) * (_vest call totalCarry));
};
if(_backpack != "") then {
	_totalfit = _totalfit + ((1.0 - (loadBackpack _unit)) * (_backpack call totalCarry));
};
_ok = true;
if(_totalfit < _mass) then {_ok = false;};

_ok