private _categorize = {
    params ["_c","_cat"];
    private _done = false;
    {
        if((_x select 0) isEqualTo _cat) exitWith {
            (_x select 1) pushBackUnique _c;
            _done = true;
        };
    }foreach(OT_items);
    if !(_done) then {
        OT_items pushback [_cat,[_c]];
    };
};

private _getprice = {
    params ["_x","_primaryCategory"];
    private _cls = configName _x;
    private _mass = getNumber ( _x >> "ItemInfo" >> "mass" );

    private _name = getText (_x >> "displayName");
    private _price = round(_mass * 1.5);
    private _steel = 0;
    private _wood = 0;
    private _plastic = 0;
    private _steel = ceil(_mass * 0.2);
    if(_mass isEqualTo 1) then {
        _steel = 0.1;
    };
    if(_primaryCategory isEqualTo "Pharmacy") then {
        _steel = 0;
        _plastic = ceil(_mass * 0.2);
        if(_mass isEqualTo 1) then {
            _plastic = 0.1;
        };
        private _res = [_name,_mass] call {
            params ["_name", "_mass"];
            _price = _mass * 4;
            if(_cls find "blood" > -1) exitWith {
                _price = round(_price * 1.3);
            };
            if(_cls find "saline" > -1) exitWith {
                _price = round(_price * 0.3);
            };
            if(_cls find "IV_250" > -1) exitWith {
                _price = round(_price * 0.5);
            };
            if(_cls find "IV_500" > -1) exitWith {
                _price = round(_price * 1.5);
            };
            if(_cls find "fieldDressing" > -1) exitWith {
                _price = 1;
            };
            if(_cls find "epinephrine" > -1) exitWith {
                _price = 30;
                _plastic = 0;
            };
            if(_cls find "bodybag" > -1) exitWith {
                _price = 2;
                _plastic = 0.1;
            };
        };
    };
    if(_primaryCategory isEqualTo "Electronics") then {
        _steel = 0;
        _plastic = ceil(_mass * 0.2);
        _price = _mass * 4;
        private _factor = [_name] call {
            params ["_name"];
            if(_cls find "altimeter" > -1) exitWith {3};
            if(_cls find "DAGR" > -1) exitWith {7};
            if(_cls find "GPS" > -1) exitWith {1.5};
            if(_cls find "_dagr" > -1) exitWith {2};
            1
        };
        _price = round (_price * _factor);
    };
    if(_primaryCategory isEqualTo "Hardware") then {
        _price = _mass;
    };
    private _cls = configName _x;
    if(_cls isEqualTo "ToolKit") then {
        _price = 80;
    };
    [_price,_wood,_steel,_plastic];
};

{
    private _cls = configName _x;
    private _name = getText (_x >> "displayName");
    private _desc = getText (_x >> "descriptionShort");

    private _categorized = false;
    private _primaryCategory = "";
    {
        _x params ["_category","_types"];
        {
            if((_cls find _x > -1) || (_name find _x > -1) || (_desc find _x > -1)) exitWith {
                [_cls,_category] call _categorize;
                _categorized = true;
                if(_category != "General") then {
                    _primaryCategory = _category;
                };
                {
                    private _c = configName _x;
                    [_c,_category] call _categorize;

                    private _craftable = getNumber ( _x >> "ot_craftable" );

                    if(_craftable > 0) then {
                        private _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
                        private _qty = getNumber ( _x >> "ot_craftQuantity" );
                        OT_craftableItems pushback [configName _x,_recipe,_qty];
                    };

                    if(isServer && isNil {cost getVariable _c}) then {
                        cost setVariable [_c,[_x,_primaryCategory] call _getprice,true];
                    };
                }foreach(format ["inheritsFrom _x isEqualTo (configFile >> ""CfgWeapons"" >> ""%1"")",_cls] configClasses ( configFile >> "CfgWeapons" ));
            };
        }foreach(_types);
    }foreach(OT_itemCategoryDefinitions);

    if(isServer && isNil {cost getVariable _c}) then {
        cost setVariable [_cls,[_x,_primaryCategory] call _getprice,true];
    };

    if(_categorized) then {
        OT_allItems pushback _cls;
    };
}foreach("(inheritsFrom _x in [configFile >> ""CfgWeapons"" >> ""Binocular"",configFile >> ""CfgWeapons"" >> ""ItemCore"",configFile >> ""CfgWeapons"" >> ""ACE_ItemCore""])" configClasses ( configFile >> "CfgWeapons" ));

//add Bags
{
    private _cls = configName _x;
    if ((_cls find "_Base") isEqualTo -1) then {
        [_cls,"Surplus"] call _categorize;
    };
}foreach("_parents = ([_x,true] call BIS_fnc_returnParents); 'Bag_Base' in _parents && !('Weapon_Bag_Base' in _parents) && (count (_x >> 'TransportItems') isEqualTo 0) && (count (_x >> 'MagazineItems') isEqualTo 0)" configClasses ( configFile >> "CfgVehicles" ));
//add craftable magazines
{
    private _cls = configName _x;
    private _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
    private _qty = getNumber ( _x >> "ot_craftQuantity" );
    OT_craftableItems pushback [_cls,_recipe,_qty];
}foreach("getNumber (_x >> ""ot_craftable"") isEqualTo 1" configClasses ( configFile >> "CfgMagazines" ));
//add craftable weapons
{
    private _cls = configName _x;
    private _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
    private _qty = getNumber ( _x >> "ot_craftQuantity" );
    OT_craftableItems pushback [_cls,_recipe,_qty];
}foreach("getNumber (_x >> ""ot_craftable"") isEqualTo 1" configClasses ( configFile >> "CfgWeapons" ));
