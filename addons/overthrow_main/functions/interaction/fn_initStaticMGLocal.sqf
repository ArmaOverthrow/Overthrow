private ["_wpn"];
_wpn = _this;
if !(_wpn getVariable ["actioned",false]) then {
	_wpn addAction ["Rearm",{		
		_w = _this select 0;
		_p = _this select 1;
		if(_p call OT_fnc_unitSeen) then {
			_p setCaptive false;
		};
		_ammocount = {_x isEqualTo OT_ammo_50cal} count (magazineCargo _p);
		if(_ammocount >= 4) then {
			disableUserInput true;
			_p removeMagazineGlobal OT_ammo_50cal;
			_p removeMagazineGlobal OT_ammo_50cal;
			_p removeMagazineGlobal OT_ammo_50cal;
			_p removeMagazineGlobal OT_ammo_50cal;
			_w spawn {					
				"Rearming MG..." call OT_fnc_notifyMinor;
				[15,false] call OT_fnc_progressBar;
				sleep 15;
				[_this,1] remoteExec ["setVehicleAmmoDef",_this,_this];
				"MG rearmed" call OT_fnc_notifyMinor;
				disableUserInput false;
			};				
		}else{
			"You need 4 x 12.7mm M2 HMG Belts to rearm this MG" call OT_fnc_notifyMinor;
		};			
	},[],1.5,false,true,"","(alive _target)",5];
	_wpn setVariable ["actioned",true,false];
};