class CfgPatches
{
	class OT_Overthrow_Main
	{
		author="ARMAzac";
		name="Overthrow";
		url="https://github.com/armazac/overthrow";
		requiredAddons[]=
		{			
			"a3_map_tanoabuka",
			"cba_ui",
            "cba_xeh",
            "cba_jr"
		};
		requiredVersion=1.64;
		units[] = {"OT_GanjaItem"};
		weapons[] = {"OT_Ganja"};
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
					text = "\overthrow_main\ui\logo_overthrow.paa";
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
			picture = "\overthrow_main\campaign\overthrow_spotlight.jpg"; // Square picture, ideally 512x512
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
			directory = "overthrow_main\campaign";
		};
	};
	class Missions
	{
		class OverthrowTanoaScenario
		{
			directory="overthrow_main\campaign\missions\Overthrow.Tanoa";
		};
	};
	class MPMissions
	{
		class OverthrowTanoaMP
		{
			directory="overthrow_main\campaign\missions\Overthrow.Tanoa";
		};
	};
};

#include "macros.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"