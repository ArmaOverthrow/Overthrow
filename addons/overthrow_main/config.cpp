#include "script_mod.hpp"
#include "headers\config_macros.hpp"

#include "ui\dialogs\defines.hpp"
#include "ui\dialogs\stats.hpp"
#include "ui\dialogs\shop.hpp"
#include "ui\dialogs\main.hpp"
#include "ui\dialogs\place.hpp"
#include "ui\dialogs\build.hpp"
#include "ui\dialogs\recruits.hpp"
#include "UI\dialogs\resistance.hpp"
#include "UI\dialogs\factory.hpp"

class CfgPatches
{
	class OT_Overthrow_Main
	{
		author="ARMAzac";
		name=COMPONENT_NAME;
		url="https://armaoverthrow.com/";
		requiredAddons[]=
		{
			"cba_ui",
            "cba_xeh",
            "cba_jr",
			"ace_main"
		};
		requiredVersion=REQUIRED_VERSION;
        VERSION_CONFIG;
		units[] = {"OT_GanjaItem","OT_BlowItem"};
		weapons[] = {"OT_Ganja","OT_Blow"};
	};
};

class CfgMainMenuSpotlight
{
	class Overthrow
	{
		text = "Overthrow Development Build"; // Text displayed on the square button, converted to upper-case
		textIsQuote = 0; // 1 to add quotation marks around the text
		picture = "\overthrow_main\campaign\overthrow_spotlight.jpg"; // Square picture, ideally 512x512
		video = "\a3\Ui_f\Video\spotlight_1_Apex.ogv"; // Video played on mouse hover
		action = "ctrlactivate ((ctrlparent (_this select 0)) displayctrl 101);";
		actionText = $STR_A3_RscDisplayMain_Spotlight_Play; // Text displayed in top left corner of on-hover white frame
		condition = "true"; // Condition for showing the spotlight
	};
	class ApexProtocol
	{
		condition = "false";
	};
	class Bootcamp
	{
		condition = "false";
	};
	class Orange_Campaign
	{
		condition = "false";
	};
	class Orange_CampaignGerman
	{
		condition = "false";
	};
	class Orange_Showcase_IDAP
	{
		condition = "false";
	};
	class Orange_Showcase_LoW
	{
		condition = "false";
	};
	class Showcase_TankDestroyers
	{
		condition = "false";
	};
	class Tacops_Campaign_01
	{
		condition = "false";
	};
	class Tacops_Campaign_02
	{
		condition = "false";
	};
	class Tacops_Campaign_03
	{
		condition = "false";
	};
	class Tanks_Campaign_01
	{
		condition = "false";
	};
	
};

class CfgMissions
{
	class Campaigns
	{
		class Overthrow
		{
			directory = "overthrow_main\campaign";
		};
	};
	class Missions
	{
		class OverthrowTanoaScenario
		{
			directory="overthrow_main\campaign\missions\Overthrow.Tanoa";
		};
		class OverthrowAltisScenario
		{
			directory="overthrow_main\campaign\missions\Overthrow.Altis";
		};
		class OverthrowMaldenScenario
		{
			directory="overthrow_main\campaign\missions\Overthrow.Malden";
		};
	};
	class MPMissions
	{
		class OverthrowTanoaMP
		{
			directory="overthrow_main\campaign\missions\Overthrow.Tanoa";
		};
		class OverthrowAltisMP
		{
			directory="overthrow_main\campaign\missions\Overthrow.Altis";
		};
		class OverthrowMaldenMP
		{
			directory="overthrow_main\campaign\missions\Overthrow.Malden";
		};
	};
};

class CfgWorlds
{
	class Tanoa
	{
		class Names {
			class RailwayDepot01 {
				name = "factory";
			};
		};
	};
};

#include "CfgMarkers.hpp"
#include "CfgGlasses.hpp"
#include "CfgSounds.hpp"
#include "CfgSettings.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "CfgFunctions.hpp"
#include "CfgMagazines.hpp"
#include "missions\CfgOverthrowMissions.hpp"
