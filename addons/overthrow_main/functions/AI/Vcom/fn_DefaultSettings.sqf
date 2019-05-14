
/*
	ADDITIONAL COMMANDS
	(group this) setVariable ["VCM_NOFLANK",true]; //This command will stop the AI squad from executing advanced movement maneuvers.
	(group this) setVariable ["VCM_NORESCUE",true]; //This command will stop the AI squad from responding to calls for backup.
	(group this) setVariable ["VCM_TOUGHSQUAD",true]; //This command will stop the AI squad from calling for backup.
	(group this) setVariable ["Vcm_Disable",true]; //This command will disable Vcom AI on a group entirely.
	(group this) setVariable ["VCM_DisableForm",true]; //This command will disable AI group from changing formations.
	(group this) setVariable ["VCM_Skilldisable",true]; //This command will disable an AI group from being impacted by Vcom AI skill changes.

*/

Vcm_ActivateAI = true; //Set this to false to disable VcomAI. It can be set to true at any time to re-enable Vcom AI
VcmAI_ActiveList = []; //Leave this alone.
VCM_AIMagLimit = 2; //Number of mags remaining before AI looks for ammo.
VCM_Debug = false; //Enable debug mode.
VCM_MINECHANCE = 10; //Chance to lay a mine
VCM_LGARRISONCHANCE = 20; //Chance to perform a temporary garrison. 0 = disabled

//VCOM ARTILLERY. Only one kind of advanced artillery can be used at a time.
VCM_ARTYENABLE = false; //Enable improved artillery handling from Vcom.
VCM_ARTYSIDES = [west,east];  //Sides that will use VCOM/FFE artillery
VCM_ARTYLST = []; //List of all AI inside of artillery pieces, leave this alone.
VCM_ARTYDELAY = 300; //Delay between squads requesting artillery
VCM_ARTYWT = -(VCM_ARTYDELAY);
VCM_ARTYET = -(VCM_ARTYDELAY);
VCM_ARTYRT = -(VCM_ARTYDELAY);
VCM_ARTYSPREAD = 400; //Spread of artillery rounds;
Vcm_ArtilleryArray = []; //Leave this alone

//Fire For Effect Artillery handling. Only one kind of advanced artillery can be used at a time. - https://forums.bohemia.net/forums/topic/159152-fire-for-effect-the-god-of-war-smart-simple-ai-artillery/
VCM_FFEARTILLERY = true;

VCM_SIDEENABLED = [west,east,resistance]; //Sides that will activate Vcom AI
VCM_RAGDOLL = true; //Should AI ragdoll when hit
VCM_RAGDOLLCHC = 50; //CHANCE AI RAGDOLL
VCM_AIHEALING = true; //Makes AI heal themselves
VCM_FullSpeed = true; //Enforce full speedmode during combat (Does not reset after combat end)
VCM_HEARINGDISTANCE = 800; //Distance AI hear unsuppressed gunshots.
VCM_WARNDIST = 1000; //How far AI can request help from other groups.
VCM_WARNDELAY = 30; //How long the AI have to survive before they can call in for support. This activates once the AI enter combat.
VCM_STATICARMT = 300; //How long AI stay on static weapons when initially arming them. This is just for AI WITHOUT static bags. They will stay for this duration when NO ENEMIES ARE SEEN, or their group gets FAR away.
VCM_StealVeh = false; //Will the AI steal vehicles.
VCM_AIDISTANCEVEHPATH = 100; //Distance AI check from the squad leader to steal vehicles
VCM_ADVANCEDMOVEMENT = true; //True means AI will actively generate waypoints if no other waypoints are generated for the AI group (2 or more). False disables this advanced movements.
VCM_FRMCHANGE = true; //AI GROUPS WILL CHANGE FORMATIONS TO THEIR BEST GUESS.
VCM_SKILLCHANGE = true; //AI Groups will have their skills changed by Vcom.

//VCOM DRIVING. Experimental feature

Vcm_DrivingActivated = false; //Set this to false to disable VcomAI driving from executing.
VCM_DrivingDist = 10; // Distance from predicted path to search for objects. High numbers may cause instability.
VCM_DrivingDelay = 0.75; // How often the script should look for obstacles
VCM_DRIVERLIMIT = 4; // How many drivers should be calculated at each cycle

//AI SKILL SETTINGS HERE!!!!!!!!!!!!
//LOW DIFFICULTY
//VCM_AIDIFA = [['aimingAccuracy',0.15],['aimingShake',0.1],['aimingSpeed',0.25],['commanding',1],['courage',1],['endurance',1],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];

//MEDIUM DIFFICULTY
VCM_AIDIFA = [['aimingAccuracy',0.15],['aimingShake',0.2],['aimingSpeed',0.2],['commanding',1],['courage',1],['endurance',1],['general',1],['reloadSpeed',0.5],['spotDistance',0.85],['spotTime',0.6]];

//HIGH DIFFICULTY
//VCM_AIDIFA = [['aimingAccuracy',0.35],['aimingShake',0.4],['aimingSpeed',0.45],['commanding',1],['courage',1],['endurance',1],['general',1],['reloadSpeed',1],['spotDistance',0.85],['spotTime',0.85]];

//VCOM AI Skill Variables. Default values set to medium difficulty (old default)
//AIMING ACCURACY
VCM_AISKILL_AIMINGACCURACY_W = 0.15;
VCM_AISKILL_AIMINGACCURACY_E = 0.15;
VCM_AISKILL_AIMINGACCURACY_R = 0.25;

//AIMING SHAKE
VCM_AISKILL_AIMINGSHAKE_W = 0.2;
VCM_AISKILL_AIMINGSHAKE_E = 0.2;
VCM_AISKILL_AIMINGSHAKE_R = 0.1;

//AIMING SPEED
VCM_AISKILL_AIMINGSPEED_W = 0.2;
VCM_AISKILL_AIMINGSPEED_E = 0.2;
VCM_AISKILL_AIMINGSPEED_R = 0.3;

VCM_CLASSNAMESPECIFIC = false; //Do you want the AI to have classname specific skill settings?
VCM_SIDESPECIFICSKILL = true; //Do you want the AI to have side specific skill settings? This overrides classname specific skills.
VCM_SKILL_CLASSNAMES = []; //Here you can assign certain unit classnames to specific skill levels. This will override the AI skill level above.

/*
EXAMPLE FOR VCM_SKILL_CLASSNAMES

VCM_SKILL_CLASSNAMES = [["Classname1",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]],["Classname2",[aimingaccuracy,aimingshake,spotdistance,spottime,courage,commanding,aimingspeed,general,endurance,reloadspeed]]];
VCM_SKILL_CLASSNAMES = 	[
													["B_GEN_Soldier_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]],
													["B_G_Soldier_AR_F",[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1]]
												];

*/

diag_log "VCOM: Loaded Default Settings";
