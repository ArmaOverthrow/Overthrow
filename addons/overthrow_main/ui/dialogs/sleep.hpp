class OT_sleep_dialog {
  idd = 152001;
  name = "sleep";
	movingEnable = false;
	enableSimulation = true;
	onLoad = " [152001] spawn OT_fnc_dialogFadeIn; ";

  class controlsBackground {
    class Background1: RscText
    {
    	idc = -1;
      fade = 1;
    	text = "";
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.423 * safezoneH + safezoneY;
    	w = 0.257813 * safezoneW;
    	h = 0.022 * safezoneH;
    	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
    };
    class Background2: RscText
    {
    	idc = -1;
      fade = 1;
    	text = "";
    	x = 0.37625 * safezoneW + safezoneX;
    	y = 0.445 * safezoneH + safezoneY;
    	w = 0.257813 * safezoneW;
    	h = 0.132 * safezoneH;
    	colorBackground[] = {-1,-1,-1,0.7};
    };
  };

  class controls {
    class Question: RscText
    {
    	idc = -1;
      fade = 1;
      style = 0x02;
      font = "PuristaBold";
      sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    	text = "HOW LONG WOULD YOU LIKE TO SLEEP?"; //--- ToDo: Localize;
    	x = 0.386562 * safezoneW + safezoneX;
    	y = 0.456 * safezoneH + safezoneY;
    	w = 0.237187 * safezoneW;
    	h = 0.033 * safezoneH;
    };
    class SleepSlider: RscSlider
    {
    	idc = 1;
      fade = 1;
    	x = 0.386562 * safezoneW + safezoneX;
    	y = 0.5 * safezoneH + safezoneY;
    	w = 0.237187 * safezoneW;
    	h = 0.022 * safezoneH;
      onLoad = "(_this#0) sliderSetRange [1, 48]; OT_sleepTime = 1;";
      onSliderPosChanged = "((findDisplay 152001) displayCtrl 10) ctrlSetText format['%1 Hour(s)',round (_this#1)]; OT_sleepTime = (round (_this#1));";
    };
    class SleepButton: RscButton
    {
    	idc = -1;
      fade = 1;
    	text = "SLEEP"; //--- ToDo: Localize;
    	x = 0.494844 * safezoneW + safezoneX;
    	y = 0.533 * safezoneH + safezoneY;
    	w = 0.134062 * safezoneW;
    	h = 0.033 * safezoneH;
      onButtonClick = "[] remoteExec [""OT_fnc_startSleeping"",[0,-2] select isDedicated,false]; [] spawn {uiSleep 8; OT_sleepTime remoteExec [""skipTime"",2]; }";
      colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
    };
    class SelectedTime: RscText
    {
    	idc = 10;
      fade = 1;
      style = 0x02;
    	text = "X Hour(s)"; //--- ToDo: Localize;
    	x = 0.386563 * safezoneW + safezoneX;
    	y = 0.533 * safezoneH + safezoneY;
    	w = 0.0928125 * safezoneW;
    	h = 0.033 * safezoneH;
      font = "PuristaMedium";
      onLoad = "(_this#0) ctrlSetText '1 Hour(s)'";
    };

  };
};
