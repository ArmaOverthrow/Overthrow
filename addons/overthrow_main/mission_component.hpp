/* Included at top of mission's description.ext for default Overthrow settings
 * #include "\overthrow_main\mission_component.hpp"
 *
 * Override values after if required
 */
#include "\overthrow_main\script_component.hpp"

author=QUOTE(MOD_AUTHOR);
OnLoadMission=QUOTE(VERSION - Read the wiki at armaoverthrow.com for more information);

onLoadMissionTime = 1;
allowSubordinatesTakeWeapons = 1;

joinUnassigned = 1;
briefing = 0;

class Header
{
	gameType = Coop;
	minPlayers = 1;
	maxPlayers = 12;
};

allowFunctionsLog = 0;
enableDebugConsole = 1;

respawn = "BASE";
respawnDelay = 5;
respawnVehicleDelay = 120;
respawnDialog = 0;
aiKills = 0;
disabledAI = 1;
saving = 0;
showCompass = 1;
showRadio = 1;
showGPS = 1;
showMap = 1;
showBinocular = 1;
showNotepad = 1;
showWatch = 1;
debriefing = 0;

//Disable ACE blood (just too much of it in a heavy game)
class Params {
	class ot_start_autoload {
		title = "Autoload a save or start a new game";
		values[] = {0, 1};
		texts[] = {"No", "Yes"};
		default = 0;
	};
	class ot_start_difficulty {
		title = "Game difficulty (Only with autoload)";
		values[] = {0, 1, 2};
		texts[] = {"Easy", "Normal", "Hard"};
		default = 1;
	};
	class ot_start_fasttravel {
		title = "Fast Travel (Only with autoload)";
		values[] = {0, 1, 2};
		texts[] = {"Free", "Costs", "Disabled"};
		default = 1;
	};
	class ace_medical_level {
        title = "ACE Medical Level";
        ACE_setting = 1;
        values[] = {1, 2};
        texts[] = {"Basic", "Advanced"};
        default = 1;
    };
    class ace_medical_blood_enabledFor {
        title = "ACE Blood";
        ACE_setting = 1;
        values[] = {0, 1, 2};
        texts[] = {"None", "Players Only", "All"};
        default = 1;
    };
};
