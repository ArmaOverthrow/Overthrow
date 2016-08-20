class AIT_dialog_buildbase
{
	idd=-1;
	movingenable=false;	
	onMouseMoving = "_this call buildOnMouseMove";
	onMouseButtonDown = "_this call buildOnMouseDown";
	onMouseButtonUp = "_this call buildOnMouseUp";
	onMouseZChanged = "_this call buildOnMouseWheel";
	onKeyDown = "_this call buildOnKeyDown";
	onKeyUp = "_this call buildOnKeyUp";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Aaron Static, v1.063, #Qytyja)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;[] call cancelBuild;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "'Walls' call build";

			text = "Walls"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Stop people (or tanks) from getting in"; //--- ToDo: Localize;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			action = "'Training Camp' call build";

			text = "Training Camp"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Allows training of recruits and hiring of mercenaries"; //--- ToDo: Localize;
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			action = "'Bunkers' call build";

			text = "Bunkers"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Small defensive structures"; //--- ToDo: Localize;
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			action = "'Helipad' call build";

			text = "Helipad"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Apparently helicopter pilots need to be told where they are allowed to land"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	}
};