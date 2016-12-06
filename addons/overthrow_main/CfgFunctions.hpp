class CfgFunctions
{
	class OT
	{
		class Base
		{
			file = "\ot\functions";
			class preInit {preInit = 1};
			class assignMission {};
			class canPlace {};
			class cleanup {};
			class hasOwner {};
			class spawnTemplate {};
			class spawnTemplateAttached {};
			class unitStock {};
		};

		/*
		* Locations, positions etc.
		*/
		class Geography
		{
			file = "\ot\functions\geography";
			class getRandomBuilding {};
			class nearestBase {};
			class nearestCheckpoint {};
			class nearestComms {};
			class nearestMobster {};
			class nearestObjective {};
			class nearestPositionRegion {};
			class nearestTown {};
			class townsInRegion {};
		}

		/*
		* The spawner
		*/
		class Virtualization
		{
			file = "\ot\functions\virtualization";
			class inSpawnDistance {};
		};

		/*
		* The economy, trade and real estate
		*/
		class Economy
		{
			file = "\ot\functions\economy";
			class getPrice {};
			class getSellPrice {};
			class getDrugPrice {};
			class nearestRealEstate {};
			class getRealEstateData {};
		}

		/*
		* The warehouse
		*/
		class Warehouse
		{
			file = "\ot\functions\warehouse";
			class removeFromWarehouse {};
			class findHelmetInWarehouse {};
			class findScopeInWarehouse {};
			class findWeaponInWarehouse {};
			class findVestInWarehouse {};
		};

		/*
		* AI and recruits
		*/
		class AI
		{
			file = "\ot\functions\AI";
			class createSoldier {};
			class getSoldier {};
			class parachuteAll {};
		};

		/*
		* Math.. how does it work?
		*/
		class Math
		{
			file = "\ot\functions\math";
			class rotationMatrix {};
			class matrixMultiply {};
			class matrixRotate {};
		};
	};
};
