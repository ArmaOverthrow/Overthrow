class OT_dialog_buildbase
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

		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			action = "closeDialog 0;[] call cancelBuild;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1601: RscOverthrowButton
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
		class RscButton_1602: RscOverthrowButton
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
		class RscButton_1603: RscOverthrowButton
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
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1604;
			action = "'Workshop' call build";

			text = "Workshop"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Modify vehicles"; //--- ToDo: Localize;
		};
		class RscButton_1605: RscOverthrowButton
		{
			idc = 1605;
			action = "'Helipad' call build";

			text = "Helipad"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Apparently helicopters need a place to land"; //--- ToDo: Localize;
		};
		class RscButton_1606: RscOverthrowButton
		{
			idc = 1606;
			action = "'Refugee Camp' call build";

			text = "Refugee Camp"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Helps with recruiting local civilians to your cause."; //--- ToDo: Localize;
		};
		class RscButton_1607: RscOverthrowButton
		{
			idc = 1607;
			action = "'Training Camp' call build";

			text = "Training Camp"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Recruit trained and pre-equipped soldiers"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class OT_dialog_buildobjective
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

		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			action = "closeDialog 0;[] call cancelBuild;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1601: RscOverthrowButton
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
		class RscButton_1602: RscOverthrowButton
		{
			idc = 1602;
			action = "'Observation Post' call build";

			text = "Observation Post"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "A small tower that will garrison static weapons"; //--- ToDo: Localize;
		};
		class RscButton_1603: RscOverthrowButton
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
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1604;
			action = "'Warehouse' call build";

			text = "Warehouse"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Stores and retrieves items from all warehouses"; //--- ToDo: Localize;
		};
		class RscButton_1605: RscOverthrowButton
		{
			idc = 1605;
			action = "'Barracks' call build";

			text = "Barracks"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1606: RscOverthrowButton
		{
			idc = 1606;
			action = "'Workshop' call build";

			text = "Workshop"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Modify vehicles"; //--- ToDo: Localize;
		};
		class RscButton_1607: RscOverthrowButton
		{
			idc = 1607;
			action = "'Helipad' call build";

			text = "Helipad"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Apparently helicopters need a place to land"; //--- ToDo: Localize;
		};
		class RscButton_1608: RscOverthrowButton
		{
			idc = 1608;
			action = "'Guard Tower' call build";

			text = "Guard Tower"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "A huge tower. Will garrison static weapons"; //--- ToDo: Localize;
		};
		class RscButton_1609: RscOverthrowButton
		{
			idc = 1609;
			action = "'Radar' call build";

			text = "Radar"; //--- ToDo: Localize;
			x = 0.891875 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Reveals all drones, helicopters and planes within a 2.5km radius."; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class OT_dialog_buildtown
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
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Satudy)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			action = "closeDialog 0;[] call cancelBuild;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1601: RscOverthrowButton
		{
			idc = 1601;
			action = "'Workshop' call build";

			text = "Workshop"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Modify vehicles"; //--- ToDo: Localize;
		};
		class RscButton_1602: RscOverthrowButton
		{
			idc = 1602;
			action = "'House' call build";

			text = "House"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "4 Walls, a roof, maybe a door that opens if you're lucky."; //--- ToDo: Localize;
		};
		class RscButton_1603: RscOverthrowButton
		{
			idc = 1603;
			action = "'Warehouse' call build";

			text = "Warehouse"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Store items"; //--- ToDo: Localize;
		};
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1601;
			action = "'Police Station' call build";

			text = "Police Station"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Increase stability and keep the peace"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};

class OT_dialog_police
{
	idd=9000;
	movingenable=false;
	class controlsBackground
	{
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;

			text = "<t size=""2"" align=""center"">Blah Police Station</t>"; //--- ToDo: Localize;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.422812 * safezoneW;
			h = 0.572 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};
	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Pikulu)
		////////////////////////////////////////////////////////

		class RscStructuredText_1101: RscOverthrowStructuredText
		{
			idc = 1101;

			text = "<t size=""1.5"" align=""center"">Police: 2</t>"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,0.1};
			colorActive[] = {0,0,0,1};
		};
		/*
		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;

			text = "Transfer 1"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscStructuredText_1102: RscOverthrowStructuredText
		{
			idc = 1102;

			text = "<t align=""center"">Transfer to another station</t>"; //--- ToDo: Localize;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.422812 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};*/
		class RscStructuredText_1103: RscOverthrowStructuredText
		{
			idc = 1103;

			text = "<t align=""center"">Hire police</t>"; //--- ToDo: Localize;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.422812 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		class RscStructuredText_1104: RscOverthrowStructuredText
		{
			idc = 1104;

			text = "<t size=""1.2"" align=""center"">Effects</t><br/><br/><t size=""0.8"" align=""center"">+1 Stability/10 mins</t>"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {0,0,0,0.1};
			colorActive[] = {0,0,0,1};
		};
		class RscButton_1608: RscOverthrowButton
		{
			idc = 1608;

			text = "Edit Loadout"; //--- ToDo: Localize;
			x = 0.4175 * safezoneW + safezoneX;
			y = 0.73 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.033 * safezoneH;
			action = "[] call OT_fnc_editPoliceLoadout";
		};
		/*
		class RscButton_1601: RscOverthrowButton
		{
			idc = 1601;

			text = "Transfer 2"; //--- ToDo: Localize;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1602: RscOverthrowButton
		{
			idc = 1602;

			text = "Transfer 4"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
		};
		class RscButton_1603: RscOverthrowButton
		{
			idc = 1603;

			text = "Transfer All"; //--- ToDo: Localize;
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
		};
		*/
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1604;

			text = "+1"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
			action = "1 call OT_fnc_addPolice;";
		};
		class RscButton_1605: RscOverthrowButton
		{
			idc = 1605;

			text = "+2"; //--- ToDo: Localize;
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
			action = "2 call OT_fnc_addPolice;";
		};
		class RscButton_1606: RscOverthrowButton
		{
			idc = 1606;

			text = "+4"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
			action = "4 call OT_fnc_addPolice;";
		};
		class RscButton_1607: RscOverthrowButton
		{
			idc = 1607;

			text = "+8"; //--- ToDo: Localize;
			x = 0.634062 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.077 * safezoneH;
			action = "8 call OT_fnc_addPolice;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};
