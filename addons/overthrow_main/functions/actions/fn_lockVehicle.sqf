private _veh = vehicle player;
if((_veh call OT_fnc_getOwner) != (getplayeruid player)) exitWith {};
if(_veh getVariable ["OT_locked",false]) then {
    _veh setVariable ["OT_locked",false,true];
    "Vehicle unlocked" call OT_fnc_notifyMinor;
}else{
    _veh setVariable ["OT_locked",true,true];
    "Vehicle locked" call OT_fnc_notifyMinor;
};
