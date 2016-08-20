class AIT_dialog_start
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Rofuji)
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
			action = "closeDialog 0;'actions\loadGame.sqf' remoteExec ['execVM',2];";
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

class AIT_dialog_vehicle
{
	idd=-1;
	movingenable=false;
	
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Xeqozy)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Fast Travel"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			action = "closeDialog 0;[] spawn fastTravel;"
			tooltip = "Fast travels this vehicle and it's occupants"; //--- ToDo: Localize;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Transfer To"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Transfers the contents of the closest container into this vehicle"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn transferFrom;"
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Transfer From"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Transfers the contents of this vehicle into the closest container"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn transferTo;"
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Transfer Legit"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Transfers only legal (sellable) items from the closest container into this vehicle"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn transferLegit;"
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	}
}

class AIT_dialog_command
{
	idd=-1;
	movingenable=false;
	
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Xeqozy)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Fast Travel Unit/s"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.39 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Fast travels all selected units that are not currently wanted"; //--- ToDo: Localize;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Loot"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Commands all selected units to loot bodies and fill closest container to you"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn loot;"
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Open Inventory"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Commands first unit selected to walk to and open the closest container to you"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn openInventory;"
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Rearm"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Commands all selected units to find ammo in the surrounding area"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	}
}

class AIT_dialog_options
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Wiwiho)
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
			action = "closeDialog 0;'actions\saveGame.sqf' remoteExec ['execVM',2];";
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
	idd=8001;
	movingenable=false;	

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Giqadi)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;[] spawn fastTravel";

			text = "Fast Travel"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;

			x = 0.005 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.121 * safezoneH;
			colorBackground[] = {0,0,0,0.4};
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;

			text = "Place"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
			action = "closeDialog 0;createDialog 'AIT_dialog_place'";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;

			text = "Build"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
			action = "closeDialog 0;[] spawn buildMenu";
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;

			text = "Manage Recruits"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
			action = "[] spawn manageRecruits;"
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;

			text = "#(argb,8,8,3)color(0,0,0,0)";
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;

			text = "Recruit"; //--- ToDo: Localize;
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;[] spawn recruitCiv";
		};
		class RscButton_1606: RscButton
		{
			idc = 1606;

			text = "Get Intel"; //--- ToDo: Localize;
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			action = "closeDialog 0;[] call getIntel";
		};
		class RscButton_1607: RscButton
		{
			idc = 1607;

			text = "Give $100"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn giveMoney";
			x = 0.943438 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicture_1201: RscPicture
		{
			idc = 1201;

			text = "#(argb,8,8,3)color(0,0,0,0)";
			x = 0.762969 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class RscButton_1608: RscButton
		{
			idc = 1608;

			text = "Buy"; //--- ToDo: Localize;
			action = "closeDialog 0;[] call buyBuilding";
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscButton_1609: RscButton
		{
			idc = 1609;

			text = "Lease"; //--- ToDo: Localize;
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			action = "hint 'Not yet implemented'";
		};
		class RscButton_1610: RscButton
		{
			idc = 1610;

			text = "Set Home"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn setHome";
			x = 0.943438 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;

			x = 0.881562 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.143 * safezoneH;
			colorBackground[] = {0,0,0,0.4};
		};
		class RscStructuredText_1102: RscStructuredText
		{
			idc = 1102;

			x = 0.881562 * safezoneW + safezoneX;
			y = 0.632 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.143 * safezoneH;
			colorBackground[] = {0,0,0,0.4};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////


	};
};