/*
class RscCustomInfoMiniMap
{
	class controls
	{
		class MiniMap
		{
			class Controls
			{
				class CA_MiniMap
				{
					onDraw = "if (!isNil 'OT_fnc_mapHandler') then { _this call OT_fnc_mapHandler; };";
				};
			};
		};
	};
};

class RscDisplayMainMap {
    class controlsBackground {
        class CA_Map {
            onDraw = "if (!isNil 'OT_fnc_mapHandler') then { _this call OT_fnc_mapHandler; };";
        };
    };
};
*/

class RscMapControl {
    onDraw = "_this call (missionNameSpace getVariable ['OT_fnc_mapHandler',{}]);";
};

class RscStructuredText;
class OTRscDynamicText: RscStructuredText
{
	style = "1 + 16";
	text = "";
	x = 0;
	y = 0.45;
	w = 1;
	h = 10000;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	size = "(0.05 / 1.17647) * safezoneH";
	sizeEx = 0.4;
	class Attributes
	{
		color = "#ffffff";
		align = "center";
		shadow = 0;
		valign = "top";
	};
};