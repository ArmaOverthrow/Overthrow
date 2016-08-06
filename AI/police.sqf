private ["_town","_unit","_numweap","_skill","_unit","_magazine","_weapon","_onCivKilled","_onCivFiredNear","_handleDmg"];

_unit = _this select 0;

_town = _this select 1;

_unit setVariable ["garrison",_town,true];

_stability = server getVariable format["stability%1",_town];

_skill = 0.5;
if(_stability < 60) then {
	_skill = 0.6;
};
if(_stability < 50) then {
	_skill = 0.7;
};
if(_stability < 40) then {
	_skill = 0.8;
};
if(_stability < 30) then {
	_skill = 0.9;
};
_unit setSkill _skill;

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";

if(AIT_hasAce) then {
	_unit addItemToVest "ACE_fieldDressing";
	_unit addItemToVest "ACE_fieldDressing";
}else{
	_unit addItemToVest "FirstAidKit";
};

_numweap = (count AIT_NATO_weapons_Police)-1;
_idx = _numweap - 4;

if(_skill > 0.85) then {
	_idx = _numweap;
};

if(_skill > 0.8) then {
	_unit linkItem "NVGoggles_OPFOR";
	_unit addGoggles "G_Bandanna_aviator";
	_unit addWeapon "Rangefinder";
	_idx = _numweap - 1;
	if(AIT_hasAce) then {
		_unit addItemToUniform "ACE_rangeCard";
	};
}else{
	_unit addWeapon "Binoculars";
	if(_skill > 0.7) then {
		_idx = _numweap - 2;
		_unit addItemToVest "HandGrenade";
		_unit linkItem "ItemWatch";
		_unit addGoggles "G_Aviator";
	}else{
		if(_skill > 0.6) then {
			_idx = _numweap - 3;
			_unit linkItem "ItemGPS";
		};
	};
};

_weapon = AIT_NATO_weapons_Police select round(random(_idx));
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addWeapon _weapon;
_unit addPrimaryWeaponItem "acc_flashlight";

_weapon = AIT_NATO_weapons_Pistols call BIS_fnc_selectRandom;
_base = [_weapon] call BIS_fnc_baseWeapon;
_magazine = (getArray (configFile / "CfgWeapons" / _base / "magazines")) select 0;
_unit addMagazine _magazine;
_unit addMagazine _magazine;
_unit addWeapon _weapon;

if(_skill > 0.8) then {
	_unit addPrimaryWeaponItem "optic_Dms";
}else{	
	if(_skill > 0.7) then {
		_unit addPrimaryWeaponItem "optic_Mrco";
	}else{
		if(_skill > 0.6) then {
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
		}else{
			_unit addPrimaryWeaponItem "optic_Aco";
		};
	};
};

_handleDmg =  _unit addEventHandler ["HandleDamage",{
	_source = _this select 3;
	_dmg = _this select 2;
	if((vehicle _source) != _source) exitWith {_dmg * 0.05};
	_dmg
}];

_onCivKilled = _unit addEventHandler ["killed",{
	_me = _this select 0;
	_killer = _this select 1;
	_t = (getpos _me) call nearestTown;
	_pop = server getVariable format["garrison%1",_t];
	if(_pop > 0) then {
		server setVariable [format["garrison%1",_t],_pop - 1,true];
	};
	
	[_town,-2] call stability;

	if(_killer == _me) then {
		//was probably hit by a vehicle so we need to find the nearest player driver and blame him
		
	}else{
		if(isPlayer _killer) then {
			[_t,-1] remoteExec ["standing",_killer,true];			
			if(((blufor knowsAbout _killer) > 0) || ((vehicle _killer) != _killer)) then {
				_killer setCaptive false;
				
				//get on the blower to all your mates nearby
				{
					if((side _x == west) and (_x distance _killer < 2000)) then {
						_x reveal [_killer,1.5];
						_x setCombatMode "RED";						
						_x setBehaviour "COMBAT";
					};
				}foreach(allUnits);
			};			
		};
	};
}];



_onCivFiredNear = _unit addEventHandler["FiredNear",{
	//Make police break patrol when shots are fired
	_me = _this select 0;
	_firer = _this select 1;
	
	_group = group _me;
	_group setBehaviour "COMBAT";
	
	if(isPlayer _firer) then {		
		if((blufor knowsAbout _firer) > 0) then {
			_firer setCaptive false;
			
			//get on the blower to all your mates, cunt
			{
				if((side _x == west) and (_x distance _firer < 1000)) then {
					_x reveal [_firer,1.5];
					_x setCombatMode "RED";
					_x setBehaviour "COMBAT";
					_group = group _x;
				};
			}foreach(allUnits);
		}
	};
}];