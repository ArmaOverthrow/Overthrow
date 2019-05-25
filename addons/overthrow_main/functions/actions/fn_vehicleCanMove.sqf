private _canMove = true;
private _veh = _this;
{
    private _hit = configName _x;
    if(((_hit find "Wheel") > -1) || ((_hit find "Track") > -1) || _hit isEqualTo "HitFuel" || _hit isEqualTo "HitEngine" || _hit isEqualTo "HitVRotor" || _hit isEqualTo "HitHRotor") then {
    	if (_veh getHitPointDamage _hit >= 1) exitWith {
    		_canMove = false;
    	};
    };
} forEach ("true" configClasses (configfile >> "CfgVehicles" >> (typeof _veh) >> "HitPoints"));
if((fuel _veh) isEqualTo 0) then {_canMove = false};
_canMove
