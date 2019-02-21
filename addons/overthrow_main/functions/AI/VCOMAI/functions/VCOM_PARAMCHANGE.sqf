private _Admin = [] call BIS_fnc_admin;


if !(isServer) then
{
	if (!(_Admin isEqualTo 2) && isMultiplayer) exitWith
	{
		systemChat "You are a logged in admin! You can not make this change.";
		
	};
};

private _index = lbCurSel 1500;
private _text = lbText [1500, _index];
systemChat format ["CHANGED VARIABLE: %1",_text];

private _typedtext = ctrlText 1400;
private _FinalChange = call compile _typedtext;
private _indexc = 0;
private _VariableToChange = "";
{
	if (_text isEqualTo (_x select 0)) exitWith {_VariableToChange = _x select 0;_FinalSelect = _x select 2;_ActualVariable = _FinalChange;VCOM_AllSettings set [_indexc,[_VariableToChange,_ActualVariable,_FinalSelect]];};
	_indexc = _indexc + 1;
} foreach VCOM_AllSettings;
publicVariable "VCOM_AllSettings";


switch (_VariableToChange) do {
    case "VCOM_AISkillEnabled": {VCOM_AISkillEnabled = _FinalChange;publicVariable "VCOM_AISkillEnabled"};
    case "VCOM_AIConfig": {VCOM_AIConfig = _FinalChange;publicVariable "VCOM_AIConfig"};
    case "VCOM_AIDEBUG": {VCOM_AIDEBUG = _FinalChange;publicVariable "VCOM_AIDEBUG"};
    case "VCOM_UseMarkers": {VCOM_UseMarkers = _FinalChange;publicVariable "VCOM_UseMarkers"};
    case "NOAI_FOR_PLAYERLEADERS": {NOAI_FOR_PLAYERLEADERS = _FinalChange;publicVariable "NOAI_FOR_PLAYERLEADERS"};
    case "VCOM_STATICGARRISON": {VCOM_STATICGARRISON = _FinalChange;publicVariable "VCOM_STATICGARRISON"};
    case "VCOM_HEARINGDISTANCE": {VCOM_HEARINGDISTANCE = _FinalChange;publicVariable "VCOM_HEARINGDISTANCE"};
    case "VCOM_Artillery": {VCOM_Artillery = _FinalChange;publicVariable "VCOM_Artillery"};
    case "VCOM_ArtillerySpread": {VCOM_ArtillerySpread = _FinalChange;publicVariable "VCOM_ArtillerySpread"};
    case "VCOM_ArtilleryCooldown": {VCOM_ArtilleryCooldown = _FinalChange;publicVariable "VCOM_ArtilleryCooldown"};
    case "VCOM_NOPATHING": {VCOM_NOPATHING = _FinalChange;publicVariable "VCOM_NOPATHING"};
    case "VCOM_USESMOKE": {VCOM_USESMOKE = _FinalChange;publicVariable "VCOM_USESMOKE"};
    case "VCOM_GRENADECHANCE": {VCOM_GRENADECHANCE = _FinalChange;publicVariable "VCOM_GRENADECHANCE"};
    case "VCOM_MineLaying": {VCOM_MineLaying = _FinalChange;publicVariable "VCOM_MineLaying"};
    case "VCOM_MineLayChance": {VCOM_MineLayChance = _FinalChange;publicVariable "VCOM_MineLayChance"};
    case "VCOM_AIDisembark": {VCOM_AIDisembark = _FinalChange;publicVariable "VCOM_AIDisembark"};
    case "VCOM_AIMagLimit": {VCOM_AIMagLimit = _FinalChange;publicVariable "VCOM_AIMagLimit"};
    case "VCOM_RainImpact": {VCOM_RainImpact = _FinalChange;publicVariable "VCOM_RainImpact"};
    case "VCOM_RainPercent": {VCOM_RainPercent = _FinalChange;publicVariable "VCOM_RainPercent"};
    case "VCOM_Suppression": {VCOM_Suppression = _FinalChange;publicVariable "VCOM_Suppression"};
    case "VCOM_SuppressionVar": {VCOM_SuppressionVar = _FinalChange;publicVariable "VCOM_SuppressionVar"};
    case "VCOM_Adrenaline": {VCOM_Adrenaline = _FinalChange;publicVariable "VCOM_Adrenaline"};
    case "VCOM_AdrenalineVar": {VCOM_AdrenalineVar = _FinalChange;publicVariable "VCOM_AdrenalineVar"};
    case "VCOM_CurrentlyMovingLimit": {VCOM_CurrentlyMovingLimit = _FinalChange;publicVariable "VCOM_CurrentlyMovingLimit"};
    case "VCOM_CurrentlySuppressingLimit": {VCOM_CurrentlySuppressingLimit = _FinalChange;publicVariable "VCOM_CurrentlySuppressingLimit"};
    case "VCOM_DisableDistance": {VCOM_DisableDistance = _FinalChange;publicVariable "VCOM_DisableDistance"};
    case "VCOM_BasicCheckLimit": {VCOM_BasicCheckLimit = _FinalChange;publicVariable "VCOM_BasicCheckLimit"};
    case "VCOM_LeaderExecuteLimit": {VCOM_LeaderExecuteLimit = _FinalChange;publicVariable "VCOM_LeaderExecuteLimit"};
    case "VCOM_FPSFreeze": {VCOM_FPSFreeze = _FinalChange;publicVariable "VCOM_FPSFreeze"};
    case "VCOM_VehicleUse": {VCOM_VehicleUse = _FinalChange;publicVariable "VCOM_VehicleUse"};
    case "VCOM_IRLaser": {VCOM_IRLaser = _FinalChange;publicVariable "VCOM_IRLaser"};
    case "VCOM_IncreasingAccuracy": {VCOM_IncreasingAccuracy = _FinalChange;publicVariable "VCOM_IncreasingAccuracy"};
    case "VCOM_SideBasedMovement": {VCOM_SideBasedMovement = _FinalChange;publicVariable "VCOM_SideBasedMovement"};
    case "VCOM_SideBasedExecution": {VCOM_SideBasedExecution = _FinalChange;publicVariable "VCOM_SideBasedExecution"};
    case "VCOM_Unit_AIWarnDistance": {VCOM_Unit_AIWarnDistance = _FinalChange;publicVariable "VCOM_Unit_AIWarnDistance"};
    case "VCOM_WaypointDistance": {VCOM_WaypointDistance = _FinalChange;publicVariable "VCOM_WaypointDistance"};
    case "VCOM_SIDESPECIFIC": {VCOM_SIDESPECIFIC = _FinalChange;publicVariable "VCOM_SIDESPECIFIC"};
    case "VCOM_CLASSNAMESPECIFIC": {VCOM_CLASSNAMESPECIFIC = _FinalChange;publicVariable "VCOM_CLASSNAMESPECIFIC"};
};