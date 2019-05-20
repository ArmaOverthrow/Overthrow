private ["_group","_population","_posTown","_vehs","_soldier","_vehtype","_pos","_wp","_numgroups","_attackpos","_count","_tgroup","_ao"];

params ["_objective","_strength"];
private _posTown = getMarkerPos _objective;

private _tskid = [resistance,[format["counter%1",_objective]],[format["NATO is sending forces to %1. This is our chance to capture it if we can hold the field.",_objective],format["Capture %1",_objective],format["counter%1",_objective]],_posTown,1,2,true,"Target",true] call BIS_fnc_taskCreate;

format["NATO is attacking %1",_objective] remoteExec ["OT_fnc_notifyMinor",0,false];

_fail = {
	params ["_tskid","_objective"];
	[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	_objective setMarkerType OT_flagMarker;

	_effect = "";
	if(_objective isEqualTo "The Fuel Depot") then {
		_effect = "(Vehicles are now cheaper)";
	};
	format["Resistance has captured %1 (+100 Influence) %2",_objective,_effect] remoteExec ["OT_fnc_notifyGood",0,false];
	100 remoteExec ["OT_fnc_influenceSilent",0,false];
	private _posTown = getMarkerPos _objective;
	_flag = _posTown nearobjects [OT_flag_NATO,500];
	if(count _flag > 0) then{
		deleteVehicle (_flag select 0);
	};
	_abandoned = server getVariable "NATOabandoned";
	_abandoned pushback _objective;
	server setVariable ["NATOabandoned",_abandoned,true];
	format["%1_restrict",_objective] setMarkerAlpha 0;
};

_success = {
	params ["_tskid","_objective"];
	//NATO has won
	[_tskid, "FAILED",true] spawn BIS_fnc_taskSetState;
	_active = false;
	_abandoned = server getVariable "NATOabandoned";
	_abandoned deleteAt (_abandoned find _objective);
	server setVariable ["NATOabandoned",_abandoned,true];
	server setVariable [format["garrison%1",_objective],round(8 + random 12),true];

};

[_posTown,_strength,_success,_fail,[_tskid,_objective],_objective] spawn OT_fnc_NATOQRF;
