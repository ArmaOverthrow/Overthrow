VCOMAI_Func = 
{
//Enable or disable the INGAME setting menu. This is off by default due to compatability issues with multiple mods and scripts. And I am tired of hearing people complain all the time :D 
VCOM_AIINGAMEMENU = false;
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
//What should the dispersion be for AI artillery rounds? In meters.
VCOM_ArtillerySpread = 600;
//What is the delay between firing artillery rounds? In seconds.
VCOM_ArtilleryCooldown = 300;
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
//Should the rain impact accuracy of AI? DEFAULT = true;
VCOM_RainImpact = true;
//How much should rain impact the accuracy of AI? Default = 3. Default formula is -> _WeatherCheck = (rain)/3; "rain" is on a scale from 0 to 1. 1 Being very intense rain.
VCOM_RainPercent = 3;
//Should AI and players have an additional layer of suppression that decreases aiming when suppressed? Default = true;
VCOM_Suppression = false;
//How much should suppression impact both AI and player aiming? Default is 5. Normal ArmA is 1.
VCOM_SuppressionVar = 5;
//Should AI/players be impacted by adrenaline? This provides players and AI with a small speed boost to animations to assist with cover seeking and positioning for a short time. Default = true;
VCOM_Adrenaline = false;
//How much of a speed boost should players/AI recieve? Default = 1.35; (1 is ArmA's normal speed).
VCOM_AdrenalineVar = 1.35;
//How many AI UNITS can be calculating cover positions at once?
VCOM_CurrentlyMovingLimit = 6;
//How many AI UNITS can be suppressing others at once?
VCOM_CurrentlySuppressingLimit = 12;
//The distance a unit needs to be away for Vcom AI to temporary disable itself upon the unit? The AI unit will also need to be out of combat.
VCOM_DisableDistance = 1200;
//How many AI can be checking roles/equipment/additional commands at once? This will impact FPS of AI in and out of battle. The goal is to limit how many benign commands are being run at once and bogging down a server with over a couple HUNDRED AI.
VCOM_BasicCheckLimit = 25;
//How many squad leaders can be executing advanced code at once.
VCOM_LeaderExecuteLimit = 15;
//How low should the FPS be, before Vcom pauses simulation. This will not disable simulation on AI - they will run default Bohemia AI.
VCOM_FPSFreeze = 10;
//Should the AI consider stealing/using empty ground vehicles?
VCOM_VehicleUse = true;
//Should the AI notice IR lasers?
VCOM_IRLaser = true;
//The distance, in meters, of how far AI will look for empty unlocked vehicles to steal.
VCOM_AIDISTANCEVEHPATH = 150;

//The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes.DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_IncreasingAccuracy = true;
//VCOM_SideBasedMovement- Remove sides from the array below to force that specific AI side to not execute any advance movement code. (I.E. Moving to reinforce allies, being alerted by distant gunshots and etc). AI with this will still react normally in combat. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_SideBasedMovement = [WEST,EAST,RESISTANCE];
//VCOM_SideBasedExecution- Remove sides from the array below to remove that specific AI side from executing any of the VCOMAI scripts at all. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];
VCOM_SideBasedExecution = [WEST,EAST,RESISTANCE];
//Distance AI will respond to call of help from each other
VCOM_Unit_AIWarnDistance = 1000;
//Distance the AI will attempt to flank around the enemy. I.E. How far off a waypoint, or around the enemy squad, the AI are willing to go in combat.
VCOM_WaypointDistance = 300;
//Switching this to true will enable side specific skill settings. Side specific skills get added IN ADDITION TO the normal ranked skill.
VCOM_SIDESPECIFIC = false;
//Switching this to true will enable classname specific skill settings. VCOM_SIDESPECIFIC and VCOM_CLASSNAMESPECIFIC can both be true, however any units in the VCOM_CLASSNAMESPECIFIC array are given priority over everything else.
VCOM_CLASSNAMESPECIFIC = false; 
//Here you can assign certain unit classnames to specific skill levels. This will override the AI skill level above.
VCOM_SKILL_CLASSNAMES = []; 


/*
EXAMPLE FOR VCOM_SKILL_CLASSNAMES

VCOM_SKILL_CLASSNAMES = [["Classname1",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]],["Classname2",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]]];
VCOM_SKILL_CLASSNAMES = [["B_Crew_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]],["B_soldier_AAT_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]]]; 
VCOM_SKILL_CLASSNAMES = [["B_GEN_Soldier_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]],["B_G_Soldier_AR_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]]]; 

*/




//The following commands are to be left alone, except under rare circumstances.
MarkerArray = [];
VcomAI_UnitQueue = [];
VcomAI_ActiveList = [];
ArtilleryArray = [];
Vcom_EastArtCooldown = true;
Vcom_WestArtCooldown = true;
Vcom_ResistanceArtCooldown = true;
//End



//AI ACCURACY SETTINGS - You can change these numbers below
//Colonel Level AI
AccuracyFunctionRank6 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};
//Major Level AI
AccuracyFunctionRank5 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};
//Captain Level AI
AccuracyFunctionRank4 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};
//Lieutenant Level AI
AccuracyFunctionRank3 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};
//Sergeant Level AI
AccuracyFunctionRank2 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};
//Corporal Level AI
AccuracyFunctionRank1 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};
//Private Level AI
AccuracyFunctionRank0 = 
{
	_Unit = _this select 0;
	private _ClassnameSet = false;
	
	if (count VCOM_SKILL_CLASSNAMES > 0) then
	{
		{
			if (typeOf _Unit isEqualTo (_x select 0)) exitWith
			{
				_ClassnameSet = true;
				_Unit setSkill ["aimingAccuracy",((_x select 1) select 0)];_Unit setSkill ["aimingShake",((_x select 1) select 1)];_Unit setSkill ["spotDistance",((_x select 1) select 2)];_Unit setSkill ["spotTime",((_x select 1) select 3)];_Unit setSkill ["courage",((_x select 1) select 4)];_Unit setSkill ["commanding",((_x select 1) select 5)];	_Unit setSkill ["aimingSpeed",((_x select 1) select 6)];_Unit setSkill ["general",((_x select 1) select 7)];_Unit setSkill ["endurance",((_x select 1) select 8)];_Unit setSkill ["reloadSpeed",((_x select 1) select 9)];
			};
		} foreach VCOM_SKILL_CLASSNAMES;
	};
	
	if !(_ClassnameSet) then
	{
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
		
		if (VCOM_SIDESPECIFIC) then 
		{
			private _USide = side (group _Unit);
			if (_USide isEqualTo West) exitWith {_Unit call VCOM_AISKILL_WEST;};
			if (_USide isEqualTo East) exitWith {_Unit call VCOM_AISKILL_EAST;};
			if (_USide isEqualTo Resistance) exitWith {_Unit call VCOM_AISKILL_RESISTANCE;};
		};
	};
};

//Here you can define specific side skill levels. This will add or subtract from the defined skill settings above per side.
VCOM_AISKILL_WEST =
{	
	private _Endurance = _this skill "Endurance";
	private _aimingAccuracy = _this skill "aimingAccuracy";
	private _aimingShake = _this skill "aimingShake";
	private _aimingSpeed = _this skill "aimingSpeed";
	private _spotDistance = _this skill "spotDistance";
	private _spotTime = _this skill "spotTime";
	private _courage = _this skill "courage";
	private _reloadSpeed = _this skill "reloadSpeed";
	private _commanding = _this skill "commanding";
	private _general = _this skill "general";
	
	//Change these variables to impact the gain or loss in each area.
	_EnduranceSet = 0.05;
	_aimingAccuracySet = 0.05;
	_aimingShakeSet = 0.05;
	_aimingSpeedSet = 0.05;
	_spotDistanceSet = 0.05;
	_spotTimeSet = 0.02;
	_courageSet = 0.05;
	_reloadSpeedSet = 0.05;
	_commandingSet = 0.05;
	_generalSet = 0.05;
	
	
	_this setSkill ["aimingAccuracy",_EnduranceSet + _Endurance];
	_this setSkill ["aimingShake",_aimingAccuracySet + _aimingAccuracy];
	_this setSkill ["spotDistance",_aimingShakeSet + _aimingShake];
	_this setSkill ["spotTime",_aimingSpeedSet + _aimingSpeed];
	_this setSkill ["courage",_spotDistanceSet + _spotDistance];
	_this setSkill ["commanding",_spotTimeSet + _spotTime];
	_this setSkill ["aimingSpeed",_courageSet + _courage];
	_this setSkill ["general",_reloadSpeedSet + _reloadSpeed];
	_this setSkill ["endurance",_commandingSet + _commanding];
	_this setSkill ["reloadSpeed",_generalSet + _general];
	
};
VCOM_AISKILL_EAST =
{	
	private _Endurance = _this skill "Endurance";
	private _aimingAccuracy = _this skill "aimingAccuracy";
	private _aimingShake = _this skill "aimingShake";
	private _aimingSpeed = _this skill "aimingSpeed";
	private _spotDistance = _this skill "spotDistance";
	private _spotTime = _this skill "spotTime";
	private _courage = _this skill "courage";
	private _reloadSpeed = _this skill "reloadSpeed";
	private _commanding = _this skill "commanding";
	private _general = _this skill "general";
	
	//Change these variables to impact the gain or loss in each area.
	_EnduranceSet = 0.05;
	_aimingAccuracySet = 0.05;
	_aimingShakeSet = 0.05;
	_aimingSpeedSet = 0.05;
	_spotDistanceSet = 0.05;
	_spotTimeSet = 0.02;
	_courageSet = 0.05;
	_reloadSpeedSet = 0.05;
	_commandingSet = 0.05;
	_generalSet = 0.05;
	
	
	_this setSkill ["aimingAccuracy",_EnduranceSet + _Endurance];
	_this setSkill ["aimingShake",_aimingAccuracySet + _aimingAccuracy];
	_this setSkill ["spotDistance",_aimingShakeSet + _aimingShake];
	_this setSkill ["spotTime",_aimingSpeedSet + _aimingSpeed];
	_this setSkill ["courage",_spotDistanceSet + _spotDistance];
	_this setSkill ["commanding",_spotTimeSet + _spotTime];
	_this setSkill ["aimingSpeed",_courageSet + _courage];
	_this setSkill ["general",_reloadSpeedSet + _reloadSpeed];
	_this setSkill ["endurance",_commandingSet + _commanding];
	_this setSkill ["reloadSpeed",_generalSet + _general];
	
};
VCOM_AISKILL_RESISTANCE =
{	
	private _Endurance = _this skill "Endurance";
	private _aimingAccuracy = _this skill "aimingAccuracy";
	private _aimingShake = _this skill "aimingShake";
	private _aimingSpeed = _this skill "aimingSpeed";
	private _spotDistance = _this skill "spotDistance";
	private _spotTime = _this skill "spotTime";
	private _courage = _this skill "courage";
	private _reloadSpeed = _this skill "reloadSpeed";
	private _commanding = _this skill "commanding";
	private _general = _this skill "general";
	
	//Change these variables to impact the gain or loss in each area.
	_EnduranceSet = 0.05;
	_aimingAccuracySet = 0.05;
	_aimingShakeSet = 0.05;
	_aimingSpeedSet = 0.05;
	_spotDistanceSet = 0.05;
	_spotTimeSet = 0.02;
	_courageSet = 0.05;
	_reloadSpeedSet = 0.05;
	_commandingSet = 0.05;
	_generalSet = 0.05;
	
	
	_this setSkill ["aimingAccuracy",_EnduranceSet + _Endurance];
	_this setSkill ["aimingShake",_aimingAccuracySet + _aimingAccuracy];
	_this setSkill ["spotDistance",_aimingShakeSet + _aimingShake];
	_this setSkill ["spotTime",_aimingSpeedSet + _aimingSpeed];
	_this setSkill ["courage",_spotDistanceSet + _spotDistance];
	_this setSkill ["commanding",_spotTimeSet + _spotTime];
	_this setSkill ["aimingSpeed",_courageSet + _courage];
	_this setSkill ["general",_reloadSpeedSet + _reloadSpeed];
	_this setSkill ["endurance",_commandingSet + _commanding];
	_this setSkill ["reloadSpeed",_generalSet + _general];
	
};
};