private _town = (getpos player) call OT_fnc_nearestTown;

_stock = server getVariable format["gunstock%1",_town];
if(isNil "_stock") then {
	_numguns = round(random 7)+3;
	_count = 0;
	_stock = [[OT_item_BasicGun,25],[OT_item_BasicAmmo,1]];

	_stock pushback [OT_ammo_50cal,100];

	_p = (cost getVariable "I_HMG_01_high_weapon_F") select 0;
	_p = _p + ((cost getVariable "I_HMG_01_support_high_F") select 0);
	private _quad = ((cost getVariable "C_Quadbike_01_F") select 0) + 60;
	_p = _p + _quad;
	_p = _p + 50; //Convenience cost

	_stock pushback ["Set_HMG",_p];

	_stock pushback ["C_Quadbike_01_F",_quad];

	{
		_cost = cost getVariable _x;
		_price = _cost select 0;
		_stock pushBack [_x,_price];
	}foreach(OT_allStaticBackpacks);

	_tostock = [];
	while {_count < _numguns} do {
		_type = OT_allWeapons call BIS_fnc_selectRandom;
		if !(_type in _tostock) then {

			_tostock pushBack _type;
			_count = _count + 1;
			_cost = cost getVariable _type;
			_price = round((_cost select 0) * ((random 2) + 1));
			_stock pushBack [_type,_price];

			_base = [_type] call BIS_fnc_baseWeapon;
			_magazines = getArray (configFile / "CfgWeapons" / _base / "magazines");
			_price = 2;
			if(_type in OT_allSubMachineGuns) then {
				_price = 3;
			};
			if(_type in OT_allAssaultRifles) then {
				_price = 5;
				if((_cost select 0) > 1400) then {
					_price = 10;
				};
			};
			if(_type in OT_allMachineGuns) then {
				_price = 12;
			};
			if(_type in OT_allSniperRifles) then {
				_price = 20;
			};
			if(_type in OT_allRocketLaunchers) then {
				_price = 50;
			};
			if(_type in OT_allMissileLaunchers) then {
				_price = 100;
			};
			_stock pushBack [_magazines call BIS_fnc_selectRandom,_price];
		};
	};

	{
		_cost = cost getVariable _x;
		_price = _cost select 0;
		_stock pushBack [_x,_price];
	}foreach(OT_allOptics);

	{
		_price = round (([_town,_x] call OT_fnc_getDrugPrice) * 0.9);
		_stock pushBack [_x,_price];
	}foreach(OT_allDrugs);

	server setVariable [format["gunstock%1",_town],_stock,true];
};

createDialog "OT_dialog_buy";
{
	_cls = _x select 0;
	_price = _x select 1;
	if !(isNil "_cls") then {
		_txt = _cls;
		_pic = "";

		call {
			if(_cls == "Set_HMG") exitWith {
				_txt = "Quadbike w/ HMG Backpacks";
				_pic = "C_Quadbike_01_F" call OT_fnc_magazineGetPic;
			};
			if(_cls isKindOf ["CA_Magazine",configFile >> "CfgMagazines"]) exitWith {
				_txt = format["--- %1",_cls call OT_fnc_magazineGetName];
				_pic = _cls call OT_fnc_magazineGetPic;
			};
			if(_cls in OT_allStaticBackpacks) exitWith {
				_txt = format["--- %1",_cls call OT_fnc_vehicleGetName];
				_pic = _cls call OT_fnc_vehicleGetPic;
			};
			if(_cls isKindOf "Land") exitWith {
				_txt = format["%1",_cls call OT_fnc_vehicleGetName];
				_pic = _cls call OT_fnc_vehicleGetPic;
			};
			_txt = _cls call OT_fnc_weaponGetName;
			_pic = _cls call OT_fnc_weaponGetPic;
		};
		_idx = lbAdd [1500,format["%1",_txt]];
		lbSetData [1500,_idx,_cls];
		lbSetValue [1500,_idx,_price];
		lbSetPicture [1500,_idx,_pic];
	};
}foreach(_stock);
