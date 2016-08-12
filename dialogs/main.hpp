class AIT_dialog_start
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Aaron Static, v1.063, #Rofuji)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Load Persistent Save"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Continue previous save"; //--- ToDo: Localize;
			action = "closeDialog 0;[] remoteExec ['loadGamePersistent',2];";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "New Game"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Starts a new game (Please note, saving will overwrite any previous games)"; //--- ToDo: Localize;
			action = "closeDialog 0;[] remoteExec ['newGame',2];";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};


class AIT_dialog_options
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Aaron Static, v1.063, #Wiwiho)
		////////////////////////////////////////////////////////

		class RscText_1001: RscText
		{
			idc = 1001;
			text = "Overthrow.Tanoa"; //--- ToDo: Localize;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.088 * safezoneH;
			sizeEx = 2 * GUI_GRID_H;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Persistent Save"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "A more secure save than default, this will work across updates of both Arma and Overthrow"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn saveGamePersistent;";
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Civ % --"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Decreases the amount of civilians that spawn in towns"; //--- ToDo: Localize;
			action = "AIT_spawnCivPercentage = AIT_spawnCivPercentage - 0.01; if(AIT_spawnCivPercentage < 0) then {AIT_spawnCivPercentage = 0};publicVariable 'AIT_spawnCivPercentage';hint format['Civilian spawn now at %1%2',AIT_spawnCivPercentage*100,'%'];";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Civ % ++"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Increases the amount of civilians that spawn in towns"; //--- ToDo: Localize;
			action = "AIT_spawnCivPercentage = AIT_spawnCivPercentage + 0.01; if(AIT_spawnCivPercentage < 0) then {AIT_spawnCivPercentage = 0};publicVariable 'AIT_spawnCivPercentage';hint format['Civilian spawn now at %1%2',AIT_spawnCivPercentage*100,'%'];";
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Clean bodies"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Deletes all dead bodies"; //--- ToDo: Localize;
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			text = "Clean vehicles"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Deletes all destroyed vehicles (damaged ones will remain)"; //--- ToDo: Localize;
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			text = "Clean All"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Deletes all dead bodies and damaged vehicles, including both stolen and purchased. You have been warned."; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

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