class OT_dialog_start
{
	idd=-1;
	movingenable=false;
	
	class controlsBackground {
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.137 * safezoneH + safezoneY;
			w = 0.252656 * safezoneW;
			h = 0.407 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	}

	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Peqoja)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;'actions\loadGame.sqf' remoteExec ['execVM',2];";

			text = "Load Persistent Save"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Continue previous save"; //--- ToDo: Localize;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "closeDialog 0;[] remoteExec ['newGame',2];";

			text = "New Game"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Starts a new game (Please note, saving will overwrite any previous games)"; //--- ToDo: Localize;
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\ot\ui\logo_overthrow.paa";
			x = 0.399969 * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.363 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class OT_dialog_vehicle
{
	idd=-1;
	movingenable=false;
	
	class controlsBackground {
		class RscStructuredText_1103: RscStructuredText
		{
			idc = 1103;

			text = "";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	
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
			action = "closeDialog 0;[] spawn fastTravel;";
			tooltip = "Fast travels this vehicle and it's occupants"; //--- ToDo: Localize;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Transfer From"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Transfers the contents of the closest container into this vehicle"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn transferFrom;";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Transfer To"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Transfers the contents of this vehicle into the closest container"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn transferTo;";
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
			action = "closeDialog 0;[] spawn transferLegit;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	}
}

class OT_dialog_command
{
	idd=-1;
	movingenable=false;
	
	class controlsBackground {
		class RscStructuredText_1103: RscStructuredText
		{
			idc = 1103;

			text = "";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Xeqozy)
		////////////////////////////////////////////////////////

		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Loot"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Commands all selected units to loot bodies and fill closest container to them"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn loot;";
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Open Inventory"; //--- ToDo: Localize;
			x = 0.0204687 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.0876563 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Commands first unit selected to walk to and open the closest container to them"; //--- ToDo: Localize;
			action = "closeDialog 0;[] spawn openInventory;";
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	}
}

class OT_dialog_options
{
	idd=-1;
	movingenable=false;

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Kawovy)
		////////////////////////////////////////////////////////

		class RscText_1001: RscText
		{
			idc = 1001;

			text = "Overthrow.Tanoa"; //--- ToDo: Localize;
			x = 14.5 * GUI_GRID_W + GUI_GRID_X;
			y = -1 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 4 * GUI_GRID_H;
			sizeEx = 2 * GUI_GRID_H * GUI_GRID_H;
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;'actions\saveGame.sqf' remoteExec ['execVM',2];";

			text = "Persistent Save"; //--- ToDo: Localize;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "A more secure save than default, this will work across updates of both Arma and Overthrow. To load this just restart the mission and choose ""load persistent""."; //--- ToDo: Localize;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "OT_spawnCivPercentage = OT_spawnCivPercentage - 0.01; if(OT_spawnCivPercentage < 0) then {OT_spawnCivPercentage = 0};publicVariable 'OT_spawnCivPercentage';hint format['Civilian spawn now at %1%2',OT_spawnCivPercentage*100,'%'];";

			text = "Civ % --"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Decreases the amount of civilians that spawn in towns"; //--- ToDo: Localize;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			action = "OT_spawnCivPercentage = OT_spawnCivPercentage + 0.01; if(OT_spawnCivPercentage < 0) then {OT_spawnCivPercentage = 0};publicVariable 'OT_spawnCivPercentage';hint format['Civilian spawn now at %1%2',OT_spawnCivPercentage*100,'%'];";

			text = "Civ % ++"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Increases the amount of civilians that spawn in towns"; //--- ToDo: Localize;
		};
		class RscButton_1603: RscButton
		{
			idc = 1600;
			action = "{deleteVehicle _x} foreach(alldeadmen);hint ""Cleaned all dead bodies"";";

			text = "Clean all dead bodies"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Will completely destroy all dead bodies, including your own"; //--- ToDo: Localize;
		};
		class RscButton_1604: RscButton
		{
			idc = 1600;
			action = "{if (!alive _x) then {deletevehicle _x}} foreach(vehicles);hint ""Cleaned all wrecks"";";

			text = "Clean all wrecks"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.118594 * safezoneW;
			h = 0.077 * safezoneH;
			tooltip = "Removes all wrecks"; //--- ToDo: Localize;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class OT_dialog_main
{
	idd=8001;
	movingenable=false;	

	class controlsBackground {
		class RscStructuredText_1103: RscStructuredText
		{
			idc = 1103;

			text = "";
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0.159844 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
		class RscStructuredText_1104: RscStructuredText
		{
			idc = 1104;

			text = "";
			x = 0.876406 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 0.123759 * safezoneW;
			h = 1 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	}
	
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Mucomo)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;[] call fastTravel";

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
			y = 0.28 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.209 * safezoneH;
			colorBackground[] = {0,0,0,0.4};
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "closeDialog 0;createDialog 'OT_dialog_place'";

			text = "Place"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
			tooltip = "Place smaller items around houses you own or at friendly bases"; //--- ToDo: Localize;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			action = "closeDialog 0;[] spawn buildMenu";

			text = "Build"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
			tooltip = "Build structures in towns and at bases"; //--- ToDo: Localize;
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			action = "[] spawn manageRecruits;";

			text = "Manage Recruits"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.731 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			action = "closeDialog 0;[] spawn talkToCiv";

			text = "Talk"; //--- ToDo: Localize;
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicture_1201: RscPicture
		{
			idc = 1201;

			text = "#(argb,8,8,3)color(0,0,0,0)";
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class RscButton_1608: RscButton
		{
			idc = 1608;
			action = "closeDialog 0;[] call buyBuilding";

			text = "Buy"; //--- ToDo: Localize;
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Purchase this building"; //--- ToDo: Localize;
		};
		class RscButton_1609: RscButton
		{
			idc = 1609;
			action = "closeDialog 0;[] call leaseBuilding";

			text = "Lease"; //--- ToDo: Localize;
			x = 0.881562 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Lease this building"; //--- ToDo: Localize;
		};
		class RscButton_1610: RscButton
		{
			idc = 1610;
			action = "closeDialog 0;[] spawn setHome";

			text = "Set Home"; //--- ToDo: Localize;
			x = 0.943438 * safezoneW + safezoneX;
			y = 0.841 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Make this your home (respawn point)"; //--- ToDo: Localize;
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;

			x = 0.881562 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
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
		class RscButton_1611: RscButton
		{
			idc = 1611;
			action = "[] spawn characterSheet;";

			text = "Character Sheet"; //--- ToDo: Localize;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscPicture_1200: RscPicture
		{
			idc = 1200;
			text = "\ot\ui\logo_overthrow.paa";
			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.149531 * safezoneW;
		};
		class RscStructuredText_1105: RscStructuredText
		{
			idc = 1105;

			x = 0.00499997 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.154 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		class RscStructuredText_1106: RscStructuredText
		{
			idc = 1106;

			x = safezoneX + (0.8 * safezoneW);
			y = safezoneY + (0.15 * safezoneH);
			w = 0.19 * safezoneW;
			h = 0.1 * safezoneH;
			colorBackground[] = {0,0,0,0};
			colorActive[] = {0,0,0,0};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
};
class OT_dialog_char
{
	idd=8003;
	movingenable=false;	

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Pejity)
		////////////////////////////////////////////////////////

		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;
			text = ""; //--- ToDo: Localize;
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.143 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
			colorActive[] = {0,0,0,0.5};
		};
		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Increase Level (-10 Influence)"; //--- ToDo: Localize;
			x = 0.273125 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.044 * safezoneH;
			action="[] call buyFitness;"
		};
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;
			text = "<t size=""2"">TBC</t><br/><t size=""1.1"">Level 1</t><br/>More perks coming soon"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.143 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
			colorActive[] = {0,0,0,0.3};
		};
		class RscStructuredText_1102: RscStructuredText
		{
			idc = 1102;
			text = "<t size=""2"">TBC</t><br/><t size=""1.1"">Level 1</t><br/>More perks coming soon"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.143 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
			colorActive[] = {0,0,0,0.3};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	}
}	


class OT_dialog_tute
{
	idd=-1;
	movingenable=false;	
	
	class controlsBackground {
		class RscStructuredText_1101: RscStructuredText
		{
			idc = 1101;			
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.355781 * safezoneW;
			h = 0.198 * safezoneH;
			colorBackground[] = {0.1,0.1,0.1,1};
			colorActive[] = {0.1,0.1,0.1,1};
		};
	}

	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Kizeru)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			action = "closeDialog 0;[] execVM ""tutorial.sqf""";

			text = "Yes"; //--- ToDo: Localize;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			action = "closeDialog 0;";

			text = "No"; //--- ToDo: Localize;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;

			text = "Would you like a quick tutorial?"; //--- ToDo: Localize;
			x = 0.340156 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.324844 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	}
}

class OT_dialog_choose
{
	idd=8002;
	movingenable=false;	
	
	class controls
	{
				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by ARMAzac, v1.063, #Humesu)
		////////////////////////////////////////////////////////

		class RscButton_1600: RscButton
		{
			idc = 1600;
			text = "Lorem Ipsum dolor sit amet blah blah blah"; //--- ToDo: Localize;
			action = "closeDialog 0;0 call OT_choiceMade;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.017 * safezoneH;
		};
		class RscButton_1601: RscButton
		{
			idc = 1601;
			text = "Lorem Ipsum dolor sit amet blah blah blah"; //--- ToDo: Localize;
			action = "closeDialog 0;1 call OT_choiceMade;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.017 * safezoneH;
		};
		class RscButton_1602: RscButton
		{
			idc = 1602;
			text = "Lorem Ipsum dolor sit amet blah blah blah"; //--- ToDo: Localize;
			action = "closeDialog 0;2 call OT_choiceMade;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.017 * safezoneH;
		};
		class RscButton_1603: RscButton
		{
			idc = 1603;
			text = "Lorem Ipsum dolor sit amet blah blah blah"; //--- ToDo: Localize;
			action = "closeDialog 0;3 call OT_choiceMade;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.017 * safezoneH;
		};
		class RscButton_1604: RscButton
		{
			idc = 1604;
			text = "Lorem Ipsum dolor sit amet blah blah blah"; //--- ToDo: Localize;
			action = "closeDialog 0;4 call OT_choiceMade;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.017 * safezoneH;
		};
		class RscButton_1605: RscButton
		{
			idc = 1605;
			text = "Lorem Ipsum dolor sit amet blah blah blah"; //--- ToDo: Localize;
			action = "closeDialog 0;5 call OT_choiceMade;";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.402187 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 0.017 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	}
}