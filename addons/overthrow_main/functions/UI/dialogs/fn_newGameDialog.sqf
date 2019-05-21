disableSerialization;

server setVariable ["generals",[getplayeruid player],true];

private _diff = server getVariable ["OT_difficulty",1];
private _ft = server getVariable ["OT_fastTravelType",1];
private _ftr = server getVariable ["OT_fastTravelRules",_diff];

if(_diff isEqualTo 0) then {
    (findDisplay 8099) displayCtrl 1600 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1601 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1602 ctrlSetTextColor [1,1,1,1];
};
if(_diff isEqualTo 1) then {
    (findDisplay 8099) displayCtrl 1600 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1601 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1602 ctrlSetTextColor [1,1,1,1];
};
if(_diff isEqualTo 2) then {
    (findDisplay 8099) displayCtrl 1600 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1601 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1602 ctrlSetTextColor [0,0.8,0,1];
};

if(_ft isEqualTo 0) then {
    (findDisplay 8099) displayCtrl 1603 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1604 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1605 ctrlSetTextColor [1,1,1,1];
};
if(_ft isEqualTo 1) then {
    (findDisplay 8099) displayCtrl 1603 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1604 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1605 ctrlSetTextColor [1,1,1,1];
};
if(_ft isEqualTo 2) then {
    (findDisplay 8099) displayCtrl 1603 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1604 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1605 ctrlSetTextColor [0,0.8,0,1];
};

if(_ftr isEqualTo 0) then {
    (findDisplay 8099) displayCtrl 1607 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1608 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1609 ctrlSetTextColor [1,1,1,1];
};
if(_ftr isEqualTo 1) then {
    (findDisplay 8099) displayCtrl 1607 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1608 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1609 ctrlSetTextColor [1,1,1,1];
};
if(_ftr isEqualTo 2) then {
    (findDisplay 8099) displayCtrl 1607 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1608 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1609 ctrlSetTextColor [0,0.8,0,1];
};
