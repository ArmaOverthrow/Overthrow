//This sets all the default settings for the AI
_Unit = _this select 0;

_Unit addEventHandler ["Killed",{_this call VCOMAI_ClosestAllyWarn;}];
_Unit addEventHandler ["Fired",{[_this] call VCOMAI_SuppressingShots;}];
_Unit addEventHandler ["Fired",{[_this] call VCOMAI_HearingAids;}];
_Unit addEventHandler ["Hit",{_this call VCOMAI_AiHit;}];


_Unit setVariable ["VCOM_CHANGEDFORMATION",false,false];
_Unit setVariable ["VCOM_MOVINGTOSUPPORT",false,false];
_Unit setVariable ["VCOM_GARRISONED",false,false];
_Unit setVariable ["VCOM_SubLeader",false,false];
_Unit setVariable ["VCOM_GroupLeader",false,false];
_Unit setVariable ["VCOM_FLANKING",false,false];
_Unit setVariable ["VCOM_MovedRecently",false,false];
_Unit setVariable ["VCOM_MovedRecentlyCover",false,false];
_Unit setVariable ["VCOM_GRENADETHROWN",false,false];
_Unit setVariable ["VCOM_FiredTime",diag_ticktime,false];
_Unit setVariable ["VCOM_FiredTimeHearing",diag_ticktime,false];
_Unit setVariable ["VCOM_Suppressed",false,false];
_Unit setVariable ["VCOM_HASDEPLOYED",false,false];
_Unit setVariable ["VCOM_HASSTATIC",false,false];
_Unit setVariable ["VCOM_DiagLastCheck",diag_ticktime,false];
_Unit setVariable ["VCOM_HASSATCHEL",false,false];
_Unit setVariable ["VCOM_SATCHELRECENTLY",false,false];
_Unit setVariable ["VCOM_CALLEDARTILLERY",false,false];
_Unit setVariable ["VCOM_ISARTILLERY",false,false];
_Unit setVariable ["VCOM_AssignedEnemy",[0,0,0],false];
_Unit setVariable ["Vcom_MineObject",[],false];
_Unit setVariable ["VCOM_HasMine",false,false];
_Unit setVariable ["VCOM_PlantedMineRecently",false,false];
_Unit setVariable ["VCOMAI_ShotsFired",false,true];
_Unit setVariable ["VCOM_InCover",false,false];
_Unit setVariable ["VCOMAI_StaticNearby",false,false];
_Unit setVariable ["VCOM_VisuallyCanSee",false,false];
_Unit setVariable ["VCOM_HASUAV",false,false];
_Unit setVariable ["VCOMAI_ActivelyClearing",false,false];
_Unit setVariable ["VCOMAI_StartedInside",false,false];
_Unit setVariable ["VCOMAI_LastCStance",(behaviour _Unit),false];
_Unit setVariable ["VCOM_Unit_AIWarnDistance",VCOM_Unit_AIWarnDistance,false];


//Allow fleeing 1 forces the AI to RUN. Turning this to 0 makes them brave and stuff. Will have to use this somehow.
//_Unit allowfleeing 1;

//Should the AI run to support friendlies?
if (VCOM_NOPATHING) then
{
	_VariableCheck1 = _Unit getvariable "VCOM_NOPATHING_Unit";
	if (isNil "_VariableCheck1") then {_Unit setVariable ["VCOM_NOPATHING_Unit",true,false];};
}
else
{
	_VariableCheck1 = _Unit getvariable "VCOM_NOPATHING_Unit";
	if (isNil "_VariableCheck1") then {_Unit setVariable ["VCOM_NOPATHING_Unit",false,false];};
};