closedialog 0;
createDialog "OT_dialog_logistics";
lbClear 1500;
{
    private _veh = _x;
    private _cls = typeof _veh;
    if((_veh call OT_fnc_hasOwner) && ((_cls isKindOf "LandVehicle") || (_cls isKindOf "Air") || (_cls isKindOf "Ship"))) then {
        private _name = _cls call OT_fnc_vehicleGetName;
        private _pic = _cls call OT_fnc_vehicleGetPic;
        private _dis = round(_veh distance player);
        private _t = "m";
        if(_dis > 999) then {
            _dis = (_dis / 1000) toFixed 1;
            _t = "km";
        };

        _idx = lbAdd [1500,format["%1 (%2%3)",_name,_dis,_t]];
        lbSetPicture [1500,_idx,_pic];
        lbSetData [1500,_idx,_veh call BIS_fnc_netId];
        private _color = [0.9,0.9,0.9,1];

        private _totalAmmo = 0;
        private _turrets = "!((configName _x) select [0,5] == ""Cargo"") && !((count getArray (_x >> ""magazines"")) isEqualTo 0)" configClasses (configfile >> "CfgVehicles" >> _cls >> "Turrets");
        private _hasAmmo = (count _turrets) > 0;
        {
            _x params ["_ammocls","_num"];
            _totalAmmo = _totalAmmo + _num;
        }foreach(magazinesAmmo _veh);

        private _lowFuel = (fuel _veh) < 0.2;

        if !(_veh call OT_fnc_vehicleCanMove) then {
            //red
            _color = [0.9,0.4,0.4,1];
        }else{
            if ((_hasAmmo && _totalAmmo isEqualTo 0) || _lowFuel) then {
                //yellow
                _color = [0.85,0.85,0,1];
            };
        };

        lbSetColor [1500,_idx,_color];
    };
}foreach([vehicles,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy);
