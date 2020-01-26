crim_counter = crim_counter + 1;
if !(crim_counter < 12) then {
    crim_counter = 0;
    private _revealed = server getVariable ["revealedGangs",[]];
    {
        _nogang = spawner getVariable [format["nogang%1",_x],0];
        _pop = server getVariable [format["population%1",_x],0];
        _stability = server getVariable [format["stability%1",_x],0];
        _garrison = (server getVariable [format["police%1",_x],0]) + (server getVariable [format["garrison%1",_x],0]);
        _town = _x;
        _pos = server getVariable _x;



        private _gangs = OT_civilians getVariable [format["gangs%1",_x],[]];
        if(count _gangs > 0) then {
            private _gangid = _gangs select 0;
            private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
            if(count _gang == 9) then { //filter out old gangs
                _gang params ["_members","","","","","","_resources","_level","_name"];
                private _numingang = count _members;

                spawner setVariable [format["nogang%1",_town],0,false];
                //increase gang resources and try to increase in size
                private _add = 0;
                if(_stability < 50) then {
                    _add = _add + (50 - _stability);
                };
                _resources = _resources + _add;

                if(_resources > 100 && _numingang < 15) then {
                    _resources = _resources - 100;
                    [_gangid] call OT_fnc_addToGang;
                };

                //when out of spawn distance, simulate kills (only when resistance controls the town)
                if(_town in (server getVariable ["NATOabandoned",[]]) && _stability < 50 && !(_pos call OT_fnc_inSpawnDistance)) then {
                    _garrison = (server getVariable [format["police%1",_x],0]);
                    if(_numingang > _garrison) then {
                        if(_garrison > 0 && (random 50) < (_numingang - _garrison)) then {
                            format["A police officer has been killed by %2 in %1",_town,_name] remoteExec ["OT_fnc_notifyMinor",0,false];
                            _garrison = (server getVariable [format["police%1",_x],0]) - 1;
                            server setVariable [format["police%1",_town],_garrison,true];
                            [_town,-2] call OT_fnc_stability;
                            [_town,-2] call OT_fnc_support;
                            _mrkid = format["%1-police",_town];
                    		_mrkid setMarkerText format["%1",_garrison];
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
                            _resources = _resources - 50;
                        };
                        if((random 60) < (_garrison - _numingang)) exitWith {
                            //Police have killed the leader
                            OT_civilians setVariable [format["gang%1",_gangid],nil,true];
            				_gangs = OT_civilians getVariable [format["gangs%1",_town],[]];
            				_gangs deleteAt (_gangs find _gangid);
            				OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
            				format["The leader of %2 in %1 has been eliminated by police",_town,_name] remoteExec ["OT_fnc_notifyMinor",0,false];
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

                if !(_gangid in _revealed) then {
                    private _support = [_town] call OT_fnc_support;
                    if((random (300 + (_level * 50))) < _support) then {
                        format["Citizens in %1 have notified us of gang nearby with %2 members (%3)",_town,_numingang + 1,_name] remoteExec ["OT_fnc_notifyMinor",0,false];
                        _mrkid = format["gang%1",_town];
                        _mrk = createMarker [_mrkid, _gang select 4];
                        _mrkid setMarkerType "ot_Camp";
                        _mrkid setMarkerColor "colorOPFOR";
                        _revealed pushback _gangid;
                    };
                };

                if(_resources < 0) then {_resources = 0};
                _gang set [6,_resources];
            };
        }else{
            if(time > _nogang && _stability < 50) then {
                //chance to form a new one
                _chance = (50 - _stability);
                if(_garrison < 4) then {_chance = _chance + 25};
                if !(_town in (server getVariable ["NATOabandoned",[]])) then {_chance = 10}; //Much lower chance of new gangs under NATO rule
                if((random 250) < _chance) then {
                    [_town,true] call OT_fnc_formGang;
                };
            };
        };

    }foreach(OT_allTowns);
    server setVariable ["revealedGangs",_revealed,true];
};
