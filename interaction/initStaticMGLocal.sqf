private ["_wpn"];
_wpn = _this;
if !(_wpn getVariable ["actioned",false]) then {
	_wpn addAction ["Rearm",{		
		_w = _this select 0;
		_p = _this select 1;
		if(_p call unitSeen) then {
			_p setCaptive false;
		};
		_ammocount = {_x == AIT_ammo_50cal} count (magazineCargo _p);
		if(_ammocount >= 4) then {
			disableUserInput true;
			_p removeMagazineGlobal AIT_ammo_50cal;
			_p removeMagazineGlobal AIT_ammo_50cal;
			_p removeMagazineGlobal AIT_ammo_50cal;
			_p removeMagazineGlobal AIT_ammo_50cal;
			_w spawn {					
				"Rearming MG..." call notify_minor;
				[15,false] call progressBar;
				sleep 15;
				[_this,1] remoteExec ["setVehicleAmmoDef",_this];
				"MG rearmed" call notify_minor;
				disableUserInput false;
			};				
		}else{
			"You need 4 x 12.7mm M2 HMG Belts to rearm this MG" call notify_minor;
		};			
	},[],1.5,false,true,"","(alive _target)",5];
	_wpn setVariable ["actioned",true,false];
};