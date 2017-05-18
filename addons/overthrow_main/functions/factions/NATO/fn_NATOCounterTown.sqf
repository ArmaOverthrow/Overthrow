params ["_town","_strength"];

private _population = server getVariable format["population%1",_town];
private _posTown = server getVariable _town;

//Sneaky recon team first
_posTown spawn OT_fnc_NATOSupportRecon;
sleep (200 + (random 300));

private _tskid = [resistance,[format["attack%1",_town]],[format["NATO is attempting to recapture %1.",_town],format["Defend %1",_town],format["attack%1",_town]],_posTown,1,2,true,"Defend",true] call BIS_fnc_taskCreate;

_fail = {
	params ["_tskid","_town"];
	[_town,15] call OT_fnc_stability;
	[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
};

_success = {
	params ["_tskid","_town"];
	//NATO has won
	[_tskid, "FAILED",true] spawn BIS_fnc_taskSetState;
	[_town,15] call OT_fnc_stability; //Just to make sure they wont abandon it again right away
	_abandoned = server getVariable "NATOabandoned";
	_abandoned deleteAt (_abandoned find _town);
	server setVariable ["NATOabandoned",_abandoned,true];
};

[_posTown,_strength,_success,_fail,[_tskid,_town],_town] spawn OT_fnc_NATOQRF;
