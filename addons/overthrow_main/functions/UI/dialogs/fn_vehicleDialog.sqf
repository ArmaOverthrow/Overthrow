
private _ft = server getVariable ["OT_fastTravelType",1];
if(!OT_adminMode && _ft > 1) then {
	ctrlEnable [1600,false];
};

private _veh = vehicle player;

private _isgen = call OT_fnc_playerIsGeneral;

if !(_veh call OT_fnc_playerIsOwner) then {
    ctrlEnable [1605,false];
}else{
    if(_veh getVariable ["OT_locked",false]) then {
        ctrlSetText [1605,"Unlock Vehicle"];
    };
};

if !(typeOf _veh == "OT_I_Truck_recovery") then {
	ctrlShow [1614, false];
};
