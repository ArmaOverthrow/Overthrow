//This will execute once the player opens the edit menu for the first time.

if (isNil "VCOM_AllSettings") then
{
	VCOM_AllSettings = 
	[
	["VCOM_AIINGAMEMENU",VCOM_AIINGAMEMENU,"Enable or disable the INGAME setting menu. This is off by default due to compatability issues with multiple mods and scripts."],
	["VCOM_AISkillEnabled",VCOM_AISkillEnabled,"Variable for enabling/disabling skill changes for AI. True is on, False is off."],
	["VCOM_AIConfig",VCOM_AIConfig,"Variable for finding out which config was loaded."],
	["VCOM_AIDEBUG",VCOM_AIDEBUG,"Turn this on to see certain debug messages. 1 is on. 0 is off."],
	["VCOM_UseMarkers",VCOM_UseMarkers,"Turn on map markers that track AI movement. False is off. True is on."],
	["NOAI_FOR_PLAYERLEADERS",NOAI_FOR_PLAYERLEADERS,"Turns off VCOMAI for AI units in a players squad. 1 is on, 0 is off."],
	["VCOM_STATICGARRISON",VCOM_STATICGARRISON,"Will AI garrison static weapons nearby?"],
	["VCOM_HEARINGDISTANCE",VCOM_HEARINGDISTANCE,"How far can the AI hear gunshots from?"],
	["VCOM_Artillery",VCOM_Artillery,"Should AI be able to call for artillery. 1 = YES 0 = NO"],
	["VCOM_ArtillerySpread",VCOM_ArtillerySpread,"What should the dispersion be for AI artillery rounds? In meters."],
	["VCOM_ArtilleryCooldown",VCOM_ArtilleryCooldown,"What is the delay between firing artillery rounds? In seconds."],
	["VCOM_NOPATHING",VCOM_NOPATHING,"Should we let AI use flanking manuevers? False means they can flank."],
	["VCOM_USESMOKE",VCOM_USESMOKE,"Should AI use smoke grenades? Besides default A3 behavior?"],
	["VCOM_GRENADECHANCE",VCOM_GRENADECHANCE,"Chance of AI using grenades"],
	["VCOM_MineLaying",VCOM_MineLaying,"Should the AI lay mines? True = AI will use mines and C4"],
	["VCOM_MineLayChance",VCOM_MineLayChance,"Chance of AI to lay a mine."],
	["VCOM_AIDisembark",VCOM_AIDisembark,"AI will automatically disembark from vehicles when in combat. True = disembark"],
	["VCOM_AIMagLimit",VCOM_AIMagLimit,"How low should an AI's mag count be for them to consider finding more ammo? This DOES NOT include the mag loaded in the gun already."],
	["VCOM_RainImpact",VCOM_RainImpact,"Should the rain impact accuracy of AI? DEFAULT = true;"],
	["VCOM_RainPercent",VCOM_RainPercent,"How much should rain impact the accuracy of AI? Default = 3. Default formula is -> _WeatherCheck = (rain)/3; 'rain' is on a scale from 0 to 1. 1 Being very intense rain."],
	["VCOM_Suppression",VCOM_Suppression,"Should AI and players have an additional layer of suppression that decreases aiming when suppressed? Default = true;"],
	["VCOM_SuppressionVar",VCOM_SuppressionVar,"How much should suppression impact both AI and player aiming? Default is 5. Normal ArmA is 1"],
	["VCOM_Adrenaline",VCOM_Adrenaline,"Should AI/players be impacted by adrenaline? This provides players and AI with a small speed boost to animations to assist with cover seeking and positioning for a short time. Default = true;"],
	["VCOM_AdrenalineVar",VCOM_AdrenalineVar,"How much of a speed boost should players/AI recieve? Default = 1.15; (1 is ArmA's normal speed)."],
	["VCOM_CurrentlyMovingLimit",VCOM_CurrentlyMovingLimit,"How many AI UNITS can be calculating cover positions at once?"],
	["VCOM_CurrentlySuppressingLimit",VCOM_CurrentlySuppressingLimit,"How many AI UNITS can be suppressing others at once?"],
	["VCOM_DisableDistance",VCOM_DisableDistance,"The distance a unit needs to be away for Vcom AI to temporary disable itself upon the unit? The AI unit will also need to be out of combat."],
	["VCOM_BasicCheckLimit",VCOM_BasicCheckLimit,"How many AI can be checking roles/equipment/additional commands at once? This will impact FPS of AI in and out of battle. The goal is to limit how many benign commands are being run at once and bogging down a server with over a couple HUNDRED AI."],
	["VCOM_LeaderExecuteLimit",VCOM_LeaderExecuteLimit,"How many squad leaders can be executing advanced code at once."],
	["VCOM_FPSFreeze",VCOM_FPSFreeze,"How low should the FPS be, before Vcom pauses simulation. This will not disable simulation on AI - they will run default Bohemia AI."],
	["VCOM_VehicleUse",VCOM_VehicleUse,"Should the AI consider stealing/using empty ground vehicles?"],
	["VCOM_IRLaser",VCOM_IRLaser,"Should the AI notice IR lasers?"],
	["VCOM_IncreasingAccuracy",VCOM_IncreasingAccuracy,"The longer an AI's target stays in 1 location, the more accurate and aware of the target the AI becomes. True = enabled"],
	["VCOM_SideBasedMovement",VCOM_SideBasedMovement,"Remove sides from the array below to force that specific AI side to not execute any advance movement code. (I.E. Moving to reinforce allies, being alerted by distant gunshots and etc). AI with this will still react normally in combat. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE];"],
	["VCOM_SideBasedExecution",VCOM_SideBasedExecution,"Remove sides from the array below to remove that specific AI side from executing any of the VCOMAI scripts at all. DEFAULT = [WEST,EAST,CIVILIAN,RESISTANCE]"],
	["VCOM_Unit_AIWarnDistance",VCOM_Unit_AIWarnDistance,"Distance AI will respond to call of help from each other"],
	["VCOM_WaypointDistance",VCOM_WaypointDistance,"Distance the AI will attempt to flank around the enemy. I.E. How far off a waypoint, or around the enemy squad, the AI are willing to go in combat."],
	["VCOM_SIDESPECIFIC",VCOM_SIDESPECIFIC,"Switching this to true will enable side specific skill settings. Side specific skills get added IN ADDITION TO the normal ranked skill."],
	["VCOM_CLASSNAMESPECIFIC",VCOM_CLASSNAMESPECIFIC,"Switching this to true will enable classname specific skill settings. VCOM_SIDESPECIFIC and VCOM_CLASSNAMESPECIFIC can both be true, however any units in the VCOM_CLASSNAMESPECIFIC array are given priority over everything else."],
	["VCOM_AIDISTANCEVEHPATH",VCOM_AIDISTANCEVEHPATH,"The distance, in meters, of how far AI will look for empty unlocked vehicles to steal."]
	];
};

if (isDedicated) exitWith {};
_Create = false;

while {true} do
{
		
		if (VCOM_AIINGAMEMENU) then
		{
		waitUntil {!(isNull (findDisplay 49))}; 
		private _Admin = [] call BIS_fnc_admin;
		if (isNull (FindDisplay 5230)) then
		{
			
			
			if !(isDedicated) then
			{
				if ((_Admin isEqualTo 2 && {isMultiplayer} && {alive player}) || {isServer}) then
				{
					_Create = true;
					_Open = createDialog "VCOM_ESCButton";
					if (isNil "_VCOMMouseMoving") then
					{
						((findDisplay (5230)) displayCtrl (1600)) ctrlShow false;
						_VCOMMouseMoving = (findDisplay 5230) displayAddEventHandler ["MouseMoving",
						{
							private _pos = getMousePosition;
							private _posA = _pos select 0;
							private _posB = _pos select 1;
							
							private _ButtonPosX = 0.85 * safezoneW + safezoneX;
							private _ButtonPosY = 0.1 * safezoneH + safezoneY;
						
							if ((_PosA > (_ButtonPosX - 0.1) && _PosA < (_ButtonPosX + 0.1)) && (_PosB > (_ButtonPosY - 0.1) && _PosB < (_ButtonPosY + 0.1))) then {((findDisplay (5230)) displayCtrl (1600)) ctrlShow true;((findDisplay (5230)) displayCtrl (1001)) ctrlShow false;};

						}];
					};
				};
			};		
		};
		waitUntil {isNull (FindDisplay 5230)};
			if !(isDedicated) then
			{
				if ((_Admin isEqualTo 2 && {isMultiplayer} && {alive player}) || {isServer}) then
				{
					(finddisplay 49) closedisplay 1;
				};
			};			
		waitUntil {(isNull (findDisplay 49))}; 
		_Create = false;
		closeDialog 5230;
	sleep 0.2;
	};
};


//VCOM_ESCPRESSED = (findDisplay 46) displayAddEventHandler ["KeyDown",{if ((_this select 1) isEqualTo 1) then {if (IsNull (FindDisplay 5230)) then {systemchat "GOGO";_Open = createDialog "VCOM_ESCButton";} else {systemchat "GOGO2";closeDialog 5230;};};false}];
//(findDisplay 46) displayRemoveEventHandler ["KeyDown", VCOM_ESCPRESSED];



