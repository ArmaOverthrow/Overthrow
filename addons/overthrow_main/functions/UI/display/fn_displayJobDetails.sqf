params ["_ctrl","_index"];

disableSerialization;

private _id = _ctrl lbData _index;
private _job = [];
{
    _x params ["_jobid","_j"];
    if(_jobid isEqualTo _id) exitWith {_job = _j};
}foreach(spawner getVariable ["OT_activeJobs",[]]);

if(count _job > 0) then {
    _job params ["_info","_markerPos"];
    _info params ["_title","_desc"];
    private _remains = spawner getVariable [format["OT_jobRemain%1",_id],0];
    private _noexpire = spawner getVariable [format["OT_jobNoExpire%1",_id],false];

    private _remainTxt = "";
    if !(_noexpire) then {
        private _hrs = floor (_remains / 60);
        private _mins = _remains - (_hrs * 60);
        _remainTxt = format["Expires in %1 hrs %2 mins",_hrs,_mins];
    };

    _textctrl = (findDisplay 8000) displayCtrl 1100;

    _textctrl ctrlSetStructuredText parseText format["
    	<t align='center' size='1.1'>%1</t><br/><br/>
        <t align='center' size='0.8'>%2</t><br/>
    	<t align='center' size='0.8'>%3</t><br/>
    ",_title,_remainTxt,_desc];
};
