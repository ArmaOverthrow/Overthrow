class OT_dialog_resistance
{
	idd=8000;
	movingenable=false;

	class controlsBackground {
		class RscStructuredText_1100: RscOverthrowStructuredText
		{
			idc = 1100;
            x = 0.237031 * safezoneW + safezoneX;
            y = 0.17 * safezoneH + safezoneY;
            w = 0.525937 * safezoneW;
            h = 0.671 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	}

	class controls
	{
        ////////////////////////////////////////////////////////
        // GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Defoki)
        ////////////////////////////////////////////////////////

        class RscStructuredText_1101: RscOverthrowStructuredText
        {
            idc = 1101;
            text = "<t align='center' size='2'>Resistance</t>"; //--- ToDo: Localize;
            x = 0.242187 * safezoneW + safezoneX;
            y = 0.181 * safezoneH + safezoneY;
            w = 0.515625 * safezoneW;
            h = 0.044 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorActive[] = {0,0,0,0};
        };
        class RscListbox_1500: RscOverthrowListbox
        {
            idc = 1500;
            x = 0.298906 * safezoneW + safezoneX;
            y = 0.236 * safezoneH + safezoneY;
            w = 0.242344 * safezoneW;
            h = 0.165 * safezoneH;
			onLBSelChanged = "_this call OT_fnc_showMemberInfo";
        };
        class RscStructuredText_1102: RscOverthrowStructuredText
        {
            idc = 1102;
            x = 0.546406 * safezoneW + safezoneX;
            y = 0.236 * safezoneH + safezoneY;
            w = 0.154687 * safezoneW;
            h = 0.11 * safezoneH;
            colorBackground[] = {0,0,0,0.2};
            colorActive[] = {0,0,0,0};
        };
        class RscButton_1600: RscOverthrowButton
        {
            idc = 1600;
            text = "Make General"; //--- ToDo: Localize;
            x = 0.628906 * safezoneW + safezoneX;
            y = 0.357 * safezoneH + safezoneY;
            w = 0.0721875 * safezoneW;
            h = 0.044 * safezoneH;
			action = "[] call OT_fnc_makeGeneral;";
        };
        class RscButton_1601: RscOverthrowButton
        {
            idc = 1601;
            text = "Transfer funds"; //--- ToDo: Localize;
            x = 0.546406 * safezoneW + safezoneX;
            y = 0.357 * safezoneH + safezoneY;
            w = 0.0721875 * safezoneW;
            h = 0.044 * safezoneH;
			action = "[] call OT_fnc_transferFunds;";
        };
        class RscStructuredText_1103: RscOverthrowStructuredText
        {
            idc = 1103;
            text = "<t align='center' size='1.2'>Businesses</t>"; //--- ToDo: Localize;
            x = 0.242187 * safezoneW + safezoneX;
            y = 0.412 * safezoneH + safezoneY;
            w = 0.515625 * safezoneW;
            h = 0.033 * safezoneH;
            colorBackground[] = {0,0,0,0};
            colorActive[] = {0,0,0,0};
        };
        class RscListbox_1501: RscOverthrowListbox
        {
            idc = 1501;
            x = 0.298906 * safezoneW + safezoneX;
            y = 0.445 * safezoneH + safezoneY;
            w = 0.242344 * safezoneW;
            h = 0.165 * safezoneH;
			onLBSelChanged = "_this call OT_fnc_showBusinessInfo";
        };
        class RscStructuredText_1104: RscOverthrowStructuredText
        {
            idc = 1104;
            x = 0.546406 * safezoneW + safezoneX;
            y = 0.445 * safezoneH + safezoneY;
            w = 0.154687 * safezoneW;
            h = 0.11 * safezoneH;
            colorBackground[] = {0,0,0,0.2};
            colorActive[] = {0,0,0,0};
        };
        class RscButton_1602: RscOverthrowButton
        {
            idc = 1602;
            text = "Fire"; //--- ToDo: Localize;
            x = 0.546406 * safezoneW + safezoneX;
            y = 0.566 * safezoneH + safezoneY;
            w = 0.0721875 * safezoneW;
            h = 0.044 * safezoneH;
        };
        class RscButton_1603: RscOverthrowButton
        {
            idc = 1603;
            text = "Hire"; //--- ToDo: Localize;
            x = 0.628906 * safezoneW + safezoneX;
            y = 0.566 * safezoneH + safezoneY;
            w = 0.0721875 * safezoneW;
            h = 0.044 * safezoneH;
        };
		class RscStructuredText_1106: RscOverthrowStructuredText
		{
			idc = 1106;

			x = 0.298906 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.121 * safezoneH;
			colorBackground[] = {0,0,0,0.2};
			colorActive[] = {0,0,0,0};
		};
		class RscButton_1604: RscOverthrowButton
		{
			idc = 1604;
			text = "Give funds"; //--- ToDo: Localize;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call OT_fnc_giveFunds;";
		};
		class RscButton_1605: RscOverthrowButton
		{
			idc = 1605;
			text = "Take funds"; //--- ToDo: Localize;
			x = 0.510313 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0979687 * safezoneW;
			h = 0.044 * safezoneH;
			action = "[] call OT_fnc_takeFunds;";
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
    }
}
