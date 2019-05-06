private _town = (getpos player) call OT_fnc_nearestTown;
private _standing = [_town] call OT_fnc_support;

player setVariable ["OT_shopTarget","Vehicle",false];
player setVariable ["OT_shopTargetCategory","Hardware",false];

createDialog "OT_dialog_sell";
[[vehicle player,"Hardware"] call OT_fnc_unitStock,_town,_standing] call OT_fnc_sellDialog;
