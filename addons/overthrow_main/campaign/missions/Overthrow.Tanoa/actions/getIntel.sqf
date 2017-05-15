if !(captive player) exitWith {"You cannot probe for intel while wanted" call OT_fnc_notifyMinor};
private _civ = OT_interactingWith;

if(player getVariable ["influence",0] > 0) then {
	player globalchat (["So, how's things?","Hey! How's it going","So any news?","What's new?","Hey what's up?","sup?"] call BIS_fnc_selectRandom);
	[player,_civ] call giveIntel;	
}else{
	"You need 1 influence to probe for intel" call OT_fnc_notifyMinor;
};
