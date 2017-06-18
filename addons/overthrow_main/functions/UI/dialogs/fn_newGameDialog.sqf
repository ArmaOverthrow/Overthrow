disableSerialization;

server setVariable ["generals",[getplayeruid player],true];

private _diff = server getVariable ["OT_difficulty",1];
private _ft = server getVariable ["OT_fastTravelType",1];

if(_diff == 0) then {
    (findDisplay 8099) displayCtrl 1600 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1601 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1602 ctrlSetTextColor [1,1,1,1];
};
if(_diff == 1) then {
    (findDisplay 8099) displayCtrl 1600 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1601 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1602 ctrlSetTextColor [1,1,1,1];
};
if(_diff == 2) then {
    (findDisplay 8099) displayCtrl 1600 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1601 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1602 ctrlSetTextColor [0,0.8,0,1];
};

if(_ft == 0) then {
    (findDisplay 8099) displayCtrl 1603 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1604 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1605 ctrlSetTextColor [1,1,1,1];
};
if(_ft == 1) then {
    (findDisplay 8099) displayCtrl 1603 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1604 ctrlSetTextColor [0,0.8,0,1];
    (findDisplay 8099) displayCtrl 1605 ctrlSetTextColor [1,1,1,1];
};
if(_ft == 2) then {
    (findDisplay 8099) displayCtrl 1603 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1604 ctrlSetTextColor [1,1,1,1];
    (findDisplay 8099) displayCtrl 1605 ctrlSetTextColor [0,0.8,0,1];
};
