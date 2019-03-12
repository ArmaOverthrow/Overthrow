private _ob = (position player) call OT_fnc_nearestObjective;
private _dist = (_ob select 0) distance player;
private _name = _ob select 1;

if (_dist < 250 && _name in (server getVariable ["NATOabandoned",[]])) then {
	[] call OT_fnc_buyVehicleDialog;
}else{
    _b = (position player) call OT_fnc_nearestLocation;
	if((_b select 1) isEqualTo "Business") then {
        [] call OT_fnc_buyBusiness;
    }else{
        if((getpos player) distance OT_factoryPos < 150) then {
    		if (call OT_fnc_playerIsGeneral) then {
    			_name = "Factory";
    			_owned = server getVariable ["GEURowned",[]];
    			if(_owned find _name isEqualTo -1) then {
                    [] call OT_fnc_buyBusiness;
                }else{
                    [] call OT_fnc_factoryDialog;
                };
            };
        };
    };
};
