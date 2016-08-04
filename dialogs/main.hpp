class AIT_dialog_main
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Aaron Static, v1.063, #Syqojo)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Recruit Civ"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;[] call recruitCiv;";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Buy Building"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;[] call buyBuilding;";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Buy Ammobox"; //--- ToDo: Localize;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;[] spawn buyAmmobox;";
		};
		class RscButton_1603: RscButton
		{
			idc = 1604;
			text = "Set Home"; //--- ToDo: Localize;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;[] call setHome;";
		};
		class RscButton_1604: RscButton
		{
			idc = 1603;
			text = "Give $100"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[] call giveMoney;";
		};
		class RscButton_1605: RscButton
		{
			idc = 1606;
			text = "Fast Travel"; //--- ToDo: Localize;
			x = 0.556719 * safezoneW + safezoneX;
			y = 0.764 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "closeDialog 0;[] spawn fastTravel;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};