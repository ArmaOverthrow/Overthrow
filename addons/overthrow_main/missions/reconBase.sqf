params ["_jobid","_jobparams"];
_jobparams params ["_base","_markerPos"];

private _count = 0;
_params = [_base,_count];
private _effect = "<t size='0.9'>Reward: $500 to player closest to base</t>";

//Build a mission description and title
private _description = format["Get information on the NATO forces and vehicles garrisoned at %1. A pair of Binoculars or Rangefinder may come in handy. Be careful not to get too close as NATO bases are restricted areas.<br/><br/>%2",_base,_effect];
private _title = format["Recon of %1",_base];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //No setup required for this mission
        true
    },
    {
        //Fail check...
        false
    },
    {
        //Success Check
        params ["_base","_oldcount"];

        private _closestPlayer = nil;
        private _loc = server getVariable _base;
        private _players = [];
        {
            if(isPlayer _x && alive _x) then {
                _players pushback _x;
            };
        }foreach(_loc nearEntities ["Man",OT_spawnDistance]);
        _players = _players apply {[_x distance _loc, _x]};
        _players sort true;

        if(count _players == 0) exitWith {false};

        _closestPlayer = (_players select 0) select 1;

        private _spawnid = spawner getVariable [format["spawnid%1",_base],""];
        if(_spawnid isEqualTo "") exitWith {false}; //Base has not been spawned yet
        //Get groups in spawn
        _groups = spawner getVariable [_spawnid,[]];
        if(count _groups == 0) exitWith {false}; //Base is empty/not spawned atm

        _count = 0;
        _missedOne = false;
        {
            private _group = _x;
            if ((typename _group isEqualTo "GROUP") && !isNull (leader _group)) then {
                if((vehicle leader _group) == leader _group) then {
                    if((resistance knowsAbout (leader _x)) < 1.4) then {_missedOne = true} else {_count = _count + (count units _group)}; //does the resistance know about the leader of this group?
                }else{
                    if((_closestPlayer knowsAbout (vehicle leader _group)) < 1.4) then {_missedOne = true} else {_count = _count + 1}; //does the resistance know about this vehicle?
                };
            };
        }foreach(_groups);

        if(_oldcount < _count) then {
            format["%2 units spotted at %1",_base,_count] remoteExec ["systemChat",_players select 0,false];
        };

        _this set [1,_count];

        !_missedOne
    },
    {
        params ["_base","_count","_wassuccess"];

        //If mission was a success
        if(_wassuccess) then {
            private _loc = server getVariable _base;
            private _players = [];
            {
                if(isPlayer _x && alive _x) then {
                    _players pushback _x;
                };
            }foreach(_loc nearEntities ["Man",OT_spawnDistance]);
            _players = _players apply {[_x distance _loc, _x]};
            _players sort true;

            if((count _players) > 0) then {
                [500] remoteExec ["OT_fnc_money",(_players select 0) select 1,false];
            };

            //Broadcast full recon report
            private _report = format["Recon report (%1)<br/>",_base];
            _report = _report + format["%1 x Soldiers<br/>",server getVariable [format["garrison%1",_base],0]];
            private _allVehs = (server getVariable [format["vehgarrison%1",_base],[]]) + (server getVariable [format["airgarrison%1",_base],[]]);
            {
                _x params ["_cls","_num"];
                _report = _report + format["%1 x %2<br/>",_num,_cls call OT_fnc_vehicleGetName];
            }foreach(_allVehs call BIS_fnc_consolidateArray);
            _report remoteExec ["OT_fnc_notifyMinor",0,false];
        };
    },
    _params
];
