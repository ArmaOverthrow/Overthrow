class OT_dialog_factory
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
        	h = 0.561 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	}

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
            text = "<t size='0.65' align='center'>Bandage (Elastic)</t>"; //--- ToDo: Localize;
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
