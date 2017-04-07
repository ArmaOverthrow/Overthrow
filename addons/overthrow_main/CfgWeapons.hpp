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
        picture = "\ot\ui\items\ganja_x_ca.paa";
        displayName = "Ganja";
        descriptionShort = "1/2 oz. of the finest bud around.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 2;
        };
    };
	class OT_Blow: OT_ItemCore {
        scope = 2;
        picture = "\ot\ui\items\blow_x_ca.paa";
        displayName = "Blow";
        descriptionShort = "A white powder that turns madmen into world leaders, or world leaders into madmen.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 2;
        };
    };
	class OT_Wood: OT_ItemCore {
        scope = 2;
        picture = "\ot\ui\items\wood_x_ca.paa";
        displayName = "Wood";
        descriptionShort = "A porous and fibrous structural tissue found in the stems and roots of trees and other woody plants.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 250;
        };
    };
	class OT_Steel: OT_ItemCore {
        scope = 2;
        picture = "\ot\ui\items\steel_x_ca.paa";
        displayName = "Steel";
        descriptionShort = "An alloy of iron and other elements, primarily carbon, that is widely used in construction and other applications because of its high tensile strength and low cost.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 400;
        };
    };
	class OT_Plastic: OT_ItemCore {
        scope = 2;
        picture = "\ot\ui\items\plastic_x_ca.paa";
        displayName = "Plastic";
        descriptionShort = "A material consisting of any of a wide range of synthetic or semi-synthetic organic compounds that are malleable and can be molded into solid objects.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 150;
        };
    };
	class OT_Sugarcane: OT_ItemCore {
        scope = 2;
        picture = "\ot\ui\items\cane_x_ca.paa";
        displayName = "Sugarcane";
        descriptionShort = "A perennial grass of the genus Saccharum used to produce Sugar.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 50;
        };
    };
	class OT_Sugar: OT_ItemCore {
        scope = 2;
        picture = "\ot\ui\items\sugar_x_ca.paa";
        displayName = "Sugar";
        descriptionShort = "The generalized name for sweet, short-chain, soluble carbohydrates, many of which are used in food.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 30;
        };
    };
};
