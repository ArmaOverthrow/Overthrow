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
			class setOwner {};
			class getOwner {};
		};

		/* Persistent Save */
		class Save
		{
			file = "\ot\functions\save";
			class saveGame {};
			class loadGame {};
			class setOfflinePlayerAttribute {};
			class getOfflinePlayerAttribute {};
			class loadPlayerData {};
		};

		class Player
		{
			file = "\ot\functions\player";
			class mapSystem {};
			class perkSystem {};
			class setupPlayer {};
			class statsSystem {};
			class wantedSystem {};
			class playerIsOwner {};
			class playerIsGeneral {};
			class playerIsAtWarehouse {};
			class tutorial {};
		};

		class Interaction
		{
			file = "\ot\functions\interaction";
			class mountAttached {};
			class initAttached {};
			class updateAttached {};
		};

		class Events
		{
			file = "\ot\functions\events";
			class preInit {preInit = 1};
			class postInit {postInit = 1};
			class deathHandler {};
			class buildingDamagedHandler {};
			class cargoLoadedHandler {};
			class explosivesPlacedHandler {};
			class cargoLoadedHandler {};
			class playerConnectHandler {};
			class playerDisconnectHandler {};
			class refuelHandler {};
		};

		class UI
		{
			file = "\ot\functions\UI";
			class notifyMinor {};
			class notifyBig {};
			class notifyGood {};
			class notifyVehicle {};
		};

		class Dialogs
		{
			file = "\ot\functions\UI\dialogs";

			class mainMenu {};
			class buyDialog {};
			class sellDialog {};
			class workshopDialog {};
			class policeDialog {};
			class warehouseDialog {};
			class inputDialog {};
			class importDialog {};
			class recruitDialog {};
			class buyClothesDialog {};
			class buyVehicleDialog {};
			class gunDealerDialog {};
			class factoryDialog {};
			class garrisonDialog {};
			class newGameDialog {};
			class optionsDialog {};
			class resistanceDialog {};
			class reverseEngineerDialog {};
			class vehicleDialog {};
			class mapInfoDialog {};
		};

		class Display
		{
			file = "\ot\functions\UI\display";
			class displayShopPic {};
			class displayWarehousePic {};
			class showMemberInfo {};
			class showBusinessInfo {};
			class refreshEmployees {};
		};

		/*
		* User actions
		*/
		class Actions
		{
			file = "\ot\functions\actions";

			class newGame {};

			/* Main Menu */
			class salvageWreck {};
			class buyBuilding {};
			class fastTravel {};
			class talkToCiv {};
			class recruitCiv {};

			/* Options */
			class increaseTax {};
			class decreaseTax {};

			/* Vehicle */
			class transferTo {};
			class transferFrom {};
			class transferLegit {};
			class takeLegit {};
			class warehouseTake {};

			/* Port */
			class exportAll {};

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
			class makeGeneral {};
			class giveFunds {};
			class takeFunds {};
			class transferFunds {};
			class hireEmployee {};
			class fireEmployee {};

			/* Other */
			class addGarrison {};
			class addPolice {};
			class lockVehicle {};
			class reverseEngineer {};
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
			class getRegion {};
			class townsInRegion {};
			class regionIsConnected {};
			class getAO {};
			class getBuildId {};
			class weatherSystem {};
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
			class resetSpawn {};
		};

		/*
		* The economy, trade and real estate
		*/
		class Economy
		{
			file = "\ot\functions\economy";
			class initEconomy {};
			class initEconomyLoad {};
			class setupTownEconomy {};
			class standing {};
			class getPrice {};
			class getSellPrice {};
			class getDrugPrice {};
			class nearestRealEstate {};
			class getRealEstateData {};
			class getBusinessData {};
			class getBusinessPrice {};
			class getTaxIncome {};
			class resistanceFunds {};
			class incomeSystem {};
			class propagandaSystem {};
		}

		/*
		* Inventory transfer and manegement
		*/
		class Inventory
		{
			file = "\ot\functions\inventory";
			class takeFromCargoContainers {};
			class hasFromCargoContainers {};
		};

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
			class createSquad {};
			class experience {};
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
			class squadAssignVehicle {};
			class squadGetIn {};
			class squadGetOut {};
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
			class initRecruit {};
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
			class NATOConvoy {};
			class NATODeployFOB {};
			class NATOMissionDeployFOB {};
			class NATOMissionReconDestroy {};
			class NATOSetExplosives {};
			class NATOupgradeFOB {};
		};

		class NATOAI
		{
			file = "\ot\functions\factions\NATO\AI";
			class NATODrone {};
			class NATOMortar {};
		};

		class Buildings
		{
			file = "\ot\functions\buildings";
			class initBuilding {};
			class initObservationPost {};

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
