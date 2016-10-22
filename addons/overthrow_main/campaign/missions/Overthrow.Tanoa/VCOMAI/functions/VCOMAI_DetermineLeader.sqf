//Created on 8/14/14
// Modified on : 8/1/15 - 8/3/16: Added in check for unit and distance from leader.

//This function is to determine if this unit is the group leader or not. And to define if unit is sub-leader or not.
_Unit = _this;

_GroupLeader = leader (group (vehicle _Unit)); 
if (_GroupLeader isEqualTo _Unit) then {_VCOM_GroupLeader = true;} else {_VCOM_GroupLeader = false;};

_SubLeader = isFormationLeader _Unit;
if (_SubLeader) then {_VCOM_SubLeader = true;} else {_VCOM_SubLeader = false;};


_Leader = _VCOM_GroupLeader;
if (isNil "_Leader") exitWith {};
_SubLeader = _VCOM_SubLeader;
_CheckArray = [_Leader,_SubLeader];

//If leader is far away, lets regroup! YAY!
if (_GroupLeader distance _Unit > 120) then {_Unit forcespeed -1;_Unit domove (getpos _GroupLeader);};

_CheckArray