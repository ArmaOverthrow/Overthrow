class OT_dialog_recruits
{
	idd=8004;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1199: RscOverthrowStructuredText
		{
			idc = 1199;
			x = 0.242187 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.654844 * safezoneW;
			h = 0.572 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Viwapa)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscOverthrowListbox
		{
			idc = 1500;
			x = 0.206094 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.360937 * safezoneW;
			h = 0.418 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			onLBSelChanged = "_this call recruitSelected";
		};
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.33 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			text = "Dismiss"; //--- ToDo: Localize;
			x = 0.711406 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.077 * safezoneH;
			colorBackground[] = {0.5,0,0,1};
			colorActive[] = {0.6,0,0,1};
			action = "_this call dismissRecruit;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
