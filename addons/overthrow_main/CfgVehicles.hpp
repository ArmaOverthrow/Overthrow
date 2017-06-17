class CfgVehicles {
	class Item_Base_F;
	class Land_MapBoard_F;
	class Mapboard_tanoa_F: Land_MapBoard_F {
		displayName = "Map (Tanoa)";
		hiddenSelectionsTextures[] = {"\ot\ui\maptanoa.paa"};
	};
    class OT_GanjaItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Ganja";
        author = "ARMAzac";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(OT_GanjaItem,1);
        };
    };
	class OT_BlowItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "Blow";
        author = "ARMAzac";
        vehicleClass = "Items";
        class TransportItems {
            MACRO_ADDITEM(OT_BlowItem,1);
        };
    };

	//Houses (Tanoa)
	class House_Small_F;
    class House_F;
    class Land_Slum_01_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Land_MetalCase_01_small_F",[-0.897521,0.746889,0.594079],178.839,1,0,[0,-0],"","",true,false],["OfficeTable_01_new_F",[3.00668,1.91341,0.59408],0,1,0,[0,0],"","",true,false],["Mapboard_tanoa_F",[4.62316,-1.50578,0.594079],119.84,1,0,[0,-0],"","",true,false],["B_CargoNet_01_ammo_F",[4.72776,1.54301,0.59408],0,1,0,[0,0],"","",true,false]]';
    };
    class Land_Slum_02_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[-2.26472,2.64946,0.559122],314.105,1,0,[0,0],"","",true,false],["B_CargoNet_01_ammo_F",[1.83102,-3.80072,0.559122],0,1,0,[0,0],"","",true,false],["Land_MetalCase_01_small_F",[1.25476,4.2525,0.559122],287.951,1,0,[0,0],"","",true,false],["OfficeTable_01_new_F",[-0.0970871,4.45407,0.559122],0,1,0,[0,0],"","",true,false]]';
    };
	class Land_House_Native_01_F: House_Small_F {
		ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[1.77709,1.85536,0.148079],38.8726,1,0,[],"","",true,false],["Land_MetalCase_01_small_F",[1.96175,-1.98313,0.121121],37.1995,1,0,[],"","",true,false],["OfficeTable_01_new_F",[-2.31248,2.38399,0.103003],0,1,0,[],"","",true,false],["B_CargoNet_01_ammo_F",[-3.07393,-1.85328,0.157859],0,1,0,[],"","",true,false]]';
	};
    class Land_House_Native_02_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[1.77709,1.85536,0.148079],38.8726,1,0,[],"","",true,false],["Land_MetalCase_01_small_F",[1.96175,-1.98313,0.121121],37.1995,1,0,[],"","",true,false],["OfficeTable_01_new_F",[-2.31248,2.38399,0.103003],0,1,0,[],"","",true,false],["B_CargoNet_01_ammo_F",[-3.07393,-1.85328,0.157859],0,1,0,[],"","",true,false]]';
    };

	//Houses (Altis)
	class Land_i_House_Small_02_V1_F: House_Small_F {
		ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[1.77709,1.85536,0.148079],38.8726,1,0,[],"","",true,false],["Land_MetalCase_01_small_F",[1.96175,-1.98313,0.121121],37.1995,1,0,[],"","",true,false],["OfficeTable_01_new_F",[-2.31248,2.38399,0.103003],0,1,0,[],"","",true,false],["B_CargoNet_01_ammo_F",[-3.07393,-1.85328,0.157859],0,1,0,[],"","",true,false]]';
	};
	class Land_i_House_Small_02_V2_F: Land_i_House_Small_02_V1_F {
		ot_isPlayerHouse = 1;
	};
	class Land_i_House_Small_02_V3_F: Land_i_House_Small_02_V1_F {
        ot_isPlayerHouse = 1;
    };
	class Land_i_Stone_Shed_V1_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[1.77709,1.85536,0.148079],38.8726,1,0,[],"","",true,false],["Land_MetalCase_01_small_F",[1.96175,-1.98313,0.121121],37.1995,1,0,[],"","",true,false],["OfficeTable_01_new_F",[-2.31248,2.38399,0.103003],0,1,0,[],"","",true,false],["B_CargoNet_01_ammo_F",[-3.07393,-1.85328,0.157859],0,1,0,[],"","",true,false]]';
    };
	class Land_i_Stone_Shed_V2_F: Land_i_Stone_Shed_V1_F {
        ot_isPlayerHouse = 1;
    };
	class Land_Slum_House02_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[1.77709,1.85536,0.148079],38.8726,1,0,[],"","",true,false],["Land_MetalCase_01_small_F",[1.96175,-1.98313,0.121121],37.1995,1,0,[],"","",true,false],["OfficeTable_01_new_F",[-2.31248,2.38399,0.103003],0,1,0,[],"","",true,false],["B_CargoNet_01_ammo_F",[-3.07393,-1.85328,0.157859],0,1,0,[],"","",true,false]]';
    };
	class Land_Slum_House03_F: House_Small_F {
        ot_isPlayerHouse = 1;
        ot_template = '[["Mapboard_tanoa_F",[1.77709,1.85536,0.148079],38.8726,1,0,[],"","",true,false],["Land_MetalCase_01_small_F",[1.96175,-1.98313,0.121121],37.1995,1,0,[],"","",true,false],["OfficeTable_01_new_F",[-2.31248,2.38399,0.103003],0,1,0,[],"","",true,false],["B_CargoNet_01_ammo_F",[-3.07393,-1.85328,0.157859],0,1,0,[],"","",true,false]]';
    };

	//Houses (CUP)
	class Land_House_C_5_dam_EP1: House_Small_F {
		ot_isPlayerHouse = 1;
        ot_template = '[["Land_MetalCase_01_small_F",[-0.507421,-0.278264,0.377357],0,1,0,[],"","",true,false], ["B_CargoNet_01_ammo_F",[-1.09897,-1.48947,0.377357],0,1,0,[],"","",true,false], ["Land_Workbench_01_F",[-4.09043,2.20817,0.324941],270,1,0,[],"","",true,false], ["Land_MapBoard_F",[-4.07916,-4.87537,0.325],210,1,0,[],"","",true,false] ]';
	};
	class Land_House_C_5_EP1: Land_House_C_5_dam_EP1 {
		ot_isPlayerHouse = 1;
	};
	class Land_House_C_5_V1_dam_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_5_V1_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_5_V2_dam_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_5_V2_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_5_V3_dam_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_5_V3_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_11_dam_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
    };
	class Land_House_C_11_EP1: Land_House_C_5_dam_EP1 {
        ot_isPlayerHouse = 1;
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
    class Land_i_Shop_02_V2_F: Land_i_Shop_02_V1_F {
        ot_isShop = 1;
        ot_template = '[]';
    };
    class Land_i_Shop_02_V3_F: Land_i_Shop_02_V1_F {
        ot_isShop = 1;
        ot_template = '[]';
    };

	//Shops (CUP)
	class Land_A_GeneralStore_01: House_F {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-6.93629,2.99194,0],180.686,1,0,[],"","",true,false]]';
    };
    class Land_A_GeneralStore_01_dam: Land_A_GeneralStore_01 {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-6.95791,2.98163,0],180.686,1,0,[],"","",true,false]]';
    };
    class Land_A_GeneralStore_01a: Land_A_GeneralStore_01 {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-5.77295,6.66858,0],180.686,1,0,[],"","",true,false]]';
    };
	class Land_A_GeneralStore_01a_dam: Land_A_GeneralStore_01 {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-5.35,6.89225,0],180.686,1,0,[],"","",true,false]]';
    };
    class Land_GeneralStore_01a_dam_PMC: Land_A_GeneralStore_01 {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-5.36103,6.85785,0],180.686,1,0,[],"","",true,false]]';
    };
    class Land_GeneralStore_01a_PMC: Land_A_GeneralStore_01 {
        ot_isShop = 1;
        ot_template = '[["Land_CashDesk_F",[-5.76134,6.66694,0],180.686,1,0,[],"","",true,false]]';
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
    class CAManBase;
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
