private _town = (getpos player) call OT_fnc_nearestTown;
private _standing = [_town] call OT_fnc_support;

private _category = ((nearestBuilding player) getVariable ["OT_shopCategory","General"]);

player setVariable ["OT_shopTarget","Vehicle",false];
player setVariable ["OT_shopTargetCategory",_category,false];

createDialog "OT_dialog_sell";
[[vehicle player,_category] call OT_fnc_unitStock,_town,_standing] call OT_fnc_sellDialog;
