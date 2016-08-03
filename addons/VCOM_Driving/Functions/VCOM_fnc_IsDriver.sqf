private ["_NotDriver", "_Unit", "_Vehicle", "_ActualDriver"];
//Created on 8/15/14
// Modified on : 8/29/14 - Fixed passenger getting a nill for _NotDriver
_Unit = _this select 0;

_NotDriver = 0;

_Vehicle = (vehicle _Unit);

_ActualDriver = driver _Vehicle;

if (_Unit isEqualTo _ActualDriver) then 
{
  
  _NotDriver = 1;
  
};

_NotDriver
