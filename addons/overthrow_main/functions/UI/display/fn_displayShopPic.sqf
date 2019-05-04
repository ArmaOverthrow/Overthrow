disableSerialization;
params ["_ctrl","_index"];

private _cls = _ctrl lbData _index;
private _price = _ctrl lbValue _index;

private _pic = "";
private _txt = "";
private _desc = "";
if(_price > -1) then {
    ctrlEnable [1600,true];
    private _res = [_cls] call {
		params ["_cls"];
        if(_cls == "Set_HMG") exitWith {
			[
				getText(configFile >> "cfgVehicles" >> "C_Quadbike_01_F" >> "editorPreview"),
            	"A Quad-bike containing the backpacks required to set up a Static HMG",
            	"Quad Bike w/ HMG Backpacks"
			]
        };
    	if(_cls isKindOf ["Default",configFile >> "CfgMagazines"]) exitWith {
    		[
				_cls call OT_fnc_magazineGetPic,
    			_cls call OT_fnc_magazineGetName,
    			_cls call OT_fnc_magazineGetDescription
			]
    	};
    	if(isClass (configFile >> "CfgGlasses" >> _cls)) exitWith {
    		[
				gettext(configFile >> "CfgGlasses" >> _cls >> "picture"),
				nil,
    			gettext(configFile >> "CfgGlasses" >> _cls >> "displayName")
			]
    	};
    	if(isClass (configFile >> "CfgVehicles" >> _cls)) exitWith {
    		[
				getText(configFile >> "cfgVehicles" >> _cls >> "editorPreview"),
				[
					getText(configFile >> "cfgVehicles" >> _cls >> "Library" >> "libTextDesc"),
					"Gets you from A to B, not guaranteed to stay upright."
				] select (_cls == "C_Quadbike_01_F"),
				_cls call OT_fnc_vehicleGetName
			]
    	};
    	if(_cls isKindOf "Bag_Base") exitWith {
    		[
				_cls call OT_fnc_vehicleGetPic,
				_cls call OT_fnc_vehicleGetDescription,
				_cls call OT_fnc_vehicleGetName
			]
    	};
    	if(_cls isKindOf ["Default",configFile >> "CfgWeapons"]) exitWith {
    		[
				_cls call OT_fnc_weaponGetPic,
    			format["%1<br/>%2",getText(configFile >> "CfgWeapons" >> _cls >> "descriptionShort"),_cls call OT_fnc_magazineGetDescription],
    			_cls call OT_fnc_weaponGetName
			]
    	};

    	if(_cls isKindOf "Man") exitWith {
            private _soldier = _cls call OT_fnc_getSoldier;
    		private _price = _soldier select 0;

            _price = format["$%1",_price];
    		[
				nil,
    			"Will recruit this soldier into your group fully equipped using the warehouse where possible.",
				_cls call OT_fnc_vehicleGetName,
				_price
			]
    	};
    	if(_cls in OT_allSquads) exitWith {
            private _d = [];
            {
            	if((_x select 0) isEqualTo _cls) exitWith {_d = _x};
            }foreach(OT_squadables);

            private _comp = _d select 1;
            private _p = 0;
            {
            	private _s = OT_recruitables select _x;
            	private _soldier = (_s select 0) call OT_fnc_getSoldier;
            	_p = _p + (_soldier select 0);
            }foreach(_comp);

            _price = format["$%1",_p];

			[
				nil,
    			"Will recruit this squad into your High-Command bar, accessible with ctrl-space.",
				_cls,
				_price
			]
    	};
    };
	_pic = _res param [0, ""];
	_desc = _res param [1, ""];
	_txt = _res param [2, ""];
	_price = _res param [3, _price];
}else{
    ctrlEnable [1600,false];
    _desc = _cls;
    _txt = "Not Available";
    _price = "";
};
if(!isNil "_pic" && { !(_pic isEqualTo "") }) then {
	ctrlSetText [1200,_pic];
};

if(_cls in OT_allExplosives) then {
    _cost = cost getVariable _cls;
    _chems = server getVariable ["reschems",0];
    _desc = format["Required: %1 x chemicals (%2 available)<br/>%3",_cost select 3,_chems,_desc];
};

_textctrl = (findDisplay 8000) displayCtrl 1100;

_price = "$" + ([_ctrl lbValue _index, 1, 0, true] call CBA_fnc_formatNumber);

_textctrl ctrlSetStructuredText parseText format["
	<t align='center' size='1.5'>%1</t><br/>
	<t align='center' size='1.2'>%3</t><br/><br/>
	<t align='center' size='0.8'>%2</t>
",_txt,_desc,_price];
