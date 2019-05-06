params ["_town"];

_gangs = OT_civilians getVariable [format["gangs%1",_town],[]];
_townpos = server getVariable _town;

if(count _gangs > 0) then {
    //make a gang larger (maybe)
    _gangid = _gangs select 0;
    _gang = OT_civilians getVariable [format["gang%1",_gangid],[]];
    if(_gang isEqualTo "") exitWith {
        //cleanup old gangs
        _gangs deleteAt (_gangs find _gangid);
        OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
    };
    if((count (_gang select 0)) < 15) then {
      if(count _gang > 4) then {
          [_gangid,1] call OT_fnc_addToGang;
      }else{
          //remove old gang
          _gangs deleteAt (_gangs find _gangid);
          OT_civilians setVariable [format["gangs%1",_town],_gangs,true];
      };
    };
}else{
    //form a gang
    private _gangid = [_town] call OT_fnc_formGang;
    if(_gangid > -1) then {
        [_gangid] call OT_fnc_addToGang;
    };
};
