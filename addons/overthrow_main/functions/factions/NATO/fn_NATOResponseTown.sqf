params ["_town","_strength"];
private _posTown = server getVariable _town;

private _tskid = [resistance,[format["assault%1",_town]],[format["NATO is assaulting %1.",_town],format["Battle for %1",_town],format["assault%1",_town]],_posTown,1,2,true,"Defend",true] call BIS_fnc_taskCreate;

private _success = {
	params ["_tskid","_town"];
	[_tskid, "FAILED",true] spawn BIS_fnc_taskSetState;
	[_town,50] call stability;
	private _abandoned = server getVariable "NATOabandoned";
	_abandoned deleteAt (_abandoned find _town);
	server setVariable ["NATOabandoned",_abandoned,true];
};

private _fail = {
	params ["_tskid","_town"];
	private _townpop = server getVariable format["population%1",_town];
	_townpop remoteExec ["influenceSilent",0,false];
	format["NATO has abandoned %1 (+%2 Influence)",_town,_townpop] remoteExec ["notify_good",0,false];
	[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
};

[_posTown,_strength,_success,_fail,[_tskid,_town]] spawn OT_fnc_NATOQRF;
