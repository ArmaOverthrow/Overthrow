class CfgFunctions
{
	class OT
	{
		class Base
		{
			file = "\ot\functions";
			class assignMission {};
			class canPlace {};
			class cleanup {};
			class hasOwner {};
			class spawnTemplate {};
			class spawnTemplateAttached {};
			class unitStock {};
			class saveGame {};
			class loadGame {};
			class setOwner {};
			class getOwner {};
		};

		class Events
		{
			file = "\ot\functions\events";
			class preInit {preInit = 1};
			class postInit {postInit = 1};
		};

		class UI
		{
			file = "\ot\functions\UI";
			class notifyMinor {};
			class notifyBig {};
			class notifyGood {};
			class notifyVehicle {};
		};

		/*
		* User actions
		*/
		class Actions
		{
			file = "\ot\functions\actions";

			/* Main Menu */
			class salvageWreck {};
			class buyBuilding {};
			class fastTravel {};
			class talkToCiv {};
			class recruitCiv {};

			/* Vehicle */
			class transferTo {};
			class transferFrom {};
			class transferLegit {};
			class takeLegit {};
			class warehouseTake {};

			/* Workshop */
			class workshopAdd {};

			/* Shop */
			class buy {};
			class sell {};
			class sellAll {};

			/* Gun Dealer */
			class getLocalMission {};
			class getMission {};

			/* Factory */
			class factoryRefresh {};
			class factorySet {};

			/* Resistance Screen */
			class showMemberInfo {};
			class showBusinessInfo {};
			class makeGeneral {};
			class giveFunds {};
			class takeFunds {};
			class transferFunds {};
		}

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
			class nearestLocation {};
			class nearestMobster {};
			class nearestObjective {};
			class nearestPositionRegion {};
			class nearestTown {};
			class townsInRegion {};
			class getAO {};
		}

		/*
		* The spawner
		*/
		class Virtualization
		{
			file = "\ot\functions\virtualization";
			class initVirtualization {};
			class runVirtualization {};

			class spawn {};
			class despawn {};
			class inSpawnDistance {};
			class registerSpawner {};
			class deregisterSpawner {};
			class updateSpawnerPosition {};
		};

		/*
		* The economy, trade and real estate
		*/
		class Economy
		{
			file = "\ot\functions\economy";
			class setupTownEconomy {};
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
			class NATOsearch {};
		};

		/*
		* AI orders
		*/
		class Orders
		{
			file = "\ot\functions\AI\orders";
			class orderLoot {};
			class orderOpenInventory {};
			class orderRevivePlayer {};
		};

		/*
		* NPCs
		*/
		class NPC
		{
			file = "\ot\functions\AI\NPC";
			class initCarDealer {};
			class initCivilian {};
			class initCivilianGroup {};
			class initCriminal {};
			class initCrimLeader {};
			class initGendarm {};
			class initGendarmPatrol {};
			class initGunDealer {};
			class initHarbor {};
			class initMilitary {};
			class initMilitaryPatrol {};
			class initMobBoss {};
			class initMobster {};
			class initNATOCheckpoint {};
			class initPolice {};
			class initPolicePatrol {};
			class initPriest {};
			class initShopkeeper {};
			class initSniper {};
		}

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

		/*
		* NATO
		*/
		class NATO
		{
			file = "\ot\functions\factions\NATO";
			class initNATO {};

			class NATOQRF {};
			class NATOGroundForces {};
			class CTRGSupport {};
			class NATOAirSupport {};
			class NATOGroundSupport {};
			class NATOSeaSupport {};

			class NATOResponseObjective {};
			class NATOResponseTown {};
			class NATOCounterTown {};
			class NATOCounterObjective {};

			class NATOSupportSniper {};
			class NATOSupportRecon {};
		};

		/*
		* Mod integration
		*/
		class Integration
		{
			file = "\ot\functions\integration";
			class initTFAR {};
		};
	};
};
