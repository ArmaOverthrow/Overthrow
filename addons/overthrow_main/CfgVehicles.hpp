class CfgVehicles {
	class Item_Base_F;
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
};