private _s = [
    ["OT_Steel",-1],
    ["OT_Wood",-1],
    ["OT_Plastic",-1]
];

{
    if((_x select 0) isEqualTo "Hardware") exitWith {
        {
            _s pushback [_x,-1];
        }foreach(_x select 1);
    };
}foreach(OT_items);

player setVariable ["OT_shopTarget","Vehicle",false];

_town = (getpos player) call OT_fnc_nearestTown;
private _standing = [_town] call OT_fnc_support;

createDialog "OT_dialog_buy";
[_town,_standing,_s] call OT_fnc_buyDialog;
