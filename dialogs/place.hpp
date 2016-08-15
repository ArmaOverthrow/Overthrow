class AIT_dialog_place
{
	idd=8002;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Lyxyxu)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Sandbags"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			action = "closeDialog 0;'Sandbags' spawn placementMode";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Camo Nets"; //--- ToDo: Localize;
			x = 0.597969 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			action = "closeDialog 0;'Camo Nets' spawn placementMode";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Barriers"; //--- ToDo: Localize;
			x = 0.695937 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			action = "closeDialog 0;'Barriers' spawn placementMode";
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Camp"; //--- ToDo: Localize;
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			action = "closeDialog 0;'Camp' spawn placementMode";
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			text = "Ammobox"; //--- ToDo: Localize;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			action = "closeDialog 0;'Ammobox' spawn placementMode";
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			text = "Whiteboard"; //--- ToDo: Localize;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.088 * safezoneH;
			action = "closeDialog 0;'Whiteboard' spawn placementMode";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};