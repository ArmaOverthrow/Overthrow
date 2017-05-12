params ["_objective","_strength"];

private _posObjective = getMarkerPos _objective;

//Sneaky recon team first
_posObjective spawn OT_fnc_NATOSupportRecon;
sleep (200 + (random 300));

private _tskid = [resistance,[format["attack%1",_objective]],[format["NATO is attempting to recapture %1.",_objective],format["Defend %1",_objective],format["attack%1",_objective]],_posObjective,1,2,true,"Defend",true] call BIS_fnc_taskCreate;

_fail = {
	params ["_tskid","_objective"];
	[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
};

_success = {
	params ["_tskid","_objective"];
	//NATO has won
	[_tskid, "FAILED",true] spawn BIS_fnc_taskSetState;
	_abandoned = server getVariable "NATOabandoned";
	_abandoned deleteAt (_abandoned find _objective);
	_count = {(_x getVariable ["garrison",""]) == _objective} count (allunits);
	server setVariable [format["garrison%1",_objective],_count,true];
	_objective setMarkerType "flag_NATO";
	if(_objective == "Chemical Plant") then {
		server setVariable ["reschems",0,true];
	};
};
[_posObjective,_strength,_success,_fail,[_tskid,_objective],_objective] spawn OT_fnc_NATOQRF;
