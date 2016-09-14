class AIT_dialog_name
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Votehi)
		////////////////////////////////////////////////////////

		class RscEdit_1400: RscEdit
		{
			idc = 1400;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.242344 * safezoneW;
			h = 0.055 * safezoneH;		
			onKeyDown = "_this call onNameKeyDown;";
			text = "Base";
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = "Enter a name for your new base"; //--- ToDo: Localize;
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Done"; //--- ToDo: Localize;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "_this call onNameDone";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class AIT_dialog_place
{
	idd=8002;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Jawatu)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;'Sandbags' spawn placementMode";

			text = "Sandbags"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Light defense"; //--- ToDo: Localize;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "closeDialog 0;'Camo Nets' spawn placementMode";

			text = "Camo Nets"; //--- ToDo: Localize;
			x = 0.7475 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Hide from the helicopters"; //--- ToDo: Localize;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			action = "closeDialog 0;'Barriers' spawn placementMode";

			text = "Barriers"; //--- ToDo: Localize;
			x = 0.649531 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Medium defense"; //--- ToDo: Localize;
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			action = "closeDialog 0;'Camp' spawn placementMode";

			text = "Camp"; //--- ToDo: Localize;
			x = 0.159687 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Creates a fast travel destination for you and your group"; //--- ToDo: Localize;
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			action = "closeDialog 0;'Ammobox' spawn placementMode";

			text = "Ammobox"; //--- ToDo: Localize;
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "An empty ammobox"; //--- ToDo: Localize;
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			action = "closeDialog 0;'Misc' spawn placementMode";

			text = "Misc"; //--- ToDo: Localize;
			x = 0.453594 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Miscellaneous (but useful) items"; //--- ToDo: Localize;
		};
		class RscButton_1606: RscButton
		{
			idc = 1603;
			action = "closeDialog 0;'Base' spawn placementMode";

			text = "Base"; //--- ToDo: Localize;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			tooltip = "Creates a fast travel destination for all friendlies, allows building of military structures"; //--- ToDo: Localize;
		};		
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};