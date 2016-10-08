VCOMAI_Func = 
{
//Variable for enabling/disabling skill changes for AI. True is on, False is off.
VCOM_AISkillEnabled = true;
//Variable for finding out which config was loaded.
VCOM_AIConfig = "Mission Folder";
//Turn this on to see certain debug messages. 1 is on
VCOM_AIDEBUG = 0;
//Turn on map markers that track AI movement
VCOM_UseMarkers = false;
//Turns off VCOMAI for AI units in a players squad
NOAI_FOR_PLAYERLEADERS = 1;
//Will AI garrison static weapons nearby?
VCOM_STATICGARRISON = 1;
//How far can the AI hear gunshots from?
VCOM_HEARINGDISTANCE = 500;
//Should AI be able to call for artillery. 1 = YES 0 = NO
VCOM_Artillery = 1;
//Should we let AI use flanking manuevers? false means they can flank
VCOM_NOPATHING = false;
//Should AI use smoke grenades? Besides default A3 behavior?
VCOM_USESMOKE = true;
//Chance of AI using grenades
VCOM_GRENADECHANCE = 20;
//Should the AI lay mines?
VCOM_MineLaying = true;
//Chance of AI to lay a mine.
VCOM_MineLayChance = 40;
//AI will automatically disembark from vehicles when in combat.
VCOM_AIDisembark = true;
//How low should an AI's mag count be for them to consider finding more ammo? This DOES NOT include the mag loaded in the gun already.
VCOM_AIMagLimit = 2;


//The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes.DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_IncreasingAccuracy = true;
//VCOM_SideBasedMovement- Remove sides from the array below to force that specific AI side to not execute any advance movement code. (I.E. Moving to reinforce allies, being alerted by distant gunshots and etc). AI with this will still react normally in combat. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_SideBasedMovement = [WEST,EAST,RESISTANCE];
//VCOM_SideBasedExecution- Remove sides from the array below to remove that specific AI side from executing any of the VCOMAI scripts at all. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_SideBasedExecution = [WEST,EAST,RESISTANCE];
//Distance AI will respond to call of help from each other
VCOM_Unit_AIWarnDistance = 1000;

//The following commands are to be left alone, except under rare circumstances.
MarkerArray = [];
VcomAI_UnitQueue = [];
VcomAI_ActiveList = [];
ArtilleryArray = [];
//AI ACCURACY SETTINGS - You can change these numbers below
//Colonel Level AI
AccuracyFunctionRank6 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
//Major Level AI
AccuracyFunctionRank5 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
//Captain Level AI
AccuracyFunctionRank4 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
//Lieutenant Level AI
AccuracyFunctionRank3 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
//Sergeant Level AI
AccuracyFunctionRank2 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
//Corporal Level AI
AccuracyFunctionRank1 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
//Private Level AI
AccuracyFunctionRank0 = {
_Unit = _this select 0;

_Unit setSkill ["aimingAccuracy",(0.05 + (random 0.05))];
_Unit setSkill ["aimingShake",(0.05 + (random 0.05))];
_Unit setSkill ["spotDistance",(0.6 + (random 0.1))];
_Unit setSkill ["spotTime",(0.6 + (random 0.1))];
_Unit setSkill ["courage",(0.7 + (random 0.3))];
_Unit setSkill ["commanding",1.0];
_Unit setSkill ["aimingSpeed",(0.5 + (random 0.1))];
_Unit setSkill ["general",1.0];
_Unit setSkill ["endurance",1.0];
_Unit setSkill ["reloadSpeed",(0.7 + (random 0.3))];
};
};