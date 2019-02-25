class OT_dialog_factoryold
{
	idd=8000;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1199: RscOverthrowStructuredText
		{
			idc = 1199;
            x = 0.29375 * safezoneW + safezoneX;
        	y = 0.214 * safezoneH + safezoneY;
        	w = 0.4125 * safezoneW;
        	h = 0.566 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};

	class controls
	{
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Lolemu)
        ////////////////////////////////////////////////////////

        class RscListbox_1500: RscOverthrowListbox
        {
            idc = 1500;
            x = 0.298906 * safezoneW + safezoneX;
        	y = 0.577 * safezoneH + safezoneY;
        	w = 0.293906 * safezoneW;
        	h = 0.132 * safezoneH;
            onLBSelChanged = "_this call OT_fnc_showFactoryPic";
        };
        class RscStructuredText_1100: RscOverthrowStructuredText
        {
            idc = 1100;
            text = "<t size='1.5' align='center'>Factory</t><br/><t size='0.8' align='center'>Currently producing</t>"; //--- ToDo: Localize;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.225 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.066 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorActive[] = {0,0,0,0};
        };
        class RscPicture_1200: RscOverthrowPicture
        {
            idc = 1200;
            text = "#(argb,8,8,3)color(1,1,1,1)";
            x = 0.45875 * safezoneW + safezoneX;
            y = 0.302 * safezoneH + safezoneY;
            w = 0.0825 * safezoneW;
            h = 0.121 * safezoneH;
        };
        class RscStructuredText_1101: RscOverthrowStructuredText
        {
            idc = 1101;
            text = "<t size='0.8' align='center'>Change production</t>"; //--- ToDo: Localize;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.533 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.022 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorActive[] = {0,0,0,0};
        };
        class RscStructuredText_1102: RscOverthrowStructuredText
        {
            idc = 1102;
            text = "<t size='0.65' align='center'></t>"; //--- ToDo: Localize;
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.434 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.088 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorActive[] = {0,0,0,0};
        };
        class RscPicture_1201: RscOverthrowPicture
        {
            idc = 1201;
            text = "#(argb,8,8,3)color(1,1,1,1)";
            x = 0.597969 * safezoneW + safezoneX;
            y = 0.577 * safezoneH + safezoneY;
            w = 0.103125 * safezoneW;
            h = 0.132 * safezoneH;
        };
        class RscButton_1600: RscOverthrowButton
        {
            idc = 1600;
            text = "Clear"; //--- ToDo: Localize;
            x = 0.298906 * safezoneW + safezoneX;
            y = 0.72 * safezoneH + safezoneY;
            w = 0.103125 * safezoneW;
            h = 0.055 * safezoneH;
            action = "[] call OT_fnc_factoryClear;";
        };
        class RscButton_1601: RscOverthrowButton
        {
            idc = 1601;
            text = "Set"; //--- ToDo: Localize;
            x = 0.597969 * safezoneW + safezoneX;
            y = 0.72 * safezoneH + safezoneY;
            w = 0.103125 * safezoneW;
            h = 0.055 * safezoneH;
            action = "[] call OT_fnc_factorySet;";
        };
        class RscButton_1602: RscOverthrowButton
        {
            idc = 1602;
            text = "Reverse-Engineer"; //--- ToDo: Localize;
            x = 0.448438 * safezoneW + safezoneX;
            y = 0.72 * safezoneH + safezoneY;
            w = 0.103125 * safezoneW;
            h = 0.055 * safezoneH;
            action = "closeDialog 0;[] call OT_fnc_reverseEngineerDialog;";
        };
        class RscButton_1603: RscOverthrowButton
        {
            idc = 1603;
            text = "X"; //--- ToDo: Localize;
            x = 0.675312 * safezoneW + safezoneX;
            y = 0.236 * safezoneH + safezoneY;
            w = 0.0257812 * safezoneW;
            h = 0.044 * safezoneH;
            action = "closeDialog 0";
        };
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT END
        ////////////////////////////////////////////////////////




	};
};


class OT_dialog_factory
{
	idd=8000;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1199: RscOverthrowStructuredText
		{
			idc = 1199;
			x = 0.21125 * safezoneW + safezoneX;
			y = 0.093 * safezoneH + safezoneY;
			w = 0.562031 * safezoneW;
			h = 0.803 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	};

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Fotyke)
		////////////////////////////////////////////////////////

		class RscStructuredText_1104: RscOverthrowStructuredText
		{
			idc = 1104;
			text = "<t align=""center"" size=""1.8"">Factory</t>"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.104 * safezoneH + safezoneY;
			w = 0.232031 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1608: RscOverthrowButton
		{
			idc = 1608;
			text = "Reverse-Engineer"; //--- ToDo: Localize;
			x = 0.432969 * safezoneW + safezoneX;
			y = 0.797 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.066 * safezoneH;
			action = "closeDialog 0;[] call OT_fnc_reverseEngineerDialog;";
		};
		class RscListbox_1500: RscOverthrowListbox
		{
			idc = 1500;
			x = 0.216406 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.616 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
			onLBSelChanged = "call OT_fnc_factoryRefresh";
		};
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.33 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class RscListbox_1501: RscOverthrowListbox
		{
			idc = 1501;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.257813 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class RscButton_1603: RscOverthrowButton
		{
			idc = 1603;
			text = "+1"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[1] call OT_fnc_factoryQueueAdd";
		};
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1604;
			text = "+10"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[10] call OT_fnc_factoryQueueAdd";
		};
		class RscButton_1605: RscOverthrowButton
		{
			idc = 1605;
			text = "+100"; //--- ToDo: Localize;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "[100] call OT_fnc_factoryQueueAdd";
		};
		class RscStructuredText_1101: RscOverthrowStructuredText
		{
			idc = 1101;
			text = "<t size=""0.9"">Build Queue</t>"; //--- ToDo: Localize;
			x = 0.438125 * safezoneW + safezoneX;
			y = 0.291 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscStructuredText_1102: RscOverthrowStructuredText
		{
			idc = 1102;
			text = "<t size=""0.9"">Blueprints</t>"; //--- ToDo: Localize;
			x = 0.216406 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1606: RscOverthrowButton
		{
			idc = 1606;
			text = "Remove"; //--- ToDo: Localize;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "call OT_fnc_factoryQueueRemove";
		};
		class RscButton_1607: RscOverthrowButton
		{
			idc = 1607;
			text = "Remove All"; //--- ToDo: Localize;
			x = 0.701094 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.055 * safezoneH;
			action = "call OT_fnc_factoryQueueRemoveAll";
		};
		class RscPicture_1200: RscOverthrowPicture
		{
			idc = 1200;
			text = "";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.11 * safezoneH;
		};
		class RscStructuredText_1103: RscOverthrowStructuredText
		{
			idc = 1103;
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.275 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};


class OT_dialog_reverse
{
	idd=-1;
	movingenable=false;

	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Fylaby)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscOverthrowListBox
		{
			idc = 1500;

			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class RscButton_1601: RscOverthrowButton
		{
			idc = 1601;
			action = "closeDialog 0;";

			text = "Close"; //--- ToDo: Localize;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.055 * safezoneH;
		};
		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			action = "[] call OT_fnc_reverseEngineer;";

			text = "Reverse-Engineer"; //--- ToDo: Localize;
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

class OT_dialog_craft
{
	idd=8000;
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
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Jeduvu)
		////////////////////////////////////////////////////////

		class RscListbox_1500: RscOverthrowListbox
		{
			idc = 1500;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
			onLBSelChanged = "_this call OT_fnc_displayCraftItem";
		};
		class RscPicture_1200: RscOverthrowPicture
		{
			idc = 1200;
			text = "";
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class RscButton_1600: RscOverthrowButton
		{
			idc = 1600;
			text = "Craft"; //--- ToDo: Localize;
			x = 0.752656 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.099 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
			action = "[] call OT_fnc_craft;";
		};
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.4 * safezoneH + safezoneY;
			w = 0.237187 * safezoneW;
			h = 0.265 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		class RscButton_1699: RscOverthrowButton
        {
            idc = 1699;
            text = "X"; //--- ToDo: Localize;
			action = "closeDialog 0";
            x = 0.732031 * safezoneW + safezoneX;
            y = 0.181 * safezoneH + safezoneY;
            w = 0.0257812 * safezoneW;
            h = 0.044 * safezoneH;
        };
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};
