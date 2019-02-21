if (VCOM_STATICGARRISON isEqualTo 0) exitWith {};
_Unit = _this;
  _Position = getPosATL _Unit;
  
  _weapon = nearestObject [_Position,"StaticWeapon"];
  if (isNull _weapon || {(_weapon distance _Unit) > 100}) exitWith {};
  
  _AssignedGunner = assignedGunner _weapon;
  if (isNull _AssignedGunner) then
  {
    _Unit doMove (getposATL _weapon);
    _Unit assignAsGunner _weapon;
    [_Unit] orderGetIn true;
    _Waiting = 0;
    while {_Waiting isEqualTo 0} do
    {
    sleep 1;
      if ((_Unit distance _Weapon) < 3) then {_Waiting = 1};
    };
    _Unit moveInGunner _weapon;
  };
