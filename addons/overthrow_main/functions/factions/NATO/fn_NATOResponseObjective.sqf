private ["_group","_population","_posTown","_vehs","_soldier","_vehtype","_pos","_wp","_numgroups","_attackpos","_count","_tgroup","_ao"];

private _objective = _this;
private _posTown = getMarkerPos _objective;

private _tskid = [resistance,[format["counter%1",_objective]],[format["NATO is sending forces to %1. This is our chance to capture it if we can hold the field.",_objective],format["Capture %1",_objective],format["counter%1",_objective]],_posTown,1,2,true,"Target",true] call BIS_fnc_taskCreate;

_fail = {
	params ["_tskid","_objective"];
	[_tskid, "SUCCEEDED",true] spawn BIS_fnc_taskSetState;
	_objective setMarkerType "flag_Tanoa";
	_o = "";
	if(_objective in OT_needsThe) then {
		_o = "The ";
	};
	_effect = "";
	if(_objective == "fuel depot") then {
		_efect = "(Vehicles are now cheaper)";
	};
	format["Resistance has captured %1%2 (+100 Influence) %3",_o,_objective,_effect] remoteExec ["notify_good",0,false];
	100 remoteExec ["influenceSilent",0,false];
	private _posTown = getMarkerPos _objective;
	_flag = _posTown nearobjects [OT_flag_NATO,500];
	if(count _flag > 0) then{
		deleteVehicle (_flag select 0);
	};
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

private _base = 150;
if(_objective in OT_allAirports) then {_base = 300};

private _strength = _base + (count(server getvariable ["NATOabandoned",[]]) * 20);

[_posTown,_strength,_success,_fail,[_tskid,_objective]] spawn OT_fnc_NATOQRF;
