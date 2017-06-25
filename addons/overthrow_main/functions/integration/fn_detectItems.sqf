OT_itemCategoryDefinitions = [
    ["General",["Bandage (Basic)","Banana","Map","Toolkit","Compass","Earplugs","Watch","Radio","Compass"]],
    ["Pharmacy",["Bandage","autoinjector","IV","Bodybag","Dressing","Earplugs"]],
    ["Electronics",["Rangefinder","Cellphone","Radio","Watch","GPS","monitor","DAGR","Battery"]],
    ["Hardware",["Tool","Cable Tie","paint","Wirecutter"]],
    ["Surplus",["Rangefinder","Binocular","Compass"]]
];

OT_items = [];
OT_allItems = [];
OT_craftableItems = [];

private _categorize = {
    params ["_c","_cat"];
    _done = false;
    {
        if((_x select 0) == _cat) exitWith {
            _items = _x select 1;
            if !(_c in _items) then {
                _items pushback _c;
            };
            _done = true;
        };
    }foreach(OT_items);
    if !(_done) then {
        OT_items pushback [_cat,[_c]];
    };
};

private _getprice = {
    params ["_x","_primaryCategory"];
    _mass = getNumber ( _x >> "ItemInfo" >> "mass" );
    _craftable = getNumber ( _x >> "ot_craftable" );

    if(_craftable > 0) then {
        _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
        _qty = getNumber ( _x >> "ot_craftQuantity" );
        OT_craftableItems pushback [_cls,_recipe,_qty];
    };

    _name = getText (_x >> "displayName");
    _price = round(_mass * 1.5);
    _steel = 0;
    _wood = 0;
    _plastic = 0;
    _steel = ceil(_mass * 0.2);
    if(_mass == 1) then {
        _steel = 0.1;
    };
    if(_primaryCategory == "Pharmacy") then {
        _price = _mass * 4;
        _steel = 0;
        _plastic = ceil(_mass * 0.2);
        if(_mass == 1) then {
            _plastic = 0.1;
        };
        call {
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
    if(_primaryCategory == "Electronics") then {
        _price = _mass * 4;
        _steel = 0;
        _plastic = ceil(_mass * 0.2);
        call {
            if(_name find "Altimeter" > -1) exitWith {
                _price = round(_price * 3);
            };
            if(_name find "MicroDAGR" > -1) exitWith {
                _price = round(_price * 7);
            };
            if(_name find "GPS" > -1) exitWith {
                _price = round(_price * 1.5);
            };
            if(_name find "DAGR" > -1) exitWith {
                _price = round(_price * 2);
            };
            if(_name find "monitor" > -1) exitWith {
                _price = round(_price * 3);
            };
        };
    };
    if(_primaryCategory == "Hardware") then {
        _price = _mass;
    };
    _cls = configName _x;
    if(_cls == "ToolKit") then {
        _price = 80;
    };
    [_price,_wood,_steel,_plastic];
};

{
    _cls = configName _x;
    _name = getText (_x >> "displayName");
    _desc = getText (_x >> "descriptionShort");

    _categorized = false;
    _primaryCategory = "";
    {
        _x params ["_category","_types"];
        {
            if((_name find _x > -1) or (_desc find _x > -1)) exitWith {
                [_cls,_category] call _categorize;
                _categorized = true;
                if(_category != "General") then {
                    _primaryCategory = _category;
                };
                {
                    _c = configName _x;
                    [_c,_category] call _categorize;
                    if(isServer) then {
                        cost setVariable [_c,[_x,_primaryCategory] call _getprice,true];
                    };
                }foreach("inheritsFrom _x isEqualTo (configFile >> ""CfgWeapons"" >> """ + _cls + """)" configClasses ( configFile >> "CfgWeapons" ));
            };
        }foreach(_types);
    }foreach(OT_itemCategoryDefinitions);

    if(isServer) then {
        cost setVariable [_cls,[_x,_primaryCategory] call _getprice,true];
    };

    if(_categorized) then {
        OT_allItems pushback _cls;
    };
}foreach("(inheritsFrom _x in [configFile >> ""CfgWeapons"" >> ""ItemCore"",configFile >> ""CfgWeapons"" >> ""ACE_ItemCore""])" configClasses ( configFile >> "CfgWeapons" ));

//add craftable magazines
{
    _cls = configName _x;
    _recipe = call compileFinal getText (_x >> "ot_craftRecipe");
    _qty = getNumber ( _x >> "ot_craftQuantity" );
    OT_craftableItems pushback [_cls,_recipe,_qty];
}foreach("getNumber (_x >> ""ot_craftable"") isEqualTo 1" configClasses ( configFile >> "CfgMagazines" ));
