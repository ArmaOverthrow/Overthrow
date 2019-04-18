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
    private _mass = getNumber ( _x >> "ItemInfo" >> "mass" );
    private _craftable = getNumber ( _x >> "ot_craftable" );

    if(_craftable > 0) then {
        private _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
        private _qty = getNumber ( _x >> "ot_craftQuantity" );
        OT_craftableItems pushback [configName _x,_recipe,_qty];
    };

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
            if(_name find "Blood" > -1) exitWith {
                _price = round(_price * 1.3);
            };
            if(_name find "Saline" > -1) exitWith {
                _price = round(_price * 0.3);
            };
            if(_name find "(250 ml)" > -1) exitWith {
                _price = round(_price * 0.5);
            };
            if(_name find "(Basic)" > -1) exitWith {
                _price = 1;
            };
            if(_name find "Epinephrine" > -1) exitWith {
                _price = 30;
                _plastic = 0;
            };
            if(_name find "autoinjector" > -1) exitWith {
                _price = 10;
                _plastic = 0;
            };
            if(_name find "Bodybag" > -1) exitWith {
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
            if(_name find "Altimeter" > -1) exitWith {3};
            if(_name find "MicroDAGR" > -1) exitWith {7};
            if(_name find "GPS" > -1) exitWith {1.5};
            if(_name find "DAGR" > -1) exitWith {2};
            if(_name find "monitor" > -1) exitWith {3};
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
            if((_name find _x > -1) || (_desc find _x > -1)) exitWith {
                [_cls,_category] call _categorize;
                _categorized = true;
                if(_category != "General") then {
                    _primaryCategory = _category;
                };
                {
                    private _c = configName _x;
                    [_c,_category] call _categorize;
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
}foreach("(inheritsFrom _x in [configFile >> ""CfgWeapons"" >> ""ItemCore"",configFile >> ""CfgWeapons"" >> ""ACE_ItemCore""])" configClasses ( configFile >> "CfgWeapons" ));

//add craftable magazines
{
    private _cls = configName _x;
    private _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
    private _qty = getNumber ( _x >> "ot_craftQuantity" );
    OT_craftableItems pushback [_cls,_recipe,_qty];
}foreach("getNumber (_x >> ""ot_craftable"") isEqualTo 1" configClasses ( configFile >> "CfgMagazines" ));
