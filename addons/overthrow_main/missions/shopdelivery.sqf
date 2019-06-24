params ["_jobid","_jobparams"];
_jobparams params ["_gangid"];
private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
private _civ = OT_interactingWith;

private _cat = _civ getVariable "OT_shopCategory";

private _startpos = getpos player;
private _starttown = _startpos call OT_fnc_nearestTown;
private _destination = [];
private _destinationName = "";
private _itemcls = "";

_numitems = floor(1 + random 2);

//Find an item this store sells

if(_cat isEqualTo "Clothing") then {
    _itemcls = selectRandom OT_clothes_locals;
    _numitems = 1;
}else{
    {
        if((_x select 0) isEqualTo _cat) exitWith {
            _itemcls = selectRandom (_x select 1);
        };
    }foreach(OT_items);
};
private _worth = [_itemcls,OT_Nation,100,100] call OT_fnc_getPrice;
if(_worth > 20) then {
    _numitems = 1;
};

private _itemname = _itemcls call OT_fnc_weaponGetName;

//Find a destination
{
    private _town = _x;
    private _posTown = server getVariable _town;
    if([_posTown,_startpos] call OT_fnc_regionIsConnected) exitWith {
        _destinationName = _town;
        _building = [_posTown,OT_allHouses] call OT_fnc_getRandomBuilding;
        _destination = selectRandom (_building call BIS_fnc_buildingPositions);
        if(isNil "_destination") then {
            _destination = _posTown findEmptyPosition [5,100,OT_civType_local];
        };
    };
}foreach([OT_allTowns,[],{random 100},"ASCEND"] call BIS_fnc_SortBy);


_reward = floor((_startpos distance2D _destination) * 0.005 * _numitems);

_markerPos = _destination;
_params = [_destination,_itemcls,_numitems,_reward,_starttown];

//Build a mission description and title
private _description = format["I need someone to deliver %1 x %2 to a customer in %3. You have 6 hours.</t><br/><br/><t size='0.9' align='center'>Reward: $%4, +2 Resistance Support",_numitems,_itemname,_destinationName,_reward];
private _title = format["Deliver %1 x %2 for %3 store in %4",_numitems,_itemname,_cat,_starttown];

//The data below is what is returned to the gun dealer/faction rep, _markerPos is where to put the mission marker, the code in {} brackets is the actual mission code, only run if the player accepts
[
    [_title,_description],
    _markerPos,
    {
        params ["_destination","_itemcls","_numitems"];
        if !(player canAdd [_itemcls,_numitems]) exitWith {
            "You don't have enough room in your inventory for the items" call OT_fnc_notifyMinor;
            false;
        };
        _group = createGroup civilian;
        _group setBehaviour "CARELESS";
        _civ = _group createUnit [OT_civType_local, _destination, [],0, "NONE"];
        _civ disableAI "MOVE";
        _civ setVariable ["OT_delivery",[_itemcls,_numitems],true];

        //Set face,voice and uniform
        [_civ, selectRandom OT_faces_local] remoteExecCall ["setFace", 0, _civ];
        [_civ, selectRandom OT_voices_local] remoteExecCall ["setSpeaker", 0, _civ];
        _civ forceAddUniform (selectRandom OT_clothes_locals);

        //Make sure hes in the group
        [_civ] joinSilent nil;
        [_civ] joinSilent _group;
        _civ setVariable ["NOAI",true,false];
        _group setVariable ["Vcm_Disable",true,true];
        _this pushback _civ;

        //give the items to the player
        _count = 0;
        while {_count < _numitems} do {
            player addItem _itemcls;
            _count = _count + 1;
        };
        format["%1 x %2 added to inventory",_numitems,_itemcls call OT_fnc_weaponGetName] call OT_fnc_notifyMinor;
        true;
    },
    {
        //Fail check... is customer ded?
        params ["","","","","","_civ"];
        !alive _civ
    },
    {
        //Success Check.. items were delivered
        params ["","","","","","_civ"];
        _civ getVariable ["OT_deliveryDone",false];
    },
    {
        params ["_destination","_itemcls","_numitems","_reward","_starttown","_civ","_wassuccess"];
        _civ call OT_fnc_cleanup;

        //If mission was a success
        if(_wassuccess) then {
            _player = _civ getVariable ["OT_deliveredBy",objNull];

            //apply support and pay money
            [
                _reward,
                format[
                    "Delivered %1 x %2",
                    _numitems,
                    _itemcls call OT_fnc_weaponGetName
                ]
            ] remoteExec ["OT_fnc_money",_player,false];
            [_starttown,2] call OT_fnc_support;
        }else{
            [_starttown,-10,format["Failed Delivery of %1 x %2",_numitems,_itemcls call OT_fnc_weaponGetName]] call OT_fnc_support;
        };
    },
    _params
];
