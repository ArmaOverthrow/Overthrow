class AIT_dialog_buy
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Aaron Static, v1.063, #Zobiki)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Buy"; //--- ToDo: Localize;
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[] call buy;";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Close"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = ""; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};

class AIT_dialog_sell
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Aaron Static, v1.063, #Zobiki)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Sell"; //--- ToDo: Localize;
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[] call sell;";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Close"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;";
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = ""; //--- ToDo: Localize;
			x = 0.391719 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};
