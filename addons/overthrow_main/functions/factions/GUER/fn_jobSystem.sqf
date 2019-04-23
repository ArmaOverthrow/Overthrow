
OT_allJobs = [];
{
    private _code = gettext (_x >> "condition");
    private _target = gettext (_x >> "target");
    private _script = gettext (_x >> "script");
    private _repeat = getnumber (_x >> "repeatable");
    private _chance = getnumber (_x >> "chance");

    OT_allJobs pushback [configName _x, _target, compileFinal _code, compileFinal preprocessFileLineNumbers _script, _repeat, _chance];
}foreach("true" configClasses ( configFile >> "CfgOverthrowMissions" ));

job_system_counter = 0;
["job_system","_counter%10 isEqualTo 0","call OT_fnc_jobLoop"] call OT_fnc_addActionLoop;
