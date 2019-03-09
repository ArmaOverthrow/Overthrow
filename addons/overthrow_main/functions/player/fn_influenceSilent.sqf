if!(hasInterface) exitWith {};
private _totalrep = (player getVariable ["influence",0])+_this;
player setVariable ["influence",_totalrep,true];
