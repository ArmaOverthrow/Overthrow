params ["_civid","_town"];

private _civ = OT_civilians getVariable [format["%1",_civid],[]];

_civ params ["_identity","_hasjob","_cash","_superior"];

_gangs = OT_civilians getVariable [format["gangs%1",_town],[]];
_townpos = server getVariable _town;

if(count _gangs > 0) then {
    //join a gang (maybe)
    if((random 100) > 98) then {
        _gangid = _gangs select 0;
        _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
        if(count _gang > 0) then {
            (_gang select 0) pushback _civid;
            _vest = _gang select 3;
            _civ set [3,(_gang select 0) select 0];
            if(_townpos call OT_fnc_inSpawnDistance) then {
                _unit = OT_civilians getVariable [format["spawn%1",_civid],objNull];
                if(!isNull _unit and alive _unit) then {
                    _group = OT_civilians getVariable [format["gangspawn%1",_gangid],grpNull];
                    _unit setVariable ["OT_gangid",_gangid,true];
                    if(!isNull _group) then {
                        [_unit] joinSilent nil;
                        [_unit] joinSilent _group;
                        [_unit,_town,_vest] call OT_fnc_initCriminal;
                    };
                };
            };
        }else{
            _gangs deleteAt (_gangs find _gangid);
            OT_civilians setVariable [format["gangs%1",_x],_gangs,true];
        };
    };
}else{
    //form a gang (definitely)
    _id = (OT_civilians getVariable ["autogangid",-1]) + 1;
    _vest = selectRandom OT_allProtectiveVests;
    OT_civilians setVariable [format["gang%1",_id],[[_civid],0,_town,_vest],true];
    _gangs pushback _id;
    OT_civilians setVariable ["autogangid",_id,false];
    _civ set [3,_civid];

    if(_townpos call OT_fnc_inSpawnDistance) then {
        _unit = OT_civilians getVariable [format["spawn%1",_civid],objNull];
        if(!isNull _unit and alive _unit and !(_unit call OT_fnc_unitSeenPlayer)) then {
            _group = creategroup opfor;
            _spawnid = spawner getVariable [format["townspawnid%1",_town],"spawn0"];
            spawner setvariable [_spawnid,(spawner getvariable [_spawnid,[]]) + [_group],false];
            _group setVariable ["OT_gangid",_id,true];
            OT_civilians setVariable [format["gangspawn%1",_id],_group,false];

            [_unit] joinSilent nil;
            [_unit] joinSilent _group;
            [_unit,_town,_vest] call OT_fnc_initCriminal;
        };
    };
};
OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
