private _veh = _this;

private _added = false;
private _targets = spawner getVariable ["NATOknownTargets",[]];
private _target = nil;
{
    _o = _x select 3;
    if (_o isEqualTo _veh) then {
        _added = true;
        _target = _x;
    };
}foreach(_targets);

if(_added) exitWith {
    //Already know this threat, update it's position if it's old
    if((time - (_target select 5)) > 30) then {
        _target set [1,position _veh];
        _target set [5, time]; //reset timeout counter
        spawner setVariable ["NATOknownTargets",_targets,true];
    };
};

//determine threat
private _targetType = "V";
private _threat = 0;
private _ty = typeof _veh;

call {
    if(_ty in OT_allVehicleThreats) exitWith {
        _threat = 150;
    };
    if !(_veh getVariable ["OT_attachedClass",""] isEqualTo "") exitWith {
        _threat = 100;
    };
    if(_ty in OT_allPlaneThreats) exitWith {
        _targetType = "P";
        _threat = 500;
    };
    if(_ty in OT_allHeliThreats) exitWith {
        _targetType = "H";
        _threat = 300;
    };
};

_targets pushback [_targetType,position _veh,_threat,_veh,false,time];
spawner setVariable ["NATOknownTargets",_targets,true];
