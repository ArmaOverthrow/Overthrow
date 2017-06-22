params ["_ctrl","_index"];

disableSerialization;

private _id = _ctrl lbData _index;
private _job = [];
{
    _x params ["_jobid","_j"];
    if(_jobid == _id) exitWith {_job = _j};
}foreach(spawner getVariable ["OT_activeJobs",[]]);

if(count _job > 0) then {
    _job params ["_info","_markerPos"];
    _info params ["_title","_desc"];
    _textctrl = (findDisplay 8000) displayCtrl 1100;

    _textctrl ctrlSetStructuredText parseText format["
    	<t align='center' size='1.1'>%1</t><br/><br/>
    	<t align='center' size='0.8'>%2</t><br/>
    ",_title,_desc];
};
