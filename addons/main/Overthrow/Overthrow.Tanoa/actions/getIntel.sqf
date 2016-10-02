if !(captive player) exitWith {"You cannot ask for intel while wanted" call notify_minor};
_civ = player getvariable "hiringciv";

if(player getVariable ["influence",0] > 0) then {
	[player,_civ] call giveIntel;
	-1 call influence;
}else{
	"You need 1 influence to get intel from a civilian" call notify_minor;
};

