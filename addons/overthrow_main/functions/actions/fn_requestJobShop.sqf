
closeDialog 0;
private _gotjob = false;
private _jobdef = [];
private _activeJobs = spawner getVariable ["OT_activeJobIds",[]];
private _completed = server getVariable ["OT_completedJobIds",[]];
private _params = [];
private _id = "";
private _jobcode = {};
private _expiry = 0;
{
    _x params ["_name",["_target",""],"_condition","_code","_repeat","_chance","_expires"];
    _jobdef = _x;
    _jobcode = _code;
    _expiry = _expires;
    call {
        if((toLower _target) isEqualTo "shop") exitWith {
            //get the town we're in
            private _nearest = (getpos player) call OT_fnc_nearestTown;
            private _loc = server getVariable _nearest;
            _id = format["%1-%2",_name,_nearest];
            private _stability = server getVariable [format["stability%1",_nearest],100];
            private _support = [_nearest] call OT_fnc_support;
            if(([_stability,_support] call _condition) && !(_id in _completed) && !(_id in _activeJobs) && !(_id in OT_jobsOffered)) then {
                _gotjob = true;
                _params = [_nearest];
            }
        };
    };
    if(_gotjob) exitWith {};
}foreach([OT_allJobs,[],{random 100},"ASCEND",{_x select 7}] call BIS_fnc_SortBy);

if !(_gotjob) exitWith {
    [OT_interactingWith,player,["I don't have any more jobs at the moment, I'm sorry. Maybe try a different town?"]] spawn OT_fnc_doConversation;
};

private _job = [_id,_params] call _jobcode;
OT_jobShowing = _job;
OT_jobShowingID = _id;
OT_jobShowingExpiry = _expiry;
OT_jobsOffered pushback _id;
if(count _job isEqualTo 0) exitWith {call OT_fnc_requestJobShop};
_job params ["_info","_markerPos","_setup","_fail","_success","_end","_jobparams"];

OT_jobShowingType = "shop";

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
