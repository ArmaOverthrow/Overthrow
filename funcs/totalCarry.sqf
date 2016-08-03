
private ["_carry","_supply"];

_supply = getText(configfile >> "CfgWeapons" >> _this >> "ItemInfo" >> "containerClass");
_carry = 0;
if(_supply == "supply20") then {_carry = 20;};
if(_supply == "supply40") then {_carry = 40;};
if(_supply == "supply60") then {_carry = 60;};
if(_supply == "supply80") then {_carry = 80;};
if(_supply == "supply100") then {_carry = 100;};
if(_supply == "supply120") then {_carry = 120;};

_carry;