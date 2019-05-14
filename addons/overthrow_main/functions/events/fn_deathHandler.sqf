_me = _this select 0;
_killer = _me getVariable "ace_medical_lastDamageSource";

if(isNil "_killer") then {_killer = _this select 1};

if((vehicle _killer) != _killer) then {_killer = driver _killer};

if(_killer call OT_fnc_unitSeen) then {
	_killer setVariable ["lastkill",time,true];
};
_town = (getpos _me) call OT_fnc_nearestTown;

if(isPlayer _me) exitWith {
	if !(isMultiplayer) then {
		_this params ["_unit", "_killer", "_instigator", "_useEffects"];
		if (_unit isEqualTo player) then {
			cutText ["", "BLACK FADED", 15];
			private _new_unit = (creategroup resistance) createUnit ["I_G_Soldier_F",(player getVariable ["home",[worldSize/2,worldSize/2,0]]),[],0,"NONE"];
			selectPlayer _new_unit;

			player setCaptive true;
			player forceAddUniform (player getVariable ["uniform",""]);
			player setdamage 0;
			[] spawn {
				sleep 0.5;
				player setpos (player getVariable "home");
				removeAllWeapons player;
				removeAllItems player;
				removeAllAssignedItems player;
				removeBackpack player;
				removeVest player;
				removeGoggles player;
				removeHeadgear player;
				player setDamage 0;
				player linkItem "ItemMap";
				player switchMove "";
				cutText ["", "BLACK IN", 5];
			};
		};
	};
};

_civ = _me getvariable "civ";
_garrison = _me getvariable "garrison";
_employee = _me getvariable "employee";
_vehgarrison = _me getvariable "vehgarrison";
_polgarrison = _me getvariable "polgarrison";
_airgarrison = _me getvariable "airgarrison";
_criminal = _me getvariable "criminal";
_crimleader = _me getvariable "crimleader";
_mobster = _me getvariable "mobster";
_mobboss = _me getvariable "mobboss";
_hvt = _me getvariable "hvt_id";
_reveal = false;

_standingChange = 0;

_bounty = _me getVariable ["OT_bounty",0];
if(_bounty > 0) then {
	[_killer,_bounty] call OT_fnc_rewardMoney;
	[_killer,_bounty] call OT_fnc_experience;
	_me setVariable ["OT_bounty",0,false];
};

call {
	if(!isNil "_civ") exitWith {
		_killer setVariable ["CIVkills",(_killer getVariable ["CIVkills",0])+1,true];
		_standingChange = -50;
		[_town,-1] call OT_fnc_stability;
	};
	if(!isNil "_hvt") exitWith {
		_killer setVariable ["BLUkills",(_killer getVariable ["BLUkills",0])+1,true];
		_idx = 0;
		{
			if((_x select 0) isEqualTo _hvt) exitWith {};
			_idx = _idx + 1;
		}foreach(OT_NATOhvts);
		OT_NATOhvts deleteAt _idx;
		format["A high-ranking NATO officer has been killed"] remoteExec ["OT_fnc_notifyMinor",0,false];
		server setvariable ["NATOresources",0,true];
		[_killer,250] call OT_fnc_experience;
	};
	if(!isNil "_employee") exitWith {
		_killer setVariable ["CIVkills",(_killer getVariable ["CIVkills",0])+1,true];
		_pop = server getVariable format["employ%1",_employee];
		if(_pop > 0) then {
			server setVariable [format["employ%1",_mobsterid],_pop - 1,true];
		};
		format["An employee of %1 has died",_employee] remoteExec ["OT_fnc_notifyMinor",0,false];
	};
	if(!isNil "_criminal") exitWith {
		_killer setVariable ["OPFkills",(_killer getVariable ["OPFkills",0])+1,true];
		_civid = _me getVariable ["OT_civid",-1];
		_gangid = _me getVariable ["OT_gangid",-1];
		_hometown = _me getVariable ["hometown",""];
		_reward = 50;
		_stability = 2;
		_standingChange = 1;
		if(_civid > -1) then {
			OT_civilians setVariable [format["%1",_civid],nil,true];

			if(_gangid > -1) then {
				_gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
				if(count _gang > 0) then {
					_members = _gang select 0;
					_members deleteAt (_members find _civid);
					_gang set [0,_members];
					OT_civilians setVariable [format["gang%1",_gangid],_gang,true];
				};
			};
		};

		[_hometown,_stability] call OT_fnc_stability;
		[_killer,_reward] call OT_fnc_rewardMoney;
		[_killer,10] call OT_fnc_experience;
	};
	if(!isNil "_crimleader") exitWith {
		_killer setVariable ["OPFkills",(_killer getVariable ["OPFkills",0])+1,true];
		_gangid = _me getVariable ["OT_gangid",-1];
		_civid = _me getVariable ["OT_civid",-1];
		_gangid = _me getVariable ["OT_gangid",-1];
		_hometown = _me getVariable ["hometown",""];
		_reward = 500 + ((round random 6) * 50);
		_stability = 10;
		_standingChange = 10;

		if(_gangid > -1) then {
			_gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
			if(count _gang > 0) then {
				OT_civilians setVariable [format["gang%1",_gangid],nil,true];
				_gangs = OT_civilians getVariable [format["gangs%1",_hometown],[]];
				_gangs deleteAt (_gangs find _gangid);
				OT_civilians setVariable [format["gangs%1",_hometown],_gangs,true];
				format["The gang leader in %1 has been eliminated",_hometown] remoteExec ["OT_fnc_notifyMinor",0,false];
				spawner setVariable [format["nogang%1",_hometown],time+3600,false]; //No gangs in this town for 1 hr real-time
				_mrkid = format["gang%1",_hometown];
				deleteMarker _mrkid;
			};
		};

		[_hometown,_stability] call OT_fnc_stability;
		[_killer,_reward] call OT_fnc_rewardMoney;
		[_killer,50] call OT_fnc_experience;
	};
	if(!isNil "_polgarrison") exitWith {
		_pop = server getVariable format["police%1",_polgarrison];
		if(_pop > 0) then {
			server setVariable [format["police%1",_polgarrison],_pop - 1,true];
			format["A police officer has been killed in %1",_polgarrison] remoteExec ["OT_fnc_notifyMinor",0,false];
		};
		[_town,-2] call OT_fnc_stability;
	};
	if(!isNil "_garrison" || !isNil "_vehgarrison" || !isNil "_airgarrison") then {
		_killer setVariable ["BLUkills",(_killer getVariable ["BLUkills",0])+1,true];
		if(!isNil "_garrison") then {
			server setVariable ["NATOresourceGain",(server getVariable ["NATOresourceGain",0])+1,true];
			_pop = server getVariable [format["garrison%1",_garrison],0];
			if(_pop > 0) then {
				_pop = _pop -1;
				server setVariable [format["garrison%1",_garrison],_pop,true];
			};
			if(_garrison in OT_allTowns) then {
				_town = _garrison;
				[_killer,10] call OT_fnc_experience;
			}else{
				[_killer,25] call OT_fnc_experience;
			};
			_reveal = true;
			_townpop = server getVariable [format["population%1",_town],0];
			_stab = -1;
			if(_townpop < 350 && (random 100) > 50) then {
				_stab = -2;
			};
			if(_townpop < 100) then {
				_stab = -3;
			};
			if (_garrison in OT_allTowns) then {
				[_garrison,_stab] call OT_fnc_stability;
			};
		};

		if(!isNil "_vehgarrison") then {
			_vg = server getVariable format["vehgarrison%1",_vehgarrison];
			_vg deleteAt (_vg find (typeof _me));
			server setVariable [format["vehgarrison%1",_vehgarrison],_vg,false];
		};

		if(!isNil "_airgarrison") then {
			_vg = server getVariable format["airgarrison%1",_airgarrison];
			_vg deleteAt (_vg find (typeof _me));
			server setVariable [format["airgarrison%1",_airgarrison],_vg,false];
		};
	}else{
		if(side _me isEqualTo west) then {
			[_town,-1] call OT_fnc_stability;
		};
		if(side _me isEqualTo east) then {
			[_town,1] call OT_fnc_stability;
		};
	};
};
if((_killer call OT_fnc_unitSeen) || (_standingChange < -9)) then {
	_killer setCaptive false;
	if(vehicle _killer != _killer) then {
		{
			_x setCaptive false;
		}foreach(units vehicle _killer);
	};
};
if(isPlayer _killer) then {
	if (_standingChange isEqualTo -50) then {
		[_town,_standingChange,"You killed a civilian",_killer] call OT_fnc_support;
	}else{
		[_town,_standingChange] call OT_fnc_support;
	};
}else{
	if(side _killer isEqualTo resistance) then {
		[_town,_standingChange] call OT_fnc_support;
	};
};
