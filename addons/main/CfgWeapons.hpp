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
        picture = "\main\ui\items\ganja_x_ca.paa";
        displayName = "Ganja";
        descriptionShort = "1 oz. of the finest bud around.";
        descriptionUse = "";
        class ItemInfo: InventoryItem_Base_F {
            mass = 0.5;
        };
    };
};