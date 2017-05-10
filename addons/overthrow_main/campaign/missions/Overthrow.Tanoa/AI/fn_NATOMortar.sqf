params ["_mortar","_mortargroup"];

while {sleep 5+(random 5); ("8Rnd_82mm_Mo_shells" in getArtilleryAmmo[_mortar]) and (alive _mortar) and ({alive _x} count (units _mortargroup)) > 0} do {
    private _attacking = server getVariable ["NATOattacking",""];
    if(_attacking != "" and !(_attacking in OT_allTowns)) then {
        _pos = server getvariable _attacking;
        _distance = (_pos distance _mortar);

        _timesince = time - (server getVariable ["NATOattackstart",time]);
        if(_timesince < 300) then {
            if (_distance < 4000 and _distance > 500) then {
                _mortargroup setCombatMode "RED";
                _p = [[[_pos,300]]] call SHK_pos;
                _mortar commandArtilleryFire [_p, "8Rnd_82mm_Mo_shells", 1];
                sleep 3+(random 3);
                _mortar commandArtilleryFire [_p, "8Rnd_82mm_Mo_shells", 1];
                sleep 3;
                _mortargroup setCombatMode "BLUE";
            };
        };
    }else{
        private _targets = [spawner getVariable ["NATOknownTargets",[]],[],{_x select 2},"DESCEND"] call BIS_fnc_SortBy;
        {
            _x params ["_ty","_pos","_pri","_obj","_done"];
            _distance = (_pos distance _mortar);
            if (_distance < 4000 and _distance > 250 and !_done) exitWith {
                _x set [4,true];
                _mortargroup setCombatMode "RED";

                _mortar commandArtilleryFire [_pos, "8Rnd_82mm_Mo_shells", 1];
                sleep 3+(random 3);
                _mortar commandArtilleryFire [_pos, "8Rnd_82mm_Mo_shells", 1];
                sleep 3+(random 3);
                _mortar commandArtilleryFire [_pos, "8Rnd_82mm_Mo_shells", 1];
                sleep 3;
                _mortargroup setCombatMode "BLUE";
            };
        }foreach(_targets);
        spawner setVariable ["NATOknowntargets",_targets,true];
    };
};
