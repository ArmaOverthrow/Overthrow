class OT_dialog_name
{
	idd=-1;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1199: RscOverthrowStructuredText
		{
			idc = 1199;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.252656 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Votehi)
		////////////////////////////////////////////////////////

		class RscEdit_1400: RscOverthrowEdit
		{
			idc = 1400;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.055 * safezoneH;
			onKeyDown = "_this call OT_fnc_onNameKeyDown;";
			text = "Base";
		};
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;
			text = "Enter a name for your new base"; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			text = "Done"; //--- ToDo: Localize;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "_this call OT_fnc_onNameDone";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class OT_dialog_input
{
	idd=8001;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1199: RscOverthrowStructuredText
		{
			idc = 1199;
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.252656 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Fuxuza)
		////////////////////////////////////////////////////////

		class RscEdit_1400: RscOverthrowEdit
		{
			idc = 1400;

			onKeyDown = "_key = _this select 1;_name = ctrltext 1400;if(_key == 28 && _name != """") then {[] call inputHandler;closeDialog 0;}";
			text = ""; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;

			text = ""; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			action = "_this call OT_inputHandler;closeDialog 0;";
			text = "OK"; //--- ToDo: Localize;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class OT_dialog_place
{
	idd=8002;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1199: RscOverthrowStructuredText
		{
			idc = 1199;
			x = -0.000156274 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 1.00031 * safezoneW;
			h = 0.11 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};

	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Jevede)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			action = "closeDialog 0;'Sandbags' spawn OT_fnc_place";

			text = "Sandbags"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Light defense"; //--- ToDo: Localize;
		};
		class RscButton_1601: RscOverthrowButton
		{
			idc = 1601;
			action = "closeDialog 0;'Camo Nets' spawn OT_fnc_place";

			text = "Camo Nets"; //--- ToDo: Localize;
			x = 0.7475 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Hide from the helicopters"; //--- ToDo: Localize;
		};
		class RscButton_1602: RscOverthrowButton
		{
			idc = 1602;
			action = "closeDialog 0;'Barriers' spawn OT_fnc_place";

			text = "Barriers"; //--- ToDo: Localize;
			x = 0.649531 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Medium defense"; //--- ToDo: Localize;
		};
		class RscButton_1603: RscOverthrowButton
		{
			idc = 1603;
			action = "closeDialog 0;'Camp' spawn OT_fnc_place";

			text = "Camp"; //--- ToDo: Localize;
			x = 0.0617187 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Creates a fast travel destination"; //--- ToDo: Localize;
		};
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1604;
			action = "closeDialog 0;'Ammobox' spawn OT_fnc_place";

			text = "Ammobox"; //--- ToDo: Localize;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "An empty ammobox"; //--- ToDo: Localize;
		};
		class RscButton_1605: RscOverthrowButton
		{
			idc = 1605;
			action = "closeDialog 0;'Misc' spawn OT_fnc_place";

			text = "Misc"; //--- ToDo: Localize;
			x = 0.845469 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Miscellaneous (but useful) items"; //--- ToDo: Localize;
		};
		class RscButton_1606: RscOverthrowButton
		{
			idc = 1606;
			action = "closeDialog 0;'Base' spawn OT_fnc_place";

			text = "FOB"; //--- ToDo: Localize;
			x = 0.159687 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Creates a fast travel destination, allows building of light military structures"; //--- ToDo: Localize;
		};
		class RscButton_1607: RscOverthrowButton
		{
			idc = 1607;
			action = "closeDialog 0;'Map' spawn OT_fnc_place";

			text = "Map"; //--- ToDo: Localize;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "A map"; //--- ToDo: Localize;
		};
		class RscButton_1608: RscOverthrowButton
		{
			idc = 1608;
			action = "closeDialog 0;'Safe' spawn OT_fnc_place";

			text = "Safe"; //--- ToDo: Localize;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Store and retrieve money"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
