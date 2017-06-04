
private _description = "";
private _destination = [];
private _destinationName = "";
private _title = "";

//Here is where we might randomize the parameters a bit
_destinationName = (getpos player) call OT_fnc_nearestTown;
private _abandoned = (server getVariable ["NATOabandoned",[]]) + [(server getVariable ["NATOattacking",""])];
if(_destinationName in _abandoned) then {
    _destinationName = selectRandom (OT_allTowns - _abandoned);
};

_destination = getpos([server getVariable [_destinationName,[]]] call BIS_fnc_nearestRoad);
private _params = [_destination,_destinationName];
private _markerPos = _destination;

//Build a mission description and title
_description = format["%1 is in need of medical supplies. NATO has not been fulfilling the demands of the population so delivering these supplies will drop the stability there and raise your standing as the public warms to our cause. Deliver as many bandages of any type to the marker using a vehicle, the more you have in your vehicle inventory the more effect it will have.",_destinationName];
_title = format["Medical supplies for %1",_destinationName];

//This next number multiplies the reward
_difficulty = 0.5;

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[[_title,_description],_markerPos,{
    //No setup required for this mission
},{
    //Fail check...
    //If player is wanted
    !(captive player);
},{
    //Success Check
    params ["_p","_faction","_factionName"];
    _p params ["_destination","_destinationName","_lastwarning"];
    _supplies = ["ACE_fieldDressing","ACE_elasticBandage"];

    if(isNil "_lastwarning") then {
        _lastwarning = 0;
        _p set [2,0];
    };

    _numavailable = 0;
    _threshold = 10;
    {
		_c = _x;
        if((_x call OT_fnc_hasOwner) and (speed _x) < 0.1) then {
		     {
    			_x params ["_cls","_amt"];
    			if(_cls in _supplies) then {
    				_numavailable = _numavailable + _amt;
    			};
    		}foreach(_c call OT_fnc_unitStock);
        };
	}foreach(_destination nearObjects ["Land", 10]);

    if((time - _lastwarning) > 5) then {
        if((_numavailable > 0) and _numavailable < _threshold) then {
            "At least 10 bandages required to complete mission" call OT_fnc_notifyMinor;
        };
        _p set [2,time];
    };
    _numavailable > _threshold
},{
    params ["_target","_pos","_p","_wassuccess"];
    _p params ["_missionParams","_faction","_factionName","_finish","_rewards"];

    //If mission was a success
    if(_wassuccess) then {
        _supplies = ["ACE_fieldDressing","ACE_elasticBandage"];
        //Take the medical supplies and count them
        _numavailable = 0;
        {
    		_c = _x;
            if((_x call OT_fnc_hasOwner) and (speed _x) < 0.1) then {
    		     {
        			_x params ["_cls","_amt"];
        			if(_cls in _supplies) then {
                        [_c, _cls, _amt] call CBA_fnc_removeItemCargo;
        				_numavailable = _numavailable + _amt;
        			};
        		}foreach(_c call OT_fnc_unitStock);
            };
    	}foreach(_pos nearObjects ["Land", 10]);

        //calculate the effect on stability
        _effect = round(_numavailable * 0.2);
        if(_effect > 20) then {
            _effect = 20;
        };
        _town = _pos call OT_fnc_nearestTown;

        //apply stability and standing
        [_town,round(_effect*0.5),format["Delivered %1 medical supplies",_numavailable]] call OT_fnc_standing;
        [_town,-_effect] call OT_fnc_stability;
    }else{
        //slight positive effect on stability
        _town = _pos call OT_fnc_nearestTown;
        [_town,2] call OT_fnc_stability;
    };
},_params,_difficulty];
