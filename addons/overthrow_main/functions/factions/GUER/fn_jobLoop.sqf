job_system_counter = job_system_counter + 1;
if !(job_system_counter < 12) then {
  job_system_counter = 0;
  {
    _x params ["_name",["_target",""],"_condition","_code","_repeat","_chance","_expires","_requestable"];
    if !(_requestable) then {
        private _jobdef = _x;
        private _completed = server getVariable ["OT_completedJobIds",[]];
        if(isNil "_completed") then {
          server setVariable ["OT_completedJobIds",[],false];
          _completed = server getVariable "OT_completedJobIds";
        };

        private _activeJobs = spawner getVariable ["OT_activeJobIds",[]];
        if((count _activeJobs) > 30) exitWith {};
        switch (toLower _target) do {
          case "global": {
            private _id = _name;
            if((random 100) < _chance) then {
              private _numAbandoned = count(server getVariable ["NATOabandoned",[]]);
              if(([_numAbandoned] call _condition) && !(_id in _completed) && !(_id in _activeJobs)) then {
                _activeJobs pushback _id;
                spawner setVariable ["OT_activeJobIds",_activeJobs,false];
                [_id,_jobdef,[]] call OT_fnc_assignJob;
              };
            };
          };
          case "natomission": {
            if((random 100) < _chance) then {
              private _schedule = server getVariable ["NATOschedule",[]];
              private _numAbandoned = count(server getVariable ["NATOabandoned",[]]);
              {
                  _x params ["_missionid","_mission","_p1","_p2"];
                  if !(isNil "_p2") then {
                      private _id = format["%1-%2",_name,_missionid];
                      if(([_mission,_numAbandoned] call _condition) && !(_id in _completed) && !(_id in _activeJobs)) then {
                        _activeJobs pushback _id;
                        spawner setVariable ["OT_activeJobIds",_activeJobs,false];
                        [_id,_jobdef,[_x]] call OT_fnc_assignJob;
                      };
                  };
              }forEach(_schedule);
            };
          };
          case "town": {
            if((random 100) < _chance) then {
              {
                private _id = format["%1-%2",_name,_x];
                private _stability = server getVariable [format["stability%1",_x],100];
                private _loc = server getVariable _x;
                private _inSpawnDistance = _loc call OT_fnc_inSpawnDistance;
                if(([_inSpawnDistance,_stability,_x] call _condition) && !(_id in _completed) && !(_id in _activeJobs)) exitWith {
                  [_id,_jobdef,[_x]] call OT_fnc_assignJob;
                };
              }foreach(OT_allTowns);
            };
          };
          case "base": {
            if((random 100) < _chance) then {
              {
                _x params ["_loc","_base"];
                private _id = format["%1-%2",_name,_base];

                private _inSpawnDistance = _loc call OT_fnc_inSpawnDistance;
                private _stability = server getVariable [format["stability%1",_loc call OT_fnc_nearestTown],100];
                if(([_inSpawnDistance,_base,_stability] call _condition) && !(_id in _completed) && !(_id in _activeJobs)) exitWith {
                  [_id,_jobdef,[_base,_loc]] call OT_fnc_assignJob;
                };
              }foreach(OT_objectiveData + OT_airportData);
            };
          };
          case "hvt": {
            if((random 100) < _chance) then {
              {
                private _done = false;
                _x params ["_loc","_base"];
                {
                	_x params ["_hvtid","_at","_status"];
                	if(_at == _base && _status == "") then {
                        private _id = format["%1-%2",_name,_hvtid];
                        private _inSpawnDistance = _loc call OT_fnc_inSpawnDistance;
                        if(([_inSpawnDistance,_base] call _condition) && !(_id in _completed) && !(_id in _activeJobs)) exitWith {
                          _done = true;
                          [_id,_jobdef,[_base,_hvtid]] call OT_fnc_assignJob;
                        };
                	};
                }foreach(OT_NATOhvts);
                if(_done) exitWith {};
              }foreach(OT_objectiveData + OT_airportData);
            };
          };
          case "faction": {
            if((random 100) < _chance) then {
              private _done = false;
              {
                _x params ["_cls"];
                private _pos = server getVariable [format["factionrep%1",_cls],[]];
                private _town = "";
                if(count _pos > 0) then {
                  private _standing = server getVariable [format["standing%1",_cls],0];
                  private _inSpawnDistance = _pos call OT_fnc_inSpawnDistance;
                  private _town = _pos call OT_fnc_nearestTown;
                  private _id = format["%1-%2",_name,_cls];
                  private _stability = server getVariable [format["stability%1",_town],100];
                  private _population = server getVariable [format["population%1",_town],50];
                  if(([_inSpawnDistance, _standing, _town, _stability, _population] call _condition) && !(_id in _completed) && !(_id in _activeJobs)) then {                    
                    [_id,_jobdef,[_cls]] call OT_fnc_assignJob;
                    _done = true;
                  };
                };
                if(_done) exitWith {};
              }foreach(OT_allFactions);
            };
          };
        };
    };
  }foreach(OT_allJobs);
};
