class CfgWeapons {
	class ItemCore;
	class OT_ItemCore: ItemCore {
        type = 4096;//4;
        detectRange = -1;
        simulation = "ItemMineDetector";
    };
	class InventoryItem_Base_F;
    class OT_Ganja: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\ganja_x_ca.paa";
        displayName = "Ganja";
        descriptionShort = "1/2 oz. of the finest bud around.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 2;
        };
    };
	class OT_Blow: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\blow_x_ca.paa";
        displayName = "Blow";
        descriptionShort = "A white powder that turns madmen into world leaders, or world leaders into madmen.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 2;
        };
    };
	class OT_Wood: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\wood_x_ca.paa";
        displayName = "Wood";
        descriptionShort = "A porous and fibrous structural tissue found in the stems and roots of trees and other woody plants.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 250;
        };
    };
	class OT_Lumber: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\wood_x_ca.paa";
        displayName = "Lumber";
        descriptionShort = "Lumber or timber is a type of wood that has been processed into beams and planks, a stage in the process of wood production.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 200;
        };
    };
	class OT_Steel: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\steel_x_ca.paa";
        displayName = "Steel";
        descriptionShort = "An alloy of iron and other elements, primarily carbon, that is widely used in construction and other applications because of its high tensile strength and low cost.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 400;
        };
    };
	class OT_Plastic: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\plastic_x_ca.paa";
        displayName = "Plastic";
        descriptionShort = "A material consisting of any of a wide range of synthetic or semi-synthetic organic compounds that are malleable and can be molded into solid objects.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 150;
        };
    };
	class OT_Sugarcane: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\cane_x_ca.paa";
        displayName = "Sugarcane";
        descriptionShort = "A perennial grass of the genus Saccharum used to produce Sugar.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 50;
        };
    };
	class OT_Sugar: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\sugar_x_ca.paa";
        displayName = "Sugar";
        descriptionShort = "The generalized name for sweet, short-chain, soluble carbohydrates, many of which are used in food.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 30;
        };
    };
	class OT_Grapes: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\cane_x_ca.paa";
        displayName = "Grapes";
        descriptionShort = "A fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis. Can be turned into Wine.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 50;
        };
    };
	class OT_Wine: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\cane_x_ca.paa";
        displayName = "Wine";
        descriptionShort = "An alcoholic beverage made from grapes, generally Vitis vinifera, fermented without the addition of sugars, acids, enzymes, water, or other nutrients.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 50;
        };
    };
	class OT_Olives: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\cane_x_ca.paa";
        displayName = "Olives";
        descriptionShort = "A species of small tree in the family Oleaceae, found in the Mediterranean Basin from Portugal to the Levant, the Arabian Peninsula, and southern Asia as far east as China, as well as the Canary Islands, Mauritius, and Altis.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 50;
        };
    };
	class OT_Fertilizer: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\fertilizer_x_ca.paa";
        displayName = "Fertilizer";
        descriptionShort = "A material of natural or synthetic origin that is applied to soils or to plant tissues (usually leaves) to supply one or more plant nutrients essential to the growth of plants.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 80;
        };
    };
	class OT_ammo50cal: OT_ItemCore {
        scope = 2;
        picture = "\overthrow_main\ui\items\ammo50cal_x_ca.paa";
        displayName = "100 x 50 Cal BMG";
        descriptionShort = "100 Rounds of .50 Calibre 660 grain FMJ xM33 ammunition for use in Static weapons";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 25;
        };
    };


	//Craftable items
	class ACE_ItemCore;
	class ACE_fieldDressing : ACE_ItemCore {
		ot_craftable = 1;
		ot_craftQuantity = 5;
		ot_craftRecipe = "[[""Uniform_Base"",1]]";
	};

	class ACE_CableTie : ACE_ItemCore {
		ot_craftable = 1;
		ot_craftQuantity = 10;
		ot_craftRecipe = "[[""OT_Plastic"",1]]";
	};

	class ACE_Clacker : ACE_ItemCore {
		ot_craftable = 1;
		ot_craftQuantity = 5;
		ot_craftRecipe = "[[""OT_Steel"",1]]";
	};

	class ACE_DeadManSwitch : ACE_ItemCore {
		ot_craftable = 1;
		ot_craftQuantity = 7;
		ot_craftRecipe = "[[""OT_Steel"",1]]";
	};

	class ACE_EarPlugs : ACE_ItemCore {
		ot_craftable = 1;
		ot_craftQuantity = 2;
		ot_craftRecipe = "[[""OT_Plastic"",1]]";
	};
};
