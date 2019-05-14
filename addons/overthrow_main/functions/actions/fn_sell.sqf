if (OT_selling) exitWith {};
OT_selling = true;

private _town = (getpos player) call OT_fnc_nearestTown;
private _standing = ([_town] call OT_fnc_support) * -1;
private _idx = lbCurSel 1500;
private _cls = lbData [1500,_idx];

if(isNil "_cls" || {_cls isEqualTo ""}) exitWith {OT_selling = false};

private _price = [_town,_cls,_standing] call OT_fnc_getSellPrice;

if(isNil "_price") exitWith {OT_selling = false};

[_price] call OT_fnc_money;

if(OT_hasTFAR) then {
	private _c = _cls splitString "_";
	if((_c select 0) == "tf") then {
		{
			if((_x find _cls) isEqualTo 0) exitWith {_cls = _x};
		}foreach(items player);
	};
};
private _target = player;
if((player getVariable ["OT_shopTarget","Self"]) == "Vehicle") then {
	_target = vehicle player;
	if !([_target, _cls, 1] call CBA_fnc_removeItemCargo) then {
		if !([_target, _cls, 1] call CBA_fnc_removeWeaponCargo) then {
			if !([_target, _cls, 1] call CBA_fnc_removeMagazineCargo) then {
				if !([_target, _cls, 1] call CBA_fnc_removeBackpackCargo) then {
					//item must be in a backpack/uniform etc
					{
						_x params ["_itemcls","_item"];
						if(_cls in (itemCargo _item)) exitWith {[_item, _cls, 1] call CBA_fnc_removeItemCargo};
						if(_cls in (weaponCargo _item)) exitWith {[_item, _cls, 1] call CBA_fnc_removeWeaponCargo};
						if(_cls in (magazineCargo _item)) exitWith {[_item, _cls, 1] call CBA_fnc_removeMagazineCargo};
					}foreach(everyContainer _target);
				};
			};
		};
	};
}else{
	_target removeItem _cls;
};

lbClear 1500;
private _cat = player getVariable ["OT_shopTargetCategory",""];
[[_target,_cat] call OT_fnc_unitStock,_town,_standing] call OT_fnc_sellDialog;
OT_selling = false;
