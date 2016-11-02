class OT_dialog_buy
{
	idd=8000;
	movingenable=false;
	
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Jeduvu)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListbox
		{
			idc = 1500;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
			onLBSelChanged = "_this call displayShopPic";
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "";
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Buy"; //--- ToDo: Localize;
			x = 0.752656 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.099 * safezoneH;	
			colorBackground[] = {0,0,0,0.8};			
			action = "[] call buy;";
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.265 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};

class OT_dialog_sell
{
	idd=-1;
	movingenable=false;

	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Fylaby)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListBox
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
			action = "[] call sell;";

			text = "Sell 1"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "closeDialog 0;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscButton_1602: RscButton
		{
			idc = 1600;
			action = "[] call sellall;";

			text = "Sell All"; //--- ToDo: Localize;
			x = 0.613437 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class OT_dialog_workshop
{
	idd=8000;
	movingenable=false;
	
	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Jimepa)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscListBox
		{
			idc = 1500;
			onLBSelChanged = "_this call displayShopPic";

			x = 0.247344 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "[] call workshopAdd;";

			text = "Add"; //--- ToDo: Localize;
			x = 0.752656 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.099 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;

			x = 0.654688 * safezoneW + safezoneX;
			y = 0.3999 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.265001 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;
			text = "<t size=""2"" align=""center"">Workshop</t>"; //--- ToDo: Localize;
			x = 0.2525 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.391875 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		class RscPicture_1201: RscPicture
		{
			idc = 1201;

			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.783594 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class RscStructuredText_1102: RscStructuredText
		{
			idc = 1102;
			text = "<t size=""2"" align=""center"">&gt;&gt;</t>"; //--- ToDo: Localize;
			x = 0.752656 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////




	};
};