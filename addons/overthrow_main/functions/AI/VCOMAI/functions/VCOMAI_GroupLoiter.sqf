//This script will dictate how the loiter WP works for the AI
private ["_Unitleader", "_UnitArray"];

_Unitleader = _this select 0;
_Group = _this select 1;

//We need a list of actions that the AI can do for loitering.
_UnitArray = units _Group;
{
	if (_x isEqualTo (vehicle _x)) then
	{
		//Each AI will need to join their own group. The plan is to make them re-form when combat starts.
		[_x] joinsilent grpnull;
		_x setVariable ["VCOM_LOITERING",true];
		_x setVariable ["VCOM_LOITERINGACT",0];
		[_x,_UnitArray] spawn VCOMAI_LoiterAction;
	};
} foreach _UnitArray;


//This function will automatically regroup soldiers if they get more than 1 waypoint.
[_UnitArray,side _Unitleader] spawn VCOMAI_ReGroup;


