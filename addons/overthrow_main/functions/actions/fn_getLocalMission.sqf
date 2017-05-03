private _faction = "PLAYER";
private _factionName = "Tanoa";
private _haveMission = player getVariable [format["MissionData%1",_faction],[]];
if(count _haveMission > 0) exitWith {"You already have an active mission for the resistance" call OT_fnc_notifyMinor};
private _standing = 1;

if(_faction != OT_currentMissionFaction) then {OT_currentMissionData = nil};

private _data = [];
OT_currentMissionFaction = _faction;
OT_currentMissionFactionName = _factionName;

if(isNil "OT_currentMissionData") then {
    private _missionCode = selectRandom OT_localMissions;
    _data = call _missionCode;
    OT_currentMissionData = _data;
}else{
    _data = OT_currentMissionData;
};
private _difficulty = _data select 7;
private _rewardMoney = round(_difficulty * 500);
if(_rewardMoney < 250) then {_rewardMoney = 250};
OT_currentMissionRewards = [0,_rewardMoney];

private _txt = _data select 0;
private _description = format["<t size='0.8' align='center'>%3<br/><br/></t><t size='0.65'>%1<br/><br/></t><t size='0.8'>Reward: $%2<br/>Influence: +5</t>",_txt select 1,_rewardMoney,_txt select 0];

private _options = [_description];

_options pushback ["Accept",{
    player setVariable [format["MissionData%1",OT_currentMissionFaction],OT_currentMissionData,false];

    OT_currentMissionData params ["_description","_markerPos","_code","_fail","_success","_finish","_params"];
    _title = _description select 0;
    _title = format["(%1) %2",OT_currentMissionFactionName,_title];
    _description = _description select 1;
    [player,_markerPos,_title,_description,{
        params ["_target","_pos","_p","_wassuccess"];
        _p params ["_missionParams","_faction","_factionName","_finish","_rewards"];
        player setVariable [format["MissionData%1",_faction],[],false];
        _this call _finish;
    },_success,OT_currentMissionRewards select 1,5,_fail,[OT_currentMissionData select 6,OT_currentMissionFaction,OT_currentMissionFactionName,OT_currentMissionData select 5,OT_currentMissionRewards]] spawn OT_fnc_assignMission;

    [OT_currentMissionData select 6,OT_currentMissionFaction,OT_currentMissionFactionName] spawn (OT_currentMissionData select 2);
}];

_options pushback ["Decline",{
    //clear this mission so a new one will generate
    OT_currentMissionData = nil;
    [] call OT_fnc_getLocalMission;
}];

_options pushback ["Cancel",{
    OT_currentMissionData = nil;
}];

_options spawn playerDecision;
