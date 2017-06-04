params ["_ctrl","_index"];

disableSerialization;

_cls = _ctrl lbData _index;
_price = _ctrl lbValue _index;

_pic = "";
_txt = "";
_desc = "";
if(_price > -1) then {
    _price = "$" + ([_ctrl lbValue _index, 1, 0, true] call CBA_fnc_formatNumber);
    ctrlEnable [1600,true];
    call {
        if(_cls == "Set_HMG") exitWith {
            _pic = getText(configFile >> "cfgVehicles" >> "C_Quadbike_01_F" >> "editorPreview");
            _desc = "A Quad-bike containing the backpacks required to set up a Static HMG";
            _txt = "Quad Bike w/ HMG Backpacks";
        };
    	if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
    		_txt = _cls call OT_fnc_magazineGetName;
    		_pic = _cls call OT_fnc_magazineGetPic;
    		_desc = _cls call OT_fnc_magazineGetDescription;
    	};
    	if(isClass (configFile >> "CfgGlasses" >> _cls)) exitWith {
    		_txt = gettext(configFile >> "CfgGlasses" >> _cls >> "displayName");
    		_pic = gettext(configFile >> "CfgGlasses" >> _cls >> "picture");
    	};
    	if(_cls in (OT_allVehicles + OT_allBoats)) exitWith {
    		_txt = _cls call OT_fnc_vehicleGetName;
    		_pic = getText(configFile >> "cfgVehicles" >> _cls >> "editorPreview");
    		_desc = getText(configFile >> "cfgVehicles" >> _cls >> "Library" >> "libTextDesc");

            if(_cls == "C_Quadbike_01_F") then {
                _desc = "Gets you from A to B, not guaranteed to stay upright.";
            };
    	};
    	if(_cls isKindOf "Bag_Base") exitWith {
    		_txt = _cls call OT_fnc_vehicleGetName;
    		_pic = _cls call OT_fnc_vehicleGetPic;
    		_desc = _cls call OT_fnc_vehicleGetDescription;
    	};
    	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) then {
    		_txt = _cls call OT_fnc_weaponGetName;
    		_pic = _cls call OT_fnc_weaponGetPic;
    		_desc = format["%1<br/>%2",getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort"),_cls call OT_fnc_magazineGetDescription];
    	};

    	if(_cls isKindOf "Man") exitWith {
    		_txt = _cls call OT_fnc_vehicleGetName;
            _soldier = _cls call OT_fnc_getSoldier;
    		_price = _soldier select 0;
    		_desc = "Will recruit this soldier into your group fully equipped using the warehouse where possible.";
    	};
    	if(_cls in OT_allSquads) exitWith {
            _d = [];
            {
            	if((_x select 0) == _cls) exitWith {_d = _x};
            }foreach(OT_squadables);

            _comp = _d select 1;
            _price = 0;
            {
            	_s = OT_recruitables select _x;

            	_soldier = (_s select 0) call OT_fnc_getSoldier;
            	_price = _price + (_soldier select 0);
            }foreach(_comp);

    		_txt = _cls;
    		_desc = "Will recruit this squad into your High-Command bar, accessible with ctrl-space.";
    	};
    };
}else{
    ctrlEnable [1600,false];
    _desc = _cls;
    _txt = "Not Available";
    _price = "";
};
if !(isNil "_pic") then {
	ctrlSetText [1200,_pic];
};

if(_cls in OT_allExplosives) then {
    _cost = cost getVariable _cls;
    _chems = server getVariable ["reschems",0];
    _desc = format["Required: %1 x chemicals (%2 available)<br/>%3",_cost select 3,_chems,_desc];
};

_textctrl = (findDisplay 8000) displayCtrl 1100;

_textctrl ctrlSetStructuredText parseText format["
	<t align='center' size='1.5'>%1</t><br/>
	<t align='center' size='1.2'>%3</t><br/><br/>
	<t align='center' size='0.8'>%2</t>
",_txt,_desc,_price];
