private ["_NotDriver", "_Unit", "_Vehicle", "_ActualDriver"];
//Created on 8/15/14
// Modified on : 8/29/14 - Fixed passenger getting a nill for _NotDriver
_Unit = _this;

_NotDriver = false;

_Vehicle = (vehicle _Unit);

_ActualDriver = driver _Vehicle;

if (_Unit isEqualTo _ActualDriver) then 
{
  
  _NotDriver = true;
  
};

_NotDriver
