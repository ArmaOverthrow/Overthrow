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
		units[] = {"OT_GanjaItem","OT_BlowItem","OT_SpliffItem"};
		weapons[] = {"OT_Ganja","OT_Blow"};
	};
};

class RscStandardDisplay;
class RscControlsGroup;
class RscPicture;
class RscPictureKeepAspect;
class RscDisplayStart: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls {
				class Logo: RscPictureKeepAspect
				{
					text = "\ot\ui\logo_overthrow.paa";
					onLoad = "";
				};
			};
		};
	};
};
class RscDisplayMain: RscStandardDisplay
{
	class Spotlight
	{
		class Overthrow
		{
			text = "Overthrow"; // Text displayed on the square button, converted to upper-case
			textIsQuote = 1; // 1 to add quotation marks around the text
			picture = "\ot\campaign\overthrow_spotlight.jpg"; // Square picture, ideally 512x512
			video = "\a3\Ui_f\Video\spotlight_1_Apex.ogv"; // Video played on mouse hover
			action = "ctrlactivate ((ctrlparent (_this select 0)) displayctrl 101);";
			actionText = $STR_A3_RscDisplayMain_Spotlight_Play; // Text displayed in top left corner of on-hover white frame
			condition = "true"; // Condition for showing the spotlight
		};
		class Bootcamp
		{
			condition = "false";
		};
		class ApexProtocol
		{
			condition = "false";
		};
		class EastWind
		{
			condition = "false";
		};
	};
};

class CfgMissions
{
	class Campaigns
	{
		class Overthrow
		{
			directory = "ot\campaign";
		};
	};
	class Missions
	{
		class OverthrowTanoaScenario
		{
			directory="ot\campaign\missions\Overthrow.Tanoa";
		};
		class OverthrowAltisScenario
		{
			directory="ot\campaign\missions\Overthrow.Altis";
		};
		class OverthrowMaldenScenario
		{
			directory="ot\campaign\missions\Overthrow.Malden";
		};
	};
	class MPMissions
	{
		class OverthrowTanoaMP
		{
			directory="ot\campaign\missions\Overthrow.Tanoa";
		};
		class OverthrowAltisMP
		{
			directory="ot\campaign\missions\Overthrow.Altis";
		};
		class OverthrowMaldenMP
		{
			directory="ot\campaign\missions\Overthrow.Malden";
		};
	};
};

class CfgMarkers
{
	class ot_Camp
	{
		name = "Camp";
		icon = "ot\ui\markers\camp.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class ot_Shop
	{
		name = "Shop";
		icon = "ot\ui\markers\shop.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class ot_Police
	{
		name = "Police";
		icon = "ot\ui\markers\police.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class ot_Anarchy
	{
		name = "Anarchy";
		icon = "ot\ui\markers\anarchy.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class ot_Warehouse
	{
		name = "Warehouse";
		icon = "ot\ui\markers\warehouse.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class ot_Business
	{
		name = "Business";
		icon = "ot\ui\markers\business.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class ot_Factory
	{
		name = "Factory";
		icon = "ot\ui\markers\factory.paa";
		color[] = {1, 0, 0, 1};
		size = 32;
		shadow = true;
		scope = 1;
	};
	class flag_Malden
	{
		name = "Malden";
		icon = "ot\flags\flag_malden.paa";
		color[] = {1, 1, 1, 1};
		size = 32;
		shadow = true;
		scope = 1;
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

class CfgGlasses {
    class None;

    class murshun_cigs_cig0: None {
        author = "Rebel / Facel";
        mass = 0.02;
        displayName = "Spliff";
        model = "\ot\models\cig0.p3d";
        picture = "\ot\ui\icons\gear_cig0_x_ca";
        identityTypes[]={};
    };

    class murshun_cigs_cig1: murshun_cigs_cig0 {
        author = "Rebel / Facel";
        displayName = "Spliff (Stage 1)";
        model = "\ot\models\cig1.p3d";
        picture = "\ot\ui\icons\gear_cig1_x_ca";
    };

    class murshun_cigs_cig2: murshun_cigs_cig0 {
        author = "Rebel / Facel";
        displayName = "Spliff (Stage 2)";
        model = "\ot\models\cig2.p3d";
        picture = "\ot\ui\icons\gear_cig2_x_ca";
    };

    class murshun_cigs_cig3: murshun_cigs_cig0 {
        author = "Rebel / Facel";
        displayName = "Spliff (Stage 3)";
        model = "\ot\models\cig3.p3d";
        picture = "\ot\ui\icons\gear_cig3_x_ca";
    };

    class murshun_cigs_cig4: murshun_cigs_cig0 {
        author = "Rebel / Facel";
        displayName = "Spliff (Stage 4)";
        model = "\ot\models\cig4.p3d";
        picture = "\ot\ui\icons\gear_cig4_x_ca";
    };
};

class CfgSounds
{
    sounds[] = {};

    class ot_unwrap
    {
        sound[] = {"\ot\sounds\murshun_cigs_unwrap.ogg", 2, 1, 15};
        titles[] = {};
    };
    class murshun_cigs_matches_01
    {
        sound[] = {"\ot\sounds\murshun_cigs_matches_01.ogg", 2, 1, 15};
        titles[] = {};
    };
    class murshun_cigs_lighter_01
    {
        sound[] = {"\ot\sounds\murshun_cigs_lighter_01.ogg", 2, 1, 15};
        titles[] = {};
    };
};

#include "CfgSettings.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "CfgFunctions.hpp"
#include "CfgMagazines.hpp"
#include "missions\CfgOverthrowMissions.hpp"
