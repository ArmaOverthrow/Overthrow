//Simple tweak of BIS' two functions built for Vehicle purposes by VCOM//

private ["_return", "_name"];
_name = _this select 0;

if ((typeName _name) isEqualTo "STRING") then
{
  _return = (configFile >> "cfgVehicles" >> _name);
}
else
{
  _return = (configFile >> "NonExistingClassDummy0005646526");
};
_return 