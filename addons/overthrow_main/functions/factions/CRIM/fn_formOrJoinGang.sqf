params ["_town"];

_gangs = OT_civilians getVariable [format["gangs%1",_town],[]];
_townpos = server getVariable _town;

if(count _gangs > 0) then {
    //make a gang larger (maybe)
    _gangid = _gangs select 0;
    _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
    if(_gang isEqualTo "") exitWith {
        //cleanup old gangs
        _gangs deleteAt (_gangs find _gangid);
        OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
    };
    if((count (_gang select 0)) < 15) then {
        if (selectRandom [1,2,3] isEqualTo 1) then {
          if(count _gang > 4) then {
              _civid = (OT_civilians getVariable ["autocivid",-1]) + 1;
              OT_civilians setVariable ["autocivid",_civid];
              (_gang select 0) pushback _civid;
              _vest = _gang select 3;
              _identity = call OT_fnc_randomLocalIdentity;
              _civ = [_identity,_gangid];
              OT_civilians setVariable [format["%1",_civid],_civ];

              if(_townpos call OT_fnc_inSpawnDistance) then {
                    _pos = (_gang select 4);
                    _group = spawner getVariable [format["gangspawn%1",_gangid],grpNull];
                    //Spawn new gang member at camp

                    private _pos = [_pos,random 360,10] call SHK_pos_fnc_pos;
                    private _civ = _group createUnit [OT_civType_local, _pos, [],0, "NONE"];
                    [_civ] joinSilent nil;
                    [_civ] joinSilent _group;

                    [_civ,_town,_vest] call OT_fnc_initCriminal;
                    [_civ,_identity] call OT_fnc_applyIdentity;
                    [_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];

                    _civ setVariable ["OT_gangid",_gangid,true];
                    _civ setVariable ["OT_civid",_civid,true];
                    _civ setBehaviour "SAFE";
                    _civ setVariable ["hometown",_town,true];

                    {
                    	_x addCuratorEditableObjects [[_civ]];
                    }foreach(allCurators);
              };
          }else{
              //remove old gang
              _gangs deleteAt (_gangs find _gangid);
              OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
          };
        };
    };
}else{
    //form a gang (if we can find a position)

    //get a camp position
    private _townpos = server getVariable _town;
    private _possible = spawner getVariable [format["gangpositions%1",_town],[]];
    if((count _possible) > 0) then {
        _home = selectRandom _possible;
        _home set [2,0];
        _civid = (OT_civilians getVariable ["autocivid",-1]) + 1;
        OT_civilians setVariable ["autocivid",_civid];

        _gangid = (OT_civilians getVariable ["autogangid",-1]) + 1;
        _vest = selectRandom OT_allProtectiveVests;
        OT_civilians setVariable [format["gang%1",_gangid],[[_civid],_civid,_town,_vest,_home],true];
        _gangs pushback _gangid;
        OT_civilians setVariable ["autogangid",_gangid,false];

        _identity = call OT_fnc_randomLocalIdentity;
        _civ = [_identity,_gangid];
        OT_civilians setVariable [format["%1",_civid],_civ];

        if(_townpos call OT_fnc_inSpawnDistance) then {
            //spawn a camp and gang

            _spawnid = spawner getvariable [format["townspawnid%1",_town],-1];
            _groups = spawner getvariable [_spawnid,[]];

            private _group = creategroup [opfor,true];

            spawner setVariable [format["gangspawn%1",_gangid],_group];

            //Spawn the camp
			_veh = createVehicle ["Campfire_burning_F",_home,[],0,"CAN_COLLIDE"];
			_groups pushback _veh;

			_numtents = 2 + round(random 3);
			_count = 0;

			while {_count < _numtents} do {
				//this code is in tents
				_d = random 360;
				_p = [_home,[2,9],_d] call SHK_pos_fnc_pos;
				_p = _p findEmptyPosition [1,40,"Land_TentDome_F"];
				_veh = createVehicle ["Land_TentDome_F",_p,[],0,"CAN_COLLIDE"];
				_veh setDir _d;
				_groups pushback _veh;
				_count = _count + 1;
			};

			//And the gang leader in his own group
			private _leaderGroup = creategroup [opfor,true];
			private _pos = [_home,10,random 360] call SHK_pos_fnc_pos;
			_civ = _leaderGroup createUnit [OT_CRIM_Unit, _pos, [],0, "NONE"];
			_civ setRank "COLONEL";
            _civ setVariable ["NOAI",true,false];
            _civ setBehaviour "SAFE";
			[_civ] joinSilent nil;
			[_civ] joinSilent _leaderGroup;
			_civ setVariable ["OT_gangid",_gangid,true];
			[_civ,_town] call OT_fnc_initCrimLeader;

			_wp = _leaderGroup addWaypoint [_home,0];
			_wp setWaypointType "GUARD";

			_groups pushback _leaderGroup;

			{
				_x addCuratorEditableObjects [[_civ]];
			}foreach(allCurators);

            private _civpos = [_home,random 360,10] call SHK_pos_fnc_pos;
            private _civ = _group createUnit [OT_civType_local, _civpos, [],0, "NONE"];
            [_civ] joinSilent nil;
            [_civ] joinSilent _group;

            [_civ,_town,_vest] call OT_fnc_initCriminal;
            [_civ,_identity] call OT_fnc_applyIdentity;
            [_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];

            _civ setVariable ["OT_gangid",_gangid,true];
            _civ setVariable ["OT_civid",_civid,true];
            _civ setBehaviour "SAFE";
            _civ setVariable ["hometown",_town,true];

            _group spawn OT_fnc_initCivilianGroup;

            {
                _x addCuratorEditableObjects [[_civ]];
            }foreach(allCurators);


            _groups pushback _group;
            spawner setvariable [_spawnid,_groups,false];
        };
    };
};
OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
