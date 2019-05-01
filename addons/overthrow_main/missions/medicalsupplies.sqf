params ["_jobid","_jobparams"];
_jobparams params ["_destinationName"];

private _roads = (server getVariable [_destinationName,[]]) nearRoads 75;
private _destination = [];
if(count _roads > 0) then {
    _destination = getpos(_roads select 0);
}else{
    _destination = server getVariable [_destinationName,[]];
};

private _items = [];
{
    _x params ["_cat","_i"];
    if(_cat isEqualTo "Pharmacy") exitWith {_items = _i};
}foreach(OT_items);
private _itemcls = selectRandom _items;
private _itemName = _itemcls call OT_fnc_weaponGetName;
private _cost = (cost getVariable [_itemcls,[1]]) select 0;
if(_cost < 5) then {_cost = 5};
private _numitems = floor(2 + random(400 / _cost));

private _params = [_destination,_destinationName,_itemcls,_numitems];
private _markerPos = _destination;

private _effect = "Stability in the town will decrease and the local community will support the resistance more (+25 support).";
if(_destinationName in (server getVariable ["NATOabandoned",[]])) then {
    _effect = "Stability in the town will increase and the local community will support the resistance more (+25 support).";
};

//Build a mission description and title
private _description = format["%1 is in need of medical supplies. Deliver %2 x %3 to the marked location using any vehicle, just pull up with the items in the inventory. <br/><br/>%4",_destinationName,_numitems,_itemName,_effect];
private _title = format["%1 needs %2 x %3",_destinationName,_numitems,_itemName];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        //No setup required for this mission
    },
    {
        //Fail check...
        false
    },
    {
        //Success Check
        params ["_destination","_destinationName","_itemcls","_numitems"];
        private _numavailable = 0;
        private _found = false;
        private _driver = objNull;
        {
            private _c = _x;

            if((_x call OT_fnc_hasOwner) && (speed _x) < 0.1) then {
                {
                    _x params ["_cls","_amt"];
                    if(_cls == _itemcls && _amt >= _numitems) exitWith {
                        _found = true;
                    };
                }foreach(_c call OT_fnc_unitStock);
            };
            if(_found) exitWith {};
        }foreach(_destination nearObjects ["AllVehicles", 15]);

        _found
    },
    {
        params ["_destination","_destinationName","_itemcls","_numitems","_wassuccess"];

        //If mission was a success

        if(_wassuccess) then {
            private _found = false;
            private _driver = objNull;
            //Take the medical supplies
            {
                private _c = _x;
                if((_x call OT_fnc_hasOwner) && (speed _x) < 0.1) then {
                    {
                        _x params ["_cls","_amt"];
                        if(_cls == _itemcls && _amt >= _numitems) exitWith {
                            _driver = driver _c;
                            _found = true;
                            [_c, _cls, _numitems] call CBA_fnc_removeItemCargo;
                        };
                    }foreach(_c call OT_fnc_unitStock);
                };
                if(_found) exitWith {};
            }foreach(_destination nearObjects ["AllVehicles", 15]);

            //apply stability and support
            [
                _destinationName,
                25,
                format["Delivered %1 x %2 medical supplies",_numitems,_itemcls call OT_fnc_weaponGetName],
                _driver
            ] call OT_fnc_support;

            if(_destinationName in (server getVariable ["NATOabandoned",[]])) then {
                [_destinationName,10] call OT_fnc_stability;
            }else{
                [_destinationName,-10] call OT_fnc_stability;
            };
        };
    },
    _params
];
