crim_counter = crim_counter + 1;
if !(crim_counter < 12) then {
    crim_counter = 0;
    {
        _nogang = spawner getVariable [format["nogang%1",_x],0];
        _pop = server getVariable [format["population%1",_x],0];
        _stability = server getVariable [format["stability%1",_x],0];
        _garrison = (server getVariable [format["police%1",_x],0]) + (server getVariable [format["garrison%1",_x],0]);
        _town = _x;
        _pos = server getVariable _x;

        if(time > _nogang) then {
            spawner setVariable [format["nogang%1",_town],0,false];
            //calculate the chance of a gang forming or increasing in size
            if(_stability < 50) then {
                _chance = (50 - _stability);
                if(_garrison < 4) then {_chance = _chance + 25};
                if !(_town in (server getVariable ["NATOabandoned",[]])) then {_chance = 10}; //Much lower chance of gang activity under NATO rule
                if((random 250) < _chance) then {
                    [_town] call OT_fnc_formOrJoinGang;
                };
            };
        };

        private _gangs = OT_civilians getVariable [format["gangs%1",_x],[]];
        if(count _gangs > 0) then {
            private _gangid = _gangs select 0;
            private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
            if(count _gang > 4) then { //filter out old gangs
                private _members = _gang select 0;
                private _numingang = count _members;

                //when out of spawn distance, simulate kills (only when resistance controls the town)
                if(_town in (server getVariable ["NATOabandoned",[]]) && _stability < 50 && !(_pos call OT_fnc_inSpawnDistance)) then {
                    _garrison = (server getVariable [format["police%1",_x],0]);
                    if(_numingang > _garrison) then {
                        if(_garrison > 0 && (random 50) < (_numingang - _garrison)) then {
                            format["A police officer has been killed by a gang in %1",_town] remoteExec ["OT_fnc_notifyMinor",0,false];
                            _garrison = (server getVariable [format["police%1",_x],0]) - 1;
                            server setVariable [format["police%1",_town],_garrison,true];
                            [_town,-2] call OT_fnc_stability;
                            [_town,-2] call OT_fnc_support;
                        };
                    };
                    if(_numingang < _garrison) then {
                        if(_numingang > 0 && (random 40) < (_garrison - _numingang)) exitWith {
                            //Police have killed a member

                            private _civid = selectRandom _members;
                            _members deleteAt (_members find _civid);
                            _gang set [0,_members];
                            OT_civilians setVariable [format["gang%1",_gangid],_gang,true];
                            [_town,2] call OT_fnc_stability;
                            [_town,5] call OT_fnc_support;
                        };
                        if((random 60) < (_garrison - _numingang)) exitWith {
                            //Police have killed the leader

                            OT_civilians setVariable [format["gang%1",_gangid],nil,true];
            				_gangs = OT_civilians getVariable [format["gangs%1",_hometown],[]];
            				_gangs deleteAt (_gangs find _gangid);
            				OT_civilians setVariable [format["gangs%1",_hometown],_gangs,true];
            				format["The gang leader in %1 has been eliminated by police",_town] remoteExec ["OT_fnc_notifyMinor",0,false];
            				spawner setVariable [format["nogang%1",_town],time+3600,false]; //No gangs in this town for 1 hr real-time
                            _mrkid = format["gang%1",_town];
                            deleteMarker _mrkid;
                            [_town,10] call OT_fnc_stability;
                            [_town,25] call OT_fnc_support;
                        };
                    };

                    //Chance to drop stability and support if no police

                    if(_garrison == 0 && (random 100) < _numingang) then {
                        [_town,-1] call OT_fnc_stability;
                        [_town,-1] call OT_fnc_support;
                    };
                };

                //Chance to reveal gang camp if support is high
                private _support = [_town] call OT_fnc_support;
                if((random 200) < _support) then {
                    format["Citizens in %1 have notified us of a gang nearby with %2 members",_town,_numingang + 1] remoteExec ["OT_fnc_notifyMinor",0,false];
                    _mrkid = format["gang%1",_town];
                    _mrk = createMarker [_mrkid, _gang select 4];
                    _mrkid setMarkerType "ot_Camp";
                    _mrkid setMarkerColor "colorOPFOR";
                };
            };
        };

    }foreach(OT_allTowns);
};
