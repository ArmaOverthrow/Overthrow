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
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Qytyja)
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
			action = "'Observation Post' call build";

			text = "Observation Post"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Provides intel about the area"; //--- ToDo: Localize;
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

class AIT_dialog_buildobjective
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
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Jatizu)
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
			action = "'Observation Post' call build";

			text = "Observation Post"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Provides intel about the area"; //--- ToDo: Localize;
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
		class RscButton_1605: RscButton
		{
			idc = 1600;
			action = "'Barracks' call build";

			text = "Barracks"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1606: RscButton
		{
			idc = 1602;
			action = "'Workshop' call build";

			text = "Workshop"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Repair, rearm and modify vehicles"; //--- ToDo: Localize;
		};
		class RscButton_1607: RscButton
		{
			idc = 1603;
			action = "'Hangar' call build";

			text = "Hangar"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Keep planes out of the rain"; //--- ToDo: Localize;
		};
		class RscButton_1608: RscButton
		{
			idc = 1603;
			action = "'Guard Tower' call build";

			text = "Guard Tower"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Sometimes you need to get above the trees to see what's happening. Comes with 2 x Static MGs."; //--- ToDo: Localize;
		};
		class RscButton_1609: RscButton
		{
			idc = 1603;
			action = "'Fuel Station' call build";

			text = "Fuel Station"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Refuels stuff"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	}
};

class AIT_dialog_buildtown
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
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Qytyja)
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
			action = "'Observation Post' call build";

			text = "Observation Post"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Provides intel about the area"; //--- ToDo: Localize;
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