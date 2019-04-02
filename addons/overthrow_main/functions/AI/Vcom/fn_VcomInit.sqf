
//Global actions compiles
Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
VCM_PublicScript = compileFinal "[] call (_this select 0);";
VCM_ServerAsk = compileFinal "if (isServer) then {publicvariable (_this select 0);};";

if !(isServer) exitWith {};

//Parameters
[] call VCM_fnc_DefaultSettings; //Load default settings
[] call VCM_fnc_AISettingsV4;
[] call VCM_fnc_CBA_Settings; //Overwrite with CBA settings
publicVariable "Vcm_ActivateAI";

//Mod checks
//ACE CHECK
if (!isNil "ACE_Medical_enableFor" && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;} else {VCM_MEDICALACTIVE = true;};

VCOM_MINEARRAY = [];
[] spawn VCM_fnc_MineMonitor;
[] spawn VCM_fnc_HANDLECURATORS;

[] spawn
{
	waitUntil {time > 0};
	sleep 2;

	//Begin Artillery function created by Rydygier - https://forums.bohemia.net/forums/topic/159152-fire-for-effect-the-god-of-war-smart-simple-ai-artillery/
	if (VCM_FFEARTILLERY) then {
		nul = [] spawn RYD_fnc_FFE;
		VCM_ARTYENABLE = false;
	};

	[] spawn VCM_fnc_AIDRIVEBEHAVIOR;

	//Below is loop to check for new AI spawning in to be added to the list

	["vcom_init","_counter%10 isEqualTo 0","
		if (Vcm_ActivateAI) then {
			{
				if (local _x && {simulationEnabled (leader _x)} && {!(isplayer (leader _x))} && {(leader _x) isKindOf ""Man""}) then {
					private _Grp = _x;
					if !(_Grp in VcmAI_ActiveList) then {
						if !(((units _Grp) findIf {alive _x}) isEqualTo -1) then {
							_x spawn VCM_fnc_SQUADBEH;
							VcmAI_ActiveList pushback _x;
						};
					};
				};
			} foreach allGroups;
		};
	"] call OT_fnc_addActionLoop;

};
