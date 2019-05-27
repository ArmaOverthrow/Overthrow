params ["_unit","_identity"];

_identity params ["_face","_clothes","_name","_glasses"];

//Face
[_unit, _face] remoteExecCall ["setFace", 0, _unit];

//Clothes
if(isNil "_clothes") then {
    _clothes = selectRandom OT_clothes_locals;
};
_unit forceAddUniform _clothes;

//Name
private _firstname = OT_firstNames_local select (_name select 0);
private _lastname = OT_lastNames_local select (_name select 1);
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExecCall ["setName",0,_unit];

if(_glasses != "") then {
    _unit addGoggles _glasses;
};

//Voice (optional)
if(count _identity > 4) then {
    [_unit, _identity select 4] remoteExecCall ["setSpeaker", 0, _unit];
}else{
    [_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0, _unit];
};
