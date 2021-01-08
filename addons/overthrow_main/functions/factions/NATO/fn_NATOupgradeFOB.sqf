params ["_pos","_upgrades"];

{
    if(_x isEqualTo "Barriers") then {
        _p = _pos getPos [8, 0];
        _v = OT_NATO_Barrier_Small createVehicle _p;
        _v setDir 180;

        sleep 0.3;

        _p = _pos getPos [8, 100];
        _v = OT_NATO_Barrier_Small createVehicle _p;
        _v setDir 0;

        sleep 0.3;

        _p = _pos getPos [7, 270];
        _v = OT_NATO_Barrier_Large createVehicle _p;
        _v setDir 270;

        sleep 0.3;

        _p = _pos getPos [7, 90];
        _v = OT_NATO_Barrier_Large createVehicle _p;
        _v setDir 90;
    };
    if(_x isEqualTo "HMG") then {
        _gun = OT_NATO_StaticGarrison_LevelOne select 0;

        _p = _pos getPos [8.5, 45];
        _v = _gun createVehicle _p;
        _v setDir 45;
        createVehicleCrew _v;

        sleep 0.3;

        _p = _pos getPos [10, 45];
        _v = OT_NATO_Sandbag_Curved createVehicle _p;
        _v setDir 225;

        _p = _pos getPos [8.5, 135];
        _v = _gun createVehicle _p;
        _v setDir 135;
        createVehicleCrew _v;

        sleep 0.3;

        _p = _pos getPos [10, 135];
        _v = OT_NATO_Sandbag_Curved createVehicle _p;
        _v setDir 315;

        _p = _pos getPos [8.5, 225];
        _v = _gun createVehicle _p;
        _v setDir 225;
        createVehicleCrew _v;

        sleep 0.3;

        _p = _pos getPos [10, 225];
        _v = OT_NATO_Sandbag_Curved createVehicle _p;
        _v setDir 45;

        _p = _pos getPos [8.5, 315];
        _v = _gun createVehicle _p;
        _v setDir 315;
        createVehicleCrew _v;

        sleep 0.3;

        _p = _pos getPos [10, 315];
        _v = OT_NATO_Sandbag_Curved createVehicle _p;
        _v setDir 135;
    };
    if(_x isEqualTo "Mortar") then {
        _p = _pos findEmptyPosition [5,50,OT_NATO_Mortar];
        _v = OT_NATO_Mortar createVehicle _p;
        createVehicleCrew _v;

        _g = grpNull;
        {
            _x disableAI "AUTOTARGET";
            _x disableAI "FSM";
            _x disableAI "AUTOCOMBAT";
            _x setVariable ["NOAI",true,false];
            _g = group _x;
        }foreach(crew _v);
        _g setCombatMode "BLUE";
        [_v,_g] spawn OT_fnc_NATOMortar;
    };

    sleep 0.3;
}foreach(_upgrades);
