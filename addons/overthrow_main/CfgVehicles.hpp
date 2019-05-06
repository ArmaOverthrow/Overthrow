#define MACRO_SALVAGEWRECK \
	class ACE_Actions { \
		class ACE_MainActions { \
			class OT_Remove { \
				condition = "!([player] call ace_repair_fnc_isInRepairFacility) && (_target call OT_fnc_hasOwner) && ((call OT_fnc_playerIsGeneral) || (_target call OT_fnc_playerIsOwner))"; \
				displayName = "Remove"; \
				statement = ""; \
					class OT_Remove_Confirm { \
						condition = "true"; \
						displayName = "Confirm"; \
						statement = "deleteVehicle _target"; \
					}; \
			}; \
			class OT_Salvage { \
				condition = "((damage _target) > 0.99 && ""ToolKit"" in (items player)) || [player] call ace_repair_fnc_isInRepairFacility"; \
				displayName = "Salvage"; \
				statement = "_target spawn OT_fnc_salvageWreck"; \
			}; \
		}; \
	};


class CfgVehicles {
	class Item_Base_F;
	class ThingX;

	//Overthrow Vehicles
	class I_Truck_02_box_F;
	class OT_I_Truck_recovery : I_Truck_02_box_F {
		displayName = "KamAZ Recovery";
		class Library {
			libTextDesc = "The Field Assistance and Recovery Truck (FART) is a specialized heavy truck used for field repairs and gear recovery after a battle. It can recover all items and bodies within a 150m radius into it's cargohold.";
		};
	};

	//ACE actions
	class Land_MapBoard_F : ThingX {
		class ACE_Actions {
			class ACE_MainActions {
				displayName = "Interactions";
				distance = 6;

				class mapinfo {
					displayName = "Map Info";
	                statement = "[] spawn OT_fnc_mapInfoDialog;";
				};
	      class resetui {
					displayName = "Reset UI";
	        statement = "[] spawn OT_fnc_setupPlayer;";
				};
	      class sleepAction {
					displayName = "Sleep";
	        statement = "createDialog ""OT_sleep_dialog"";";
				};
			};
		};
	};
	class Mapboard_tanoa_F: Land_MapBoard_F {
		displayName = "Map (Tanoa)";
		hiddenSelectionsTextures[] = {"\overthrow_main\ui\maptanoa.paa"};
	};
    class OT_GanjaItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Ganja";
        author = "ARMAzac";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(OT_GanjaItem,1)
        };
    };
	class OT_BlowItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Blow";
        author = "ARMAzac";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(OT_BlowItem,1)
        };
    };

	//ACE Interactions
    class Man;
    class CAManBase: Man {
        fsmDanger = "overthrow_main\fsm\danger.fsm";
        class ACE_Actions {
            class ACE_MainActions {
                class OT_InteractionActions {
                    condition = "(alive _target) && (!isplayer _target) && !(side _target isEqualTo west) && (!(_player getVariable ['ot_tute',true]) || !(_player getVariable ['OT_tute_inProgress', false]))";
                    selection = "pelvis";
                    distance = 4;
                    displayName = "Talk";
                    statement = "_target call OT_fnc_talkToCiv";
                };
            };
		};
        class ACE_SelfActions {
            class ACE_Equipment {
                class OT_StartSpliff
                {
                    displayName = "Smoke a spliff";
                    condition = "('OT_Ganja' in (items player)) && (!(_player getVariable ['ot_isSmoking', false]))";
                    statement = "[_player] spawn ot_fnc_startSpliff";
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = "\overthrow_main\ui\icons\light_cig.paa";
                };
                class OT_StopSpliff
                {
                    displayName = "Ditch your spliff!";
                    condition = "(goggles _player) in OT_cigsArray && ((_player getVariable ['ot_isSmoking', false]))";
                    statement = "[_player] spawn ot_fnc_stopSpliff";
                    showDisabled = 0;
                    exceptions[] = {"isNotInside", "isNotSitting"};
                    icon = "\overthrow_main\ui\icons\light_cig.paa";
                };
            };
        };
	};

	class Furniture_base_F;
	class Land_Workbench_01_F : Furniture_base_F {
		class ACE_Actions {
			class ACE_MainActions {
				displayName = "Interactions";
				distance = 4;
				class OT_Craft {
					condition = "true";
					displayName = "Craft";
					statement = "call OT_fnc_craftDialog";
				};
			};
		};
	};

	class LandVehicle;
	class Car : LandVehicle {
		MACRO_SALVAGEWRECK
	};
	class Tank : LandVehicle {
		MACRO_SALVAGEWRECK
	};
	class Motorcycle : LandVehicle {
		MACRO_SALVAGEWRECK
	};

	class Air;
	class Helicopter : Air {
		MACRO_SALVAGEWRECK
	};
	class Plane : Air {
		MACRO_SALVAGEWRECK
	};

	class Ship;
	class Ship_F : Ship {
		MACRO_SALVAGEWRECK
	};

	//Houses (Tanoa)
	class House_Small_F;
    class House_F;
    class Land_Slum_01_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Land_MetalCase_01_small_F", [-0.746442,-0.078261,0.594079],0.418328,1,0,[0,0],"","",true,false],["Land_CampingChair_V2_F",[1.22725,1.2502,0.594079],199.447,1,0,[0,0],"","",true,false],["Mapboard_tanoa_F",[-0.340959,1.65805,0.59408],327.71,1,0,[0,0],"","",true,false],["OfficeTable_01_new_F",[1.54124,1.92773,0.59408],0,1,0,[0,0],"","",true,false],["Land_Workbench_01_F",[2.70912,-1.90632,0.594079],180,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[4.56925,1.31465,0.59408],0,1,0,[0,0],"","",true,false]]';
    };
    class Land_Slum_02_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Land_MetalCase_01_small_F", [-2.58489,-0.659296,0.559122],0.418328,1,0,[0,0],"","",true,false],["Land_Workbench_01_F",[2.247,2.4636,0.559122],90,1,0,[0,-0],"","",true,false],["Land_CampingChair_V2_F",[-1.65537,3.79657,0.559121],199.447,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[-1.74631,-3.67237,0.559122],0,1,0,[0,0],"","",true,false],["Mapboard_tanoa_F",[1.75104,-3.70061,0.559122],155.874,1,0,[0,-0],"","",true,false],["OfficeTable_01_new_F",[-1.34138,4.4741,0.559122],0,1,0,[0,0],"","",true,false]]';
    };
	class Land_House_Native_01_F: House_Small_F {
		ot_isPlayerHouse = 1;
        ot_template = '[["Land_CampingChair_V2_F", [2.26438,-2.22928,0.2],17.5159,1,0,[0,0],"","",true,false],["OfficeTable_01_new_F",[1.97339,-2.917,0.2],178.069,1,0,[0,-0],"","",true,false],["Land_Workbench_01_F",[-2.34453,2.75383,0.200001],0,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[-3.88622,-2.36955,0.200001],0,1,0,[0,0],"","",true,false],["Mapboard_tanoa_F",[4.03968,2.56928,0.200001],32.4555,1,0,[0,0],"","",true,false],["Land_MetalCase_01_small_F",[4.28656,-2.64937,0.2],212.206,1,0,[0,0],"","",true,false]]';
	};
    class Land_House_Native_02_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Land_CampingChair_V2_F", [0.0907892,-1.587,0.103002],17.5159,1,0,[0,0],"","",true,false],["OfficeTable_01_new_F",[-0.200199,-2.27472,0.103003],178.069,1,0,[0,-0],"","",true,false],["Mapboard_tanoa_F",[1.78568,2.06457,0.103003],32.4555,1,0,[0,0],"","",true,false],["Land_MetalCase_01_small_F",[2.12703,-2.08529,0.103003],212.206,1,0,[0,0],"","",true,false],["Land_Workbench_01_F",[-2.40922,2.34683,0.103003],0,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[-3.11908,-1.7698,0.103003],0,1,0,[0,0],"","",true,false]]';
    };
	//Houses (Altis)
	class Land_i_House_Small_02_V1_F: House_Small_F {
		ot_isPlayerHouse = 1;
        ot_template = '[["Land_MetalCase_01_small_F", [1.76559,-2.99125,0.417622],284.311,1,0,[-0.071722,-0.0182958],"","",true,false],["Land_Workbench_01_F",[3.2372,2.27116,0.422988],0,1,0,[0.195835,0],"","",true,false],["Land_CampingChair_V2_F",[4.94837,-2.23044,0.421724],19.8195,1,0,[0.0250966,-0.0696343],"","",true,false],["OfficeTable_01_new_F",[4.62998,-2.90591,0.421724],180.373,1,0,[-0.000481725,0.0740172],"","",true,false],["B_CargoNet_01_ammo_F",[6.60879,-0.956271,0.423864],0,1,0,[0,-0.0740187],"","",true,false],["MapBoard_altis_F",[6.69212,1.92874,0.423972],57.5222,1,0,[0.0624422,-0.039746],"","",true,false]]';
	};
	class Land_i_Stone_Shed_V1_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["OfficeTable_01_new_F", [0.161512,-0.0919862,0.26],180.373,1,0,[0,0],"","",true,false],["Land_CampingChair_V2_F",[0.479908,0.583482,0.26],19.8195,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[-3.03811,0.542177,0.26],0,1,0,[0,0],"","",true,false],["Land_MetalCase_01_small_F",[0.197573,4.06797,0.26],92.8353,1,0,[0,-0],"","",true,false],["Land_Workbench_01_F",[-2.11435,3.83624,0.26],0,1,0,[0,0],"","",true,false],["MapBoard_altis_F",[2.26796,3.73339,0.26],57.5223,1,0,[0,0],"","",true,false]]';
    };
	class Land_Slum_House02_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Land_Workbench_01_F", [-1.36485,0.870917,0],90,1,0,[0,-0],"","",true,false],["Land_MetalCase_01_small_F",[1.28859,-1.0394,0.23],92.8353,1,0,[0,-0],"","",true,false],["OfficeTable_01_new_F",[2.5086,-1.0345,0.23],180.373,1,0,[0,0],"","",true,false],["Land_CampingChair_V2_F",[2.71048,-0.444679,0.23],7.55273,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[1.61679,-2.76766,0],0,1,0,[0,0],"","",true,false],["MapBoard_altis_F",[2.48146,2.91809,0.23],41.3345,1,0,[0,0],"","",true,false]]';
    };

	//Houses (Malden)
	class i_House_Small_02_b_base_F : House_Small_f {
		ot_isPlayerHouse = 1;
        ot_template = '[["Land_Workbench_01_F", [-1.36485,0.870917,0],90,1,0,[0,-0],"","",true,false],["Land_MetalCase_01_small_F",[1.28859,-1.0394,0.23],92.8353,1,0,[0,-0],"","",true,false],["OfficeTable_01_new_F",[2.5086,-1.0345,0.23],180.373,1,0,[0,0],"","",true,false],["Land_CampingChair_V2_F",[2.71048,-0.444679,0.23],7.55273,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[1.61679,-2.76766,0],0,1,0,[0,0],"","",true,false],["MapBoard_altis_F",[2.48146,2.91809,0.23],41.3345,1,0,[0,0],"","",true,false]]';
	};

	//Houses (CUP)
	class Land_House_C_5_EP1: House_Small_F {
		ot_isPlayerHouse = 1;
        ot_template = '[["Land_MetalCase_01_small_F",[-0.507421,-0.278264,0.377357],0,1,0,[],"","",true,false], ["B_CargoNet_01_ammo_F",[-1.09897,-1.48947,0.377357],0,1,0,[],"","",true,false], ["Land_Workbench_01_F",[-4.09043,2.20817,0.324941],270,1,0,[],"","",true,false], ["Land_MapBoard_F",[-4.07916,-4.87537,0.325],210,1,0,[],"","",true,false] ]';
	};

    //Shops (Tanoa)
    class Land_FuelStation_01_shop_F: House_F {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-0.746313,-1.1316,0.277551],0,1,0,[],"","",true,false]]';
    };
    class Land_Shop_City_02_F: House_F {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[7.16479,-4.60961,0.0704632],0,1,0,[],"","",true,false]]';
    };
    class Land_Shop_Town_01_F: House_F {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[1.26089,-3.41939,0.131084],90,1,0,[],"","",true,false]]';
    };
    class Land_Shop_Town_03_F: House_F {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[2.77324,-4.32109,0.141195],0,1,0,[],"","",true,false]]';
    };
    class Land_Supermarket_01_F: House_F {
        ot_isShop = 1;
        ot_template = '[]';
    };

	//Shops (Altis)
	class Land_i_Shop_02_V1_F: House_F {
        ot_isShop = 1;
        ot_template = '[]';
    };
	class Land_u_Shop_02_V1_F: Land_i_Shop_02_V1_F {
        ot_isShop = 0;
    };

	//Shops (Malden)
	class i_Shop_02_b_base_f : House_F {
		ot_isShop = 1;
        ot_template = '[]';
	};
	class Land_i_Shop_02_V3_F: House_F {
        ot_isShop = 1;
        ot_template = '[]';
    };
	class Land_u_Shop_02_V3_F: Land_i_Shop_02_V3_F {
        ot_isShop = 0;
    };

	//Shops (CUP)
	class Land_A_GeneralStore_01: House_F {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-6.93629,2.99194,0],180.686,1,0,[],"","",true,false]]';
    };

    //Car Dealers (Tanoa)
    class Land_FuelStation_01_workshop_F: House_F {
        ot_isCarDealer = 1;
        ot_template = '[["Land_CashDesk_F",[2.87972,-3.57524,0.277551],0,1,0,[],"","",true,false]]';
    };
    class Land_FuelStation_02_workshop_F: House_F {
        ot_isCarDealer = 1;
        ot_template = '[["Land_CashDesk_F",[2.21226,0.566814,0.53],0,1,0,[],"","",true,false]]';
    };

	//Car Dealers (Altis)
	class Land_CarService_F: House_F {
        ot_isCarDealer = 1;
        ot_template = '[]';
    };

	//Unlocks uniforms (ace_nouniformrestrictions)
	class Civilian;
    class B_Soldier_diver_base_F;
    class C_man_1;
    class I_G_Soldier_F;
    class I_G_Soldier_lite_F;
    class I_G_Soldier_SL_F;
    class I_G_Soldier_TL_F;
    class I_G_Soldier_AR_F;
    class I_G_medic_F;
    class I_G_engineer_F;
    class I_G_Soldier_exp_F;
    class I_G_Soldier_GL_F;
    class I_G_Soldier_M_F;
    class I_G_Soldier_LAT_F;
    class I_G_Soldier_A_F;
    class I_G_officer_F;
    class I_Soldier_diver_base_F;
    class O_Soldier_diver_base_F;
    class I_G_Sharpshooter_F;
    class B_Soldier_F;

    class Civilian_F: Civilian {
        modelSides[] = {6};
    };
    class SoldierWB: CAManBase {
        modelSides[] = {6};
    };
    class SoldierEB: CAManBase {
        modelSides[] = {6};
    };
    class SoldierGB: CAManBase {
        modelSides[] = {6};
    };
    class B_Soldier_base_F: SoldierWB {
        modelSides[] = {6};
    };
    class B_Soldier_02_f: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class B_Soldier_03_f: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class B_Soldier_04_f: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class B_Soldier_05_f: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class B_RangeMaster_F: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class B_Helipilot_F: B_Soldier_04_f {
        modelSides[] = {6};
    };
    class B_Pilot_F: B_Soldier_05_f {
        modelSides[] = {6};
    };
    class B_helicrew_F: B_Helipilot_F {
        modelSides[] = {6};
    };
    class B_diver_F: B_Soldier_diver_base_F {
        modelSides[] = {6};
    };
    class B_Story_SF_Captain_F: B_Soldier_02_f {
        modelSides[] = {6};
    };
    class B_Story_Protagonist_F: B_Soldier_02_f {
        modelSides[] = {6};
    };
    class b_soldier_survival_F: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class C_man_1_1_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_man_p_fugitive_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_man_p_beggar_F: C_man_p_fugitive_F {
        modelSides[] = {6};
    };
    class C_man_w_worker_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_scientist_F: C_man_w_worker_F {
        modelSides[] = {6};
    };
    class C_man_hunter_1_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_man_pilot_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_journalist_F: C_man_1 {
        modelSides[] = {6};
    };
    class I_G_Soldier_base_F: SoldierGB {
        modelSides[] = {6};
    };
    class B_G_Soldier_F: I_G_Soldier_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_F: I_G_Soldier_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_lite_F: I_G_Soldier_lite_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_lite_F: I_G_Soldier_lite_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_SL_F: I_G_Soldier_SL_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_SL_F: I_G_Soldier_SL_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_TL_F: I_G_Soldier_TL_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_TL_F: I_G_Soldier_TL_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_AR_F: I_G_Soldier_AR_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_AR_F: I_G_Soldier_AR_F {
        modelSides[] = {6};
    };
    class B_G_medic_F: I_G_medic_F {
        modelSides[] = {6};
    };
    class O_G_medic_F: I_G_medic_F {
        modelSides[] = {6};
    };
    class B_G_engineer_F: I_G_engineer_F {
        modelSides[] = {6};
    };
    class O_G_engineer_F: I_G_engineer_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_exp_F: I_G_Soldier_exp_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_exp_F: I_G_Soldier_exp_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_GL_F: I_G_Soldier_GL_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_GL_F: I_G_Soldier_GL_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_M_F: I_G_Soldier_M_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_M_F: I_G_Soldier_M_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_LAT_F: I_G_Soldier_LAT_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_LAT_F: I_G_Soldier_LAT_F {
        modelSides[] = {6};
    };
    class B_G_Soldier_A_F: I_G_Soldier_A_F {
        modelSides[] = {6};
    };
    class O_G_Soldier_A_F: I_G_Soldier_A_F {
        modelSides[] = {6};
    };
    class B_G_officer_F: I_G_officer_F {
        modelSides[] = {6};
    };
    class O_G_officer_F: I_G_officer_F {
        modelSides[] = {6};
    };
    class I_G_Story_SF_Captain_F: B_G_Soldier_F {
        modelSides[] = {6};
    };
    class I_Soldier_base_F: SoldierGB {
        modelSides[] = {6};
    };
    class I_Soldier_03_F: I_Soldier_base_F {
        modelSides[] = {6};
    };
    class I_Soldier_04_F: I_Soldier_base_F {
        modelSides[] = {6};
    };
    class I_officer_F: I_Soldier_base_F {
        modelSides[] = {6};
    };
    class I_diver_F: I_Soldier_diver_base_F {
        modelSides[] = {6};
    };
    class O_Soldier_base_F: SoldierEB {
        modelSides[] = {6};
    };
    class O_Soldier_02_F: O_Soldier_base_F {
        modelSides[] = {6};
    };
    class O_officer_F: O_Soldier_base_F {
        modelSides[] = {6};
    };
    class O_diver_F: O_Soldier_diver_base_F {
        modelSides[] = {6};
    };
    class C_Driver_1_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_Marshal_F: B_RangeMaster_F {
        modelSides[] = {6};
    };
    class B_Soldier_VR_F: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class O_Soldier_VR_F: O_Soldier_base_F {
        modelSides[] = {6};
    };
    class I_Soldier_VR_F: I_Soldier_base_F {
        modelSides[] = {6};
    };
    class C_Soldier_VR_F: C_man_1 {
        modelSides[] = {6};
    };
    class B_Protagonist_VR_F: B_Soldier_base_F {
        modelSides[] = {6};
    };
    class O_Protagonist_VR_F: O_Soldier_base_F {
        modelSides[] = {6};
    };
    class I_Protagonist_VR_F: I_Soldier_base_F {
        modelSides[] = {6};
    };
    class B_G_Sharpshooter_F: I_G_Sharpshooter_F {
        modelSides[] = {6};
    };
    class O_G_Sharpshooter_F: I_G_Sharpshooter_F {
        modelSides[] = {6};
    };
    class Underwear_F: B_Soldier_F {
        modelSides[] = {6};
    };
    class C_man_sport_1_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_man_sport_2_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_man_sport_3_F: C_man_1 {
        modelSides[] = {6};
    };
    class C_Man_casual_1_F: C_man_1 {
        modelSides[] = {6};
    };
};
