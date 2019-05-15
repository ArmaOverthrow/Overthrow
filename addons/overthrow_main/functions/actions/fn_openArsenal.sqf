params ["_target","_unit",["_ammobox",false]];

if(_ammobox isEqualTo false) then {
    _ammobox = _target;
};

private _weapons = [];
private _magazines = [];
private _items = [];
private _backpacks = [];

private _closed = -1;

private _missing = [];

if(_target isEqualType "") then {
    [_unit,true] call OT_fnc_dumpIntoWarehouse;
    {
        if(_x select [0,5] isEqualTo "item_") then {
            private _d = warehouse getVariable [_x,[_cls,0,[0]]];
            if(_d isEqualType []) then {
                _items pushback _d#0;
            };
        };
    }foreach(allVariables warehouse);

    _closed = ["ace_arsenal_displayClosed", {
        _thisArgs params ["_target","_unit","_ammobox"];
        private _ignore = [];
        {
			_x params [["_cls",""], ["_count",0]];
            if !(_cls in _ignore) then {
                private _boxAmount = (warehouse getVariable [format["item_%1",_cls],[_cls,0]]) select 1;
                if(_boxAmount < _count) then {
                    //take off the difference
                    call {
                        if(binocular _unit isEqualTo _cls) exitWith {
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        if(primaryWeapon _unit isEqualTo _cls) exitWith {
                            _ignore append primaryWeaponItems _unit;
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        if(secondaryWeapon _unit isEqualTo _cls) exitWith {
                            _ignore append secondaryWeaponItems _unit;
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        if(handgunWeapon _unit isEqualTo _cls) exitWith {
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        _totake = _count - _boxAmount;
                        if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
                            while{_count > _boxAmount} do {
                                _count = _count - 1;
                                _unit removeMagazine _cls;
                                _missing pushback _cls;
                            };
    					};
                        while{_count > _boxAmount} do {
                            _count = _count - 1;
                            _unit removeItem _cls;
                            _missing pushback _cls;
                        };
                    }
                };

                if(_count > 0) then {
        			[_cls, _count] call OT_fnc_removeFromWarehouse;
                };
            };
		}foreach(_unit call OT_fnc_unitStock);

        {
            if !([_x, 1] call OT_fnc_removeFromWarehouse) then {
                _unit unlinkItem _x;
                _missing pushback _x;
            };
        }foreach(assignedItems _unit);

        private _backpack = backpack _unit;
        if !(_backpack isEqualTo "") then {
            if !([_backpack, 1] call OT_fnc_removeFromWarehouse) then {
                _missing pushback _backpack;
                //Put the items from the backpack back in the warehouse
                {
                    [_x, 1] call OT_fnc_addToWarehouse;
                }foreach(backpackItems _unit);
                removeBackpack _unit;
            };
        };

        private _vest = vest _unit;
        if !(_vest isEqualTo "") then {
            if !([_vest, 1] call OT_fnc_removeFromWarehouse) then {
                _missing pushback _vest;
                //Put the items from the vest back in the warehouse
                {
                    [_x, 1] call OT_fnc_addToWarehouse;
                }foreach(vestItems _unit);
                removeVest _unit;
            };
        };

        private _helmet = headgear _unit;
        if !(_helmet isEqualTo "") then {
            if !([_helmet, 1] call OT_fnc_removeFromWarehouse) then {
                _missing pushback _helmet;
                removeHeadgear _unit;
            };
        };

        private _goggles = goggles _unit;
        if !(_goggles isEqualTo "") then {
            if !([_goggles, 1] call OT_fnc_removeFromWarehouse) then {
                _missing pushback _goggles;
                removeGoggles _unit;
            };
        };

        [_thisType, _thisId] call CBA_fnc_removeEventHandler;
    },[_target,_unit,_ammobox]] call CBA_fnc_addEventHandlerArgs;
}else{
    [_unit,_ammobox,true] call OT_fnc_dumpStuff;
    _weapons = weaponCargo _ammobox;
    _weapons = _weapons arrayIntersect _weapons;
    _magazines = magazineCargo _ammobox;
    _magazines = _magazines arrayIntersect _magazines;
    _items = itemCargo _ammobox;
    _items = _items arrayIntersect _items;
    _backpacks = backpackCargo _ammobox;
    _backpacks = _backpacks arrayIntersect _backpacks;

    _closed = ["ace_arsenal_displayClosed", {
        _thisArgs params ["_target","_unit","_ammobox"];
        private _ignore = [];
        _boxstock = _ammobox call OT_fnc_unitStock;
        {
			_x params [["_cls",""], ["_count",0]];
            diag_log _cls;
            if !(_cls in _ignore) then {
                private _boxAmount = 0;
                {
                    if(_x#0 isEqualTo _cls) exitWith {
                        _boxAmount = _x#1;
                    };
                }foreach(_boxstock);

                if(_boxAmount < _count) then {
                    //take off the difference
                    call {
                        if(binocular _unit isEqualTo _cls) exitWith {
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        if(primaryWeapon _unit isEqualTo _cls) exitWith {
                            _ignore append primaryWeaponItems _unit;
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        if(secondaryWeapon _unit isEqualTo _cls) exitWith {
                            _ignore append secondaryWeaponItems _unit;
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        if(handgunWeapon _unit isEqualTo _cls) exitWith {
                            _unit removeWeapon _cls;
                            _count = 0;
                            _missing pushback _cls;
                        };
                        _totake = _count - _boxAmount;
                        if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
                            while{_count > _boxAmount} do {
                                _count = _count - 1;
                                _unit removeMagazine _cls;
                                _missing pushback _cls;
                            };
    					};
                        while{_count > _boxAmount} do {
                            _count = _count - 1;
                            _unit removeItem _cls;
                            _missing pushback _cls;
                        };
                    }
                };

                if(_count > 0) then {
        			if !([_ammobox, _cls, _count] call CBA_fnc_removeItemCargo) then {
                        if !([_ammobox, _cls, _count] call CBA_fnc_removeWeaponCargo) then {
                            if !([_ammobox, _cls, _count] call CBA_fnc_removeMagazineCargo) then {
                                if !([_ammobox, _cls, _count] call CBA_fnc_removeBackpackCargo) then {
                                    //Item was not found (this shouldnt happen)
                                };
                            };
                        };
        			};
                };
            };
		}foreach(_unit call OT_fnc_unitStock);

        {
            if !([_ammobox, _x, 1] call CBA_fnc_removeItemCargo) then {
                _unit unlinkItem _x;
                _missing pushback _x;
            };
        }foreach(assignedItems _unit);

        private _backpack = backpack _unit;
        if !(_backpack isEqualTo "") then {
            if !(_backpack in backpackCargo _ammobox) then {
                _missing pushback _backpack;
                //Put the items from the backpack back in the ammobox
                {
                    if !([_ammobox, _x, 1] call CBA_fnc_addItemCargo) then {
                        [_ammobox, _x, 1] call CBA_fnc_addMagazineCargo;
                    };
                }foreach(backpackItems _unit);
                removeBackpack _unit;
            }else{
                [_ammobox, _backpack, 1] call CBA_fnc_removeBackpackCargo;
            };
        };

        private _vest = vest _unit;
        if !(_vest isEqualTo "") then {
            if !(_vest in itemCargo _ammobox) then {
                _missing pushback _vest;
                //Put the items from the vest back in the ammobox
                {
                    if !([_ammobox, _x, 1] call CBA_fnc_addItemCargo) then {
                        [_ammobox, _x, 1] call CBA_fnc_addMagazineCargo;
                    };
                }foreach(vestItems _unit);
                removeVest _unit;
            }else{
                [_ammobox, _vest, 1] call CBA_fnc_removeItemCargo;
            };
        };

        private _helmet = headgear _unit;
        if !(_helmet isEqualTo "") then {
            if !(_helmet in itemCargo _ammobox) then {
                _missing pushback _helmet;
                removeHeadgear _unit;
            }else{
                [_ammobox, _helmet, 1] call CBA_fnc_removeItemCargo;
            };
        };

        private _goggles = goggles _unit;
        if !(_goggles isEqualTo "") then {
            if !(_goggles in itemCargo _ammobox) then {
                _missing pushback _goggles;
                removeGoggles _unit;
            }else{
                [_ammobox, _goggles, 1] call CBA_fnc_removeItemCargo;
            };
        };

        [_thisType, _thisId] call CBA_fnc_removeEventHandler;
    },[_target,_unit,_ammobox]] call CBA_fnc_addEventHandlerArgs;
};

[_ammobox, true, false] call ace_arsenal_fnc_removeVirtualItems;
[_ammobox,_weapons+_magazines+_items+_backpacks,false] call ace_arsenal_fnc_addVirtualItems;

[_ammobox, _unit] call ace_arsenal_fnc_openBox;
