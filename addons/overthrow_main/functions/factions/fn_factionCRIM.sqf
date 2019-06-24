//cache loadouts
{
    private _gangs = OT_civilians getVariable [format["gangs%1",_x],[]];
    if(count _gangs > 0) then {
        private _gangid = _gangs select 0;
        private _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
        if(_gang isEqualType []) then {
            private _loadout = [];
            if(count _gang > 5) then {
                //new gang format (0.7.8.5) with loadout
                if(count _gang < 9) then {
                    //gang upgrade (0.7.8.6)
                    private _town = _gang select 2;
                    _gang pushback 0; //resources
                    _gang pushback 1; //level
                    _gang pushback format[selectRandom OT_gangNames,_town,OT_nation]; //name

                    OT_civilians setVariable [format["gang%1",_gangid],_gang,true];
                };
            }else{
                //old gang format, generate one
                _vest = _gang select 3;
                _weapon = selectRandom (OT_CRIM_Weapons + OT_allCheapRifles);
                _loadout = [(format["gang%1",_gangid]),OT_CRIMBaseLoadout,[[_weapon]]] call OT_fnc_getRandomLoadout;
                (_loadout select 4) set [0,_vest];

                _gang pushback _loadout;
                _gang pushback 0; //resources
                _gang pushback 1; //level
                _gang pushback format[selectRandom OT_gangNames,_town,OT_nation]; //name
                OT_civilians setVariable [format["gang%1",_gangid],_gang,true];
            };
            if !((_gang select 5) isEqualType []) then {
                _weapon = selectRandom (OT_CRIM_Weapons + OT_allCheapRifles);
                _loadout = [(format["gang%1",_gangid]),OT_CRIMBaseLoadout,[[_weapon]]] call OT_fnc_getRandomLoadout;
                _gang set [5,_loadout];
                OT_civilians setVariable [format["gang%1",_gangid],_gang,true];
            };
        };
    };
}foreach(OT_allTowns);

crim_counter = 12;
["faction_crim_loop","_counter%10 isEqualTo 0","call OT_fnc_CRIMLoop"] call OT_fnc_addActionLoop;
