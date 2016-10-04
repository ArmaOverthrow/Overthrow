_me = _this select 0;
_myuid = getPlayerUID _me;	
{
	_uid = _x getVariable ["player_uid",""];
	if(_uid == _myuid and _x != _me) then {
		deleteVehicle _x;
	}
}foreach(allDeadMen);