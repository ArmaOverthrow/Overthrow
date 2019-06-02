params [
    "_loadout",
    ["_rifles",OT_allBLURifles],
    ["_glRifles",OT_allBLUGLRifles],
    ["_machineGuns",OT_allBLUMachineGuns],
    ["_sniperRifles",OT_allBLUSniperRifles],
    ["_launchers",OT_allBLULaunchers],
    ["_handguns",OT_allBLUPistols]
];

//helper functions
private _removeMagazines = {
    params ["_newloadout","_forcls"];
    private _hasVest = count(_newloadout select 4) > 0;
    private _hasBackpack = count(_newloadout select 5) > 0;
    private _magazines = getArray (configFile >> "CfgWeapons" >> _forcls >> "magazines");
    {
        if !(_x isEqualTo "this") then {
            _magazines = _magazines + getArray (configFile >> "CfgWeapons" >> _forcls >> _x >> "magazines")
        };
    }foreach(getArray (configFile >> "CfgWeapons" >> _forcls >> "muzzles"));
    //from uniform
    private _items = (_newloadout select 3) select 1;
    {
        _x params ["_cls","_num"];
        if(_cls in _magazines) then {_x set [1,0]};
    }foreach(_items);

    //from vest
    if(_hasVest) then {
        _items = (_newloadout select 4) select 1;
        {
            _x params ["_cls","_num"];
            if(_cls in _magazines) then {_x set [1,0]};
        }foreach(_items);
    };

    if(_hasBackpack) then {
        //from backpack
        _items = (_newloadout select 5) select 1;
        {
            _x params ["_cls","_num"];
            if(_cls in _magazines) then {_x set [1,0]};
        }foreach(_items);
    };
};

private _newloadout = +_loadout; //clone the loadout

//get some basic info about the loadout
private _hasVest = count(_newloadout select 4) > 0;
private _hasBackpack = count(_newloadout select 5) > 0;
private _hasPrimary = count(_newloadout select 0) > 0;
private _hasLauncher = count(_newloadout select 1) > 0;
private _hasHandgun = count(_newloadout select 2) > 0;

//replace primary weapon
if(_hasPrimary) then {
    private _primaryWpn = (_loadout select 0) select 0;
    private _base = [_primaryWpn] call BIS_fnc_baseWeapon;

    //remove magazines for primary weapon
    [_newloadout,_primaryWpn] call _removeMagazines;

    //replace primary weapon
    private _wpn = _base call {
        if(_this in _glRifles) exitWith {selectRandom _glRifles};
        if(_this in _sniperRifles) exitWith {selectRandom _sniperRifles};
        if(_this in _machineGuns) exitWith {selectRandom _machineGuns};
        selectRandom _rifles;
    };

    (_newloadout select 0) set [0,_wpn];

    _magazines = getArray (configFile >> "CfgWeapons" >> _wpn >> "magazines");

    _mag = "";
    {
        _scope = getNumber (configFile >> "CfgMagazines" >> _x >> "scope");
        if(_scope > 1) exitWith {_mag = _x};
    }foreach([_magazines,[],{random 100},"ASCEND"] call BIS_fnc_sortBy);

    private _count = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
    (_newloadout select 0) set [4,[_mag,_count]];

    //add mags to vest
    if(_hasVest) then {
        ((_newloadout select 4) select 1) pushBack [_mag,6,_count];
    };

    //get secondary mags (grenade rounds etc)

    _secondmags = [];
    {
        if !(_x isEqualTo "this") then {
            _secondmags = _secondmags + getArray (configFile >> "CfgWeapons" >> _wpn >> _x >> "magazines")
        };
    }foreach(getArray (configFile >> "CfgWeapons" >> _wpn >> "muzzles"));
    if((count _secondmags) > 0) then {
        if(_hasBackpack) then {
            //add all of them to backpack
            {
                private _count = getNumber(configFile >> "CfgMagazines" >> _x >> "count");
                ((_newloadout select 5) select 1) pushBack [_x,4,_count];
            }foreach(_secondmags);
        }else{
            //add the first one to vest
            if(_hasVest) then {
                _mag = _secondmags select 0;
                private _count = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
                ((_newloadout select 4) select 1) pushBack [_mag,6,_count];
            };
        };
    };
};

//replace secondary weapon (launcher)
if(_hasLauncher) then {
    [_newloadout,(_newloadout select 1) select 0] call _removeMagazines;
    _wpn = selectRandom _launchers;
    //we always want the primary mag
    (_newloadout select 1) set [0,_wpn];
    _magazines = getArray (configFile >> "CfgWeapons" >> _wpn >> "magazines");
    _mag = _magazines select 0;
    private _count = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
    private _scope = getNumber(configFile >> "CfgMagazines" >> _mag >> "scope");
    (_newloadout select 1) set [4,[_mag,_count]];

    if(_hasBackpack) then {
        if(_scope < 2) then {
            //single-use launcher, remove backpack
            _newloadout set [5,[]];
        }else{
            (_newloadout select 5) set [1,[]]; //Clear backpack
            //add more primary mags
            ((_newloadout select 5) select 1) pushBack [_mag,2,_count];

            //add 2 other random ones
            private _c = 0;
            {
                if(_foreachIndex > 0) then {
                    private _count = getNumber(configFile >> "CfgMagazines" >> _x >> "count");
                    ((_newloadout select 5) select 1) pushBack [_x,1,_count];
                    _c = _c + 1;
                };
                if(_c isEqualTo 2) exitWith {};
            }foreach([_magazines,[],{random 100},"ASCEND"] call BIS_fnc_sortBy);
        };
    };
};

//replace handgun
if(_hasHandgun) then {
    [_newloadout,((_newloadout select 2) select 0)] call _removeMagazines;
    _wpn = selectRandom _handguns;
    (_newloadout select 2) set [0,_wpn];
    //we always want the primary mag
    _magazines = getArray (configFile >> "CfgWeapons" >> _wpn >> "magazines");
    _mag = _magazines select 0;
    private _count = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
    (_newloadout select 2) set [4,[_mag,_count]];
    //add 2 mags to vest
    if(_hasVest) then {
        ((_newloadout select 4) select 1) pushBack [_mag,2,_count];
    };
};

_newloadout
