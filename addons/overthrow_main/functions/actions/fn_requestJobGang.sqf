
closeDialog 0;
private _gotjob = false;
private _jobdef = [];
private _activeJobs = spawner getVariable ["OT_activeJobIds",[]];
private _completed = server getVariable ["OT_completedJobIds",[]];
private _params = [];
private _id = "";
private _jobcode = {};
{
    _x params ["_name",["_target",""],"_condition","_code","_repeat"];
    _jobdef = _x;
    _jobcode = _code;
    call {
        if((toLower _target) isEqualTo "gang") exitWith {
            //get the closest base
            private _nearest = (getpos player) call OT_fnc_nearestObjective;
            _nearest params ["_loc","_base"];
            private _inSpawnDistance = _loc call OT_fnc_inSpawnDistance;
            _id = format["%1-%2",_name,_base];
            private _stability = server getVariable [format["stability%1",_loc call OT_fnc_nearestTown],100];
            if(([_inSpawnDistance,_base,_stability] call _condition) && !(_id in _completed) && !(_id in _activeJobs) && !(_id in OT_jobsOffered)) then {
                _gotjob = true;
                _params = [_base,_loc];
            }
        };
    };
    if(_gotjob) exitWith {};
}foreach([OT_allJobs,[],{random 100},"ASCEND",{_x select 7}] call BIS_fnc_SortBy);

if !(_gotjob) exitWith {
    [OT_interactingWith,player,["We don't have any more jobs at the moment."]] spawn OT_fnc_doConversation;
};

private _job = [_id,_params] call _jobcode;
OT_jobShowing = _job;
OT_jobShowingID = _id;
OT_jobsOffered pushback _id;
_job params ["_info","_markerPos","_setup","_fail","_success","_end","_jobparams"];

OT_jobShowingType = "gang";

createDialog "OT_dialog_joboffer";
disableSerialization;

_job params ["_info","_markerPos"];
_info params ["_title","_desc"];

_textctrl = (findDisplay 8000) displayCtrl 1199;

_textctrl ctrlSetStructuredText parseText format["
    <t align='center' size='1.1'>%1</t><br/><br/>
    <t align='center' size='0.8'>%2</t><br/>
",_title,_desc];

_job
