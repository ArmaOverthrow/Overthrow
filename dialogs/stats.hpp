class RscTitles {

	class Default {
       idd = -1;
       fadein = 0;
       fadeout = 0;
       duration = 0;
	};
    class AIT_statsHUD {
        idd = 745;
        movingEnable =  0;
        enableSimulation = 1;
        enableDisplay = 1;
        duration     =  10e10;
        fadein       =  0;
        fadeout      =  0;
        name = "AIT_statsHUD";
		onLoad = "with uiNameSpace do { AIT_statsHUD = _this select 0 }";
		class controls {
		    class structuredText {
                access = 0;
                type = 13;
                idc = 1001;
                style = 0x00;
                lineSpacing = 1;
				x = safezoneX + (0.8 * safezoneW);
				y = safezoneY + (0.15 * safezoneH);
				w = 0.19 * safezoneW;
				h = 0.1 * safezoneH;
                size = 0.055;//0.020
                colorBackground[] = {0,0,0,0.2};
                colorText[] = {0.34,0.33,0.33,0};//{1,1,1,1}
                text = "";
                font = "PuristaMedium";
					class Attributes {
						font = "PuristaMedium";
						color = "#C1C0BB";//"#FFFFFF";
						align = "RIGHT";
						valign = "top";
						shadow = true;
						shadowColor = "#000000";
						underline = false;
						size = "4";//4
					};
            };
		};
	};
};