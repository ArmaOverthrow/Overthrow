if(OT_jobShowingType isEqualTo "resistance") exitWith {
    call OT_fnc_requestJobResistance;
};
if(OT_jobShowingType isEqualTo "faction") exitWith {
    call OT_fnc_requestJobFaction;
};
if(OT_jobShowingType isEqualTo "shop") exitWith {
    call OT_fnc_requestJobShop;
};
if(OT_jobShowingType isEqualTo "gang") exitWith {
    call OT_fnc_requestJobGang;
};
