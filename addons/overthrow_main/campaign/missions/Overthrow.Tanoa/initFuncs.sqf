if(isServer) then {
    server setVariable ["StartupType","",true];
};
//Helper functions
townsInRegion = compileFinal preProcessFileLineNumbers "funcs\townsInRegion.sqf";
randomPosition = compileFinal preProcessFileLineNumbers "funcs\randomPosition.sqf";
spawnTemplate = compileFinal preProcessFileLineNumbers "funcs\spawnTemplate.sqf";
spawnTemplateAttached = compileFinal preProcessFileLineNumbers "funcs\spawnTemplateAttached.sqf";
inSpawnDistance = compileFinal preProcessFileLineNumbers "funcs\inSpawnDistance.sqf";
nearestTown = compileFinal preProcessFileLineNumbers "funcs\nearestTown.sqf";
getPrice = compileFinal preProcessFileLineNumbers "funcs\getPrice.sqf";
getSellPrice = compileFinal preProcessFileLineNumbers "funcs\getSellPrice.sqf";
getDrugPrice = compileFinal preProcessFileLineNumbers "funcs\getDrugPrice.sqf";
canFit = compileFinal preProcessFileLineNumbers "funcs\canFit.sqf";
totalCarry = compileFinal preProcessFileLineNumbers "funcs\totalCarry.sqf";
unitStock = compileFinal preProcessFileLineNumbers "funcs\unitStock.sqf";
searchStock = compileFinal preProcessFileLineNumbers "funcs\searchStock.sqf";
hasOwner = compileFinal preProcessFileLineNumbers "funcs\hasOwner.sqf";
getRandomBuildingPosition = compileFinal preProcessFileLineNumbers "funcs\getRandomBuildingPosition.sqf";
getRandomBuilding = compileFinal preProcessFileLineNumbers "funcs\getRandomBuilding.sqf";
getNearestRealEstate = compileFinal preProcessFileLineNumbers "funcs\getNearestRealEstate.sqf";
getNearestOwned = compileFinal preProcessFileLineNumbers "funcs\getNearestOwned.sqf";
nearestPositionRegion = compileFinal preProcessFileLineNumbers "funcs\nearestPositionRegion.sqf";
nearestComms = compileFinal preProcessFileLineNumbers "funcs\nearestComms.sqf";
nearestCheckpoint = compileFinal preProcessFileLineNumbers "funcs\nearestCheckpoint.sqf";
nearestBase = compileFinal preProcessFileLineNumbers "funcs\nearestBase.sqf";
nearestObjective = compileFinal preProcessFileLineNumbers "funcs\nearestObjective.sqf";
nearestMobster = compileFinal preProcessFileLineNumbers "funcs\nearestMobster.sqf";
giveIntel = compileFinal preProcessFileLineNumbers "funcs\giveIntel.sqf";
logisticsUnload = compileFinal preProcessFileLineNumbers "funcs\logisticsUnload.sqf";
eject = compileFinal preProcessFileLineNumbers "funcs\addons\eject.sqf";
displayShopPic = compileFinal preProcessFileLineNumbers "funcs\displayShopPic.sqf";
displayWarehousePic = compileFinal preProcessFileLineNumbers "funcs\displayWarehousePic.sqf";
dumpStuff = compileFinal preProcessFileLineNumbers "funcs\dumpStuff.sqf";
takeStuff = compileFinal preProcessFileLineNumbers "funcs\takeStuff.sqf";
canPlace = compileFinal preProcessFileLineNumbers "funcs\canPlace.sqf";
progressBar = compileFinal preProcessFileLineNumbers "funcs\progressBar.sqf";
getRealEstateData = compileFinal preProcessFileLineNumbers "funcs\getRealEstateData.sqf";
revealToNATO = compileFinal preProcessFileLineNumbers "funcs\revealToNATO.sqf";
revealToCRIM = compileFinal preProcessFileLineNumbers "funcs\revealToCRIM.sqf";
findScopeInWarehouse = compileFinal preProcessFileLineNumbers "funcs\findScopeInWarehouse.sqf";
findWeaponInWarehouse = compileFinal preProcessFileLineNumbers "funcs\findWeaponInWarehouse.sqf";
findVestInWarehouse = compileFinal preProcessFileLineNumbers "funcs\findVestInWarehouse.sqf";
findHelmetInWarehouse = compileFinal preProcessFileLineNumbers "funcs\findHelmetInWarehouse.sqf";
removeFromWarehouse = compileFinal preProcessFileLineNumbers "funcs\removeFromWarehouse.sqf";
getSoldier = compileFinal preProcessFileLineNumbers "funcs\getSoldier.sqf";
createSoldier = compileFinal preProcessFileLineNumbers "funcs\createSoldier.sqf";

//AI init
initCivilian = compileFinal preProcessFileLineNumbers "AI\civilian.sqf";
initGendarm = compileFinal preProcessFileLineNumbers "AI\gendarm.sqf";
initPolice = compileFinal preProcessFileLineNumbers "AI\police.sqf";
initSecurity = compileFinal preProcessFileLineNumbers "AI\security.sqf";
initMilitary = compileFinal preProcessFileLineNumbers "AI\military.sqf";
initSniper = compileFinal preProcessFileLineNumbers "AI\sniper.sqf";
initPolicePatrol = compileFinal preProcessFileLineNumbers "AI\policePatrol.sqf";
initGendarmPatrol = compileFinal preProcessFileLineNumbers "AI\gendarmPatrol.sqf";
initMilitaryPatrol = compileFinal preProcessFileLineNumbers "AI\militaryPatrol.sqf";
initCheckpoint = compileFinal preProcessFileLineNumbers "AI\checkpoint.sqf";
initCriminal = compileFinal preProcessFileLineNumbers "AI\criminal.sqf";
initCrimLeader = compileFinal preProcessFileLineNumbers "AI\crimLeader.sqf";
initShopkeeper = compileFinal preProcessFileLineNumbers "AI\shopkeeper.sqf";
initCarDealer = compileFinal preProcessFileLineNumbers "AI\carDealer.sqf";
initHarbor = compileFinal preProcessFileLineNumbers "AI\harbor.sqf";
initGunDealer = compileFinal preProcessFileLineNumbers "AI\gunDealer.sqf";
civilianGroup = compileFinal preProcessFileLineNumbers "AI\civilianGroup.sqf";
initRecruit = compileFinal preProcessFileLineNumbers "AI\recruit.sqf";
initMobster = compileFinal preProcessFileLineNumbers "AI\mobster.sqf";
initMobBoss = compileFinal preProcessFileLineNumbers "AI\mobBoss.sqf";
initPriest = compileFinal preProcessFileLineNumbers "AI\priest.sqf";

intelEvent = compileFinal preProcessFileLineNumbers "funcs\intelEvent.sqf";
intelLevel = compileFinal preProcessFileLineNumbers "funcs\intelLevel.sqf";
assignMission = compileFinal preProcessFileLineNumbers "funcs\assignMission.sqf";
doConversation = compileFinal preProcessFileLineNumbers "funcs\doConversation.sqf";
playerDecision = compileFinal preProcessFileLineNumbers "funcs\playerDecision.sqf";

//AI Orders
openInventory = compileFinal preProcessFileLineNumbers "AI\orders\openInventory.sqf";
loot = compileFinal preProcessFileLineNumbers "AI\orders\loot.sqf";

//UI
mainMenu = compileFinal preProcessFileLineNumbers "UI\mainMenu.sqf";
buildMenu = compileFinal preProcessFileLineNumbers "UI\buildMenu.sqf";
manageRecruits = compileFinal preProcessFileLineNumbers "UI\manageRecruits.sqf";
characterSheet = compileFinal preProcessFileLineNumbers "UI\characterSheet.sqf";
buyDialog = compileFinal preProcessFileLineNumbers "UI\buyDialog.sqf";
buyClothesDialog = compileFinal preProcessFileLineNumbers "UI\buyClothesDialog.sqf";
sellDialog = compileFinal preProcessFileLineNumbers "UI\sellDialog.sqf";
workshopDialog = compileFinal preProcessFileLineNumbers "UI\workshopDialog.sqf";
policeDialog = compileFinal preProcessFileLineNumbers "UI\policeDialog.sqf";
warehouseDialog = compileFinal preProcessFileLineNumbers "UI\warehouseDialog.sqf";
inputDialog = compileFinal preProcessFileLineNumbers "UI\inputDialog.sqf";
importDialog = compileFinal preProcessFileLineNumbers "UI\importDialog.sqf";
recruitDialog = compileFinal preProcessFileLineNumbers "UI\recruitDialog.sqf";
buyVehicleDialog = compileFinal preProcessFileLineNumbers "UI\buyVehicleDialog.sqf";

//QRF
NATOQRF = compileFinal preProcessFileLineNumbers "AI\QRF\NATOQRF.sqf";
NATOGroundForces = compileFinal preProcessFileLineNumbers "AI\QRF\NATOGroundForces.sqf";
NATOAirSupport = compileFinal preProcessFileLineNumbers "AI\QRF\NATOAirSupport.sqf";
NATOGroundSupport = compileFinal preProcessFileLineNumbers "AI\QRF\NATOGroundSupport.sqf";
NATOattack = compileFinal preProcessFileLineNumbers "AI\QRF\NATOattack.sqf";
NATOcounter = compileFinal preProcessFileLineNumbers "AI\QRF\NATOcounter.sqf";
CTRGSupport = compileFinal preProcessFileLineNumbers "AI\QRF\CTRGSupport.sqf";
NATOretakeTown = compileFinal preProcessFileLineNumbers "AI\QRF\NATOretakeTown.sqf";
NATOrecon = compileFinal preProcessFileLineNumbers "AI\QRF\NATOrecon.sqf";
NATOsniper = compileFinal preProcessFileLineNumbers "AI\QRF\NATOsniper.sqf";

template_playerDesk = [] call compileFinal preProcessFileLineNumbers "templates\playerdesk.sqf";
template_checkpoint = [] call compileFinal preProcessFileLineNumbers "templates\NATOcheckpoint.sqf";

[] call compileFinal preProcessFileLineNumbers "funcs\dict.sqf";

//Events
illegalContainerOpened = compileFinal preProcessFileLineNumbers "events\illegalContainerOpened.sqf";

//Insertion
reGarrisonTown = compileFinal preProcessFileLineNumbers "spawners\insertion\reGarrisonTown.sqf";
sendCrims = compileFinal preProcessFileLineNumbers "spawners\insertion\sendCrims.sqf";
newLeader = compileFinal preProcessFileLineNumbers "spawners\insertion\newLeader.sqf";
logistics = compileFinal preProcessFileLineNumbers "spawners\insertion\logistics.sqf";

//Local interactions
initShopLocal = compileFinal preProcessFileLineNumbers "interaction\initShopLocal.sqf";
initCarShopLocal = compileFinal preProcessFileLineNumbers "interaction\initCarShopLocal.sqf";
initGunDealerLocal = compileFinal preProcessFileLineNumbers "interaction\initGunDealerLocal.sqf";
initHarborLocal = compileFinal preProcessFileLineNumbers "interaction\initHarborLocal.sqf";
initObjectLocal = compileFinal preProcessFileLineNumbers "interaction\initObjectLocal.sqf";
initStaticMGLocal = compileFinal preProcessFileLineNumbers "interaction\initStaticMGLocal.sqf";

//Economy
setupTownEconomy = compileFinal preProcessFileLineNumbers "economy\setupTownEconomy.sqf";

//Math
rotationMatrix = compileFinal preProcessFileLineNumbers "funcs\rotationMatrix.sqf";
matrixMultiply = compileFinal preProcessFileLineNumbers "funcs\matrixMultiply.sqf";
matrixRotate = compileFinal preProcessFileLineNumbers "funcs\matrixRotate.sqf";

//Actions
buy = compileFinal preProcessFileLineNumbers "actions\buy.sqf";
sell = compileFinal preProcessFileLineNumbers "actions\sell.sqf";
sellall = compileFinal preProcessFileLineNumbers "actions\sellall.sqf";
workshopAdd = compileFinal preProcessFileLineNumbers "actions\workshopAdd.sqf";
buyBuilding = compileFinal preProcessFileLineNumbers "actions\buyBuilding.sqf";
leaseBuilding = compileFinal preProcessFileLineNumbers "actions\leaseBuilding.sqf";
recruitCiv = compileFinal preProcessFileLineNumbers "actions\recruitCiv.sqf";
rearmGroup = compileFinal preProcessFileLineNumbers "actions\rearmGroup.sqf";
recruitSoldier = compileFinal preProcessFileLineNumbers "actions\recruitSoldier.sqf";
recruitSquad = compileFinal preProcessFileLineNumbers "actions\recruitSquad.sqf";
fastTravel = compileFinal preProcessFileLineNumbers "actions\fastTravel.sqf";
setHome = compileFinal preProcessFileLineNumbers "actions\setHome.sqf";
giveMoney = compileFinal preProcessFileLineNumbers "actions\giveMoney.sqf";
saveGamePersistent = compileFinal preProcessFileLineNumbers "actions\saveGame.sqf";
loadGamePersistent = compileFinal preProcessFileLineNumbers "actions\loadGame.sqf";
getIntel = compileFinal preProcessFileLineNumbers "actions\getIntel.sqf";
transferFrom = compileFinal preProcessFileLineNumbers "actions\transferFrom.sqf";
transferTo = compileFinal preProcessFileLineNumbers "actions\transferTo.sqf";
transferLegit = compileFinal preProcessFileLineNumbers "actions\transferLegit.sqf";
talkToCiv = compileFinal preProcessFileLineNumbers "actions\talkToCiv.sqf";
addPolice = compileFinal preProcessFileLineNumbers "actions\addPolice.sqf";
warehouseTake = compileFinal preProcessFileLineNumbers "actions\warehouseTake.sqf";
exportAll = compileFinal preProcessFileLineNumbers "actions\exportAll.sqf";
import = compileFinal preProcessFileLineNumbers "actions\import.sqf";
restoreLoadout = compileFinal preProcessFileLineNumbers "actions\restoreLoadout.sqf";
removeLoadout = compileFinal preProcessFileLineNumbers "actions\removeLoadout.sqf";

//Modes
placementMode = compileFinal preProcessFileLineNumbers "actions\placementMode.sqf";

//Wanted System
unitSeen = compileFinal preProcessFileLineNumbers "funcs\unitSeen.sqf";
unitSeenCRIM = compileFinal preProcessFileLineNumbers "funcs\unitSeenCRIM.sqf";
unitSeenNATO = compileFinal preProcessFileLineNumbers "funcs\unitSeenNATO.sqf";
wantedSystem = compileFinal preProcessFileLineNumbers "wantedSystem.sqf";
NATOsearch = compileFinal preProcessFileLineNumbers "AI\NATOsearch.sqf";

//Other Systems
perkSystem = compileFinal preProcessFileLineNumbers "perkSystem.sqf";
statsSystem = compileFinal preProcessFileLineNumbers "stats.sqf";
intelSystem = compileFinal preProcessFileLineNumbers "intelSystem.sqf";

//Key handler
keyHandler = compileFinal preProcessFileLineNumbers "keyHandler.sqf";
menuHandler = {};

//Addons
[] execVM "SHK_pos\shk_pos_init.sqf";

fnc_getBuildID = compileFinal preProcessFileLineNumbers "funcs\fnc_getBuildID.sqf";

//Credit to John681611: http://www.armaholic.com/page.php?id=25720
mpAddEventHand = {
private["_obj","_type","_code"];
_obj = _this select 0;
_type = _this select 1;
_code = _this select 2;
_add = _obj addEventHandler [_type,_code];
};
mpRemoveEventHand = {
private["_obj","_type","_index"];
_obj = _this select 0;
_type = _this select 1;
_index = _this select 2;
_obj removeEventHandler [_type, _index];
};
AUG_GetIn = {
	_aug = (_this select 0) getVariable["AUG_Attached",false];
	if((count (crew _aug)) > 0) exitWith {hint 'Weapon must be empty to mount';};
	(_this select 1) moveInGunner _aug;
};
AUG_UpdateState = {
	//Update Action
	[(_this select 0),((_this select 0) getVariable "AUG_Act")] call BIS_fnc_holdActionRemove;
 	_ls = [ (_this select 0),(_this select 1),
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
				"speed _target <= 1 AND speed _target >= -1 AND _target distance _this < 5 AND vehicle _this == _this AND ( typeNAME (_target getVariable 'AUG_Attached') != 'BOOL' OR typeNAME (_target getVariable 'AUG_Local') != 'BOOL')",
				"true",
					{(_this select 1) playMoveNow  "Acts_carFixingWheel";}
					,{},
					{(_this select 1) switchmove "";[(_this select 0)] Call AUG_Action;},
					{(_this select 1) switchmove "";},[],13,1.5,false,false] Call BIS_fnc_holdActionAdd;
	(_this select 0) setVariable ["AUG_Act",_ls,false];

};
AUG_UpdateGetInState = {
	//Update Action
	(_this select 0) setUserActionText [(_this select 0) getVariable "AUG_Act_GetIn",(_this select 1),(_this select 2)];
};
AUG_Action = {
	_veh = (_this select 0);
	if( typeNAME(_veh getVariable["AUG_Attached",false]) == "OBJECT")  then {
		[_veh,(_this select 1)] call AUG_Detach;
	}else{
		[_veh,(_this select 1)] call AUG_Attach;

	}
};
AUG_AddAction = {
	// mp issues may occure
	_ls = [ (_this select 0),"","","","speed _target <= 1 AND speed _target >= -1 AND _target distance _this < 5  AND vehicle _this == _this AND ( typeNAME (_target getVariable 'AUG_Attached') != 'BOOL' OR typeNAME (_target getVariable 'AUG_Local') != 'BOOL')","true",{},{},{},{},[],13,nil,false,false] call BIS_fnc_holdActionAdd;
	_vls = (_this select 0) addAction ["", {[(_this select 0),(_this select 1)] spawn AUG_GetIn;},[],5.5,true,true,"","typeNAME (_target getVariable 'AUG_Attached') != 'BOOL' AND _target distance _this < 5"];
	(_this select 0) setVariable ["AUG_Act",_ls,false];
	(_this select 0) setVariable ["AUG_Act_GetIn",_vls,false];
	(_this select 0) setVariable["AUG_Attached",false,true];
	(_this select 0) setVariable["AUG_Local",false,true];
};

mpSetDir = {
	private["_obj","_dir"];
	_obj = _this select 0;
	_dir = _this select 1;

	_obj setDir _dir;
};

structureInit = {
	private _pos = _this select 0;
	private _code = compileFinal preProcessFileLineNumbers (_this select 1);
	[_pos] spawn _code;
};

blackFaded = {
	_txt = format ["<t size='0.5' color='#000000'>Please wait... %1</t>",_this]; 
    [_txt, 0, 0.2, 30, 0, 0, 2] spawn bis_fnc_dynamicText;
};

canDrive = {
	((_this getHitPointDamage "HitLFWheel") < 1) and
	((_this getHitPointDamage "HitLF2Wheel") < 1) and
	((_this getHitPointDamage "HitRFWheel") < 1) and
	((_this getHitPointDamage "HitRF2Wheel") < 1) and
	((_this getHitPointDamage "HitFuel") < 1) and
	((_this getHitPointDamage "HitEngine") < 1)
};

distributeAILoad = {	
	private _send = true;
	private _group = _this;
	if(OT_serverTakesLoad) then {
		if(random 100 > (100 / ((count OT_activeClients) + 1))) then {
			_send = false;
		};
	};
	if(_send) then {	
		_group setGroupOwner owner(selectRandom OT_activeClients);	
	};
};

newGame = {
    "Generating economy" remoteExec['blackFaded',0,false];
    [] execVM "initEconomy.sqf";
    waitUntil {!isNil "OT_economyInitDone"};
    server setVariable["StartupType","NEW",true];
};

setupKeyHandler = {
    waitUntil {!(isnull (findDisplay 46))};
    sleep 1;
    (findDisplay 46) displayAddEventHandler ["KeyDown",keyHandler];
};

setAIFace = {
	(_this select 0) setFace (_this select 1);
};

setAISpeaker = {
	(_this select 0) setSpeaker (_this select 1);
};

assignedKey = {
	(cba_keybinding_dikDecToStringTable select ((actionKeys _this) select 0)+1) select 1
};

standing = {
    _town = _this select 0;
    _rep = (player getVariable format["rep%1",_town])+(_this select 1);
    player setVariable [format["rep%1",_town],_rep,true];    
    _totalrep = (player getVariable "rep")+(_this select 1);
    player setVariable ["rep",_totalrep,true];    
	
	if(count _this > 2) then {
		format["%1 (%2 Standing)",_this select 2,_this select 1] call notify_minor;
	};
};

setCivName = {
	if(typename (_this select 1) == "STRING") then {
		(_this select 0) setName (_this select 1);
	};
};

loadPlayerData = {
	private _player = _this;
	_newplayer = true;
	_data = server getvariable (getplayeruid _player);
	_count = 0;
    if !(isNil "_data") then {
        _newplayer = false;
        {
            _key = _x select 0;
            _val = _x select 1;  
			if !(isNil "_val") then {
				_player setVariable [_key,_val,true];
			};
			_count = _count + 1;
			if(_count > 50) then {
				_count = 0;
				sleep 0.1;
			};
        }foreach(_data);        
		
    };
	
	_loadout = server getvariable format["loadout%1",getplayeruid _player];
	if !(isNil "_loadout") then {
		_player setunitloadout _loadout;
	};
	_player setVariable ["OT_loaded",true,true];
	_player setVariable ["OT_newplayer",_newplayer,true];
};

influence = {
    _totalrep = (player getVariable ["influence",0])+_this;
    player setVariable ["influence",_totalrep,true]; 
	_plusmin = "";
    if(_this > 0) then {
        _plusmin = "+";
    };
    format["%1%2 Influence",_plusmin,_this] call notify_minor;	
};

influenceSilent = {
    _totalrep = (player getVariable ["influence",0])+_this;
    player setVariable ["influence",_totalrep,true]; 
};

stopAndFace = {	
	(_this select 0) disableAI "PATH";
	(group (_this select 0)) setFormDir (_this select 1);	
	(_this select 0) spawn {
		_ti = 0;
		waitUntil {sleep 1;_ti = _ti + 1;(!(_this getVariable["OT_talking",false]) and isNull (findDisplay 8001) and isNull (findDisplay 8002)) or _ti > 20};
		_this remoteExec ['restartAI',2];
	};
};

restartAI = {
	_this enableAI "PATH";
};

rewardMoney = {
	_who = _this select 0;
	_amount = _this select 1;
	if(isPlayer _who) then {
		[_amount] remoteExec ["money",_who,false];
	}else{
		if((side _who) == resistance) then {
			//we spread it amongst everyone
			_perPlayer = round(_amount / count([] call CBA_fnc_players));
			if(_perPlayer > 0) then {
				{
					[_perPlayer] remoteExec ["money",_x,false];
				}foreach([] call CBA_fnc_players);	
			};		
		};
	};	
};

money = {
    _amount = _this select 0;
    _rep = (player getVariable "money")+_amount;
    if(_rep < 0) then {     
        _rep = 0;       
    };
    player setVariable ["money",_rep,true];
    playSound "3DEN_notificationDefault";
    _plusmin = "";
    if(_amount > 0) then {
        _plusmin = "+";
    };
    format["%1$%2",_plusmin,[_amount, 1, 0, true] call CBA_fnc_formatNumber] call notify_minor;
    
};

stability = {
    _town = _this select 0;
    
    _townmrk = format["%1-abandon",_town];
    _stability = (server getVariable format["stability%1",_town])+(_this select 1);
    if(_stability < 0) then {_stability = 0};
	if(_stability > 100) then {_stability = 100};
    server setVariable [format["stability%1",_town],_stability,true];
    
    _abandoned = server getVariable "NATOabandoned";
    if(_town in _abandoned) then {
        _townmrk setMarkerAlpha 1;
    }else{
        _townmrk setMarkerAlpha 0;
    };
	
	_garrison = server getVariable [format['police%1',_town],0];
	if(_garrison > 0) then {
		_townmrk setMarkerType "OT_Police";
	}else{
		_townmrk setMarkerType "OT_Anarchy";
	};			
    
    //update the markers
    if(_stability < 50) then {
        _town setMarkerColor "ColorRed";
        _town setMarkerAlpha 1.0 - (_stability / 50);
        _townmrk setMarkerColor "ColorOPFOR";       
    }else{
        _townmrk setMarkerColor "ColorGUER";
        if(_town in _abandoned) then {
            _town setMarkerAlpha ((_stability - 50) / 100);
            _town setMarkerColor "ColorGUER";
        }else{
            _town setMarkerAlpha 0;
        };
    }
    
};

KK_fnc_fileExists = {
    private ["_ctrl", "_fileExists"];
    disableSerialization;
    _ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
    _ctrl htmlLoad _this;
    _fileExists = ctrlHTMLLoaded _ctrl;
    ctrlDelete _ctrl;
    _fileExists
};

OT_notifies = [];

notify = {
    _txt = format ["<t size='0.8' color='#ffffff'>%1</t>",_this]; 
	OT_notifies pushback _txt;
};

notify_good = {
    playSound "3DEN_notificationDefault";
    _txt = format ["<t size='0.6' color='#ffffff'>%1</t>",_this];
	OT_notifies pushback _txt;
};

notify_minor = {
    _txt = format ["<t size='0.6' color='#ffffff'>%1</t>",_this]; 
	OT_notifies pushback _txt;
};

notify_long = {
    _txt = format ["<t size='0.5' color='#ffffff'>%1</t>",_this];
    [_txt, 0, -0.136, 30, 1, 0, 2] spawn bis_fnc_dynamicText;
};

notify_talk = {
    _txt = format ["<t size='0.5' color='#dddddd'>%1</t>",_this];
	OT_notifies pushback _txt;
};

[] execVM "funcs\info.sqf";

fn_MovingTarget =
{
	private ["_target","_distance","_speed","_dir"];
	_target = _this select 0;
	_dir = _this select 1;
	_distance = _this select 2;
	_speed = _this select 3;
	_pause = _this select 4;
	
	
	while {true} do
	{
		sleep _pause;
		for "_i" from 0 to _distance/_speed do
		{
			_target setPos 
			[
				(position _target select 0) + ((sin (_dir)))*_speed,
				(position _target select 1) + ((cos (_dir)))*_speed,
				0
			];
			sleep 0.01;
		};
		sleep _pause;
		for "_i" from 0 to _distance/_speed do
		{
			_target setPos 
			[
				(position _target select 0) - (sin (_dir))*_speed,
				(position _target select 1) - ((cos (_dir)))*_speed,
				0
			];
			sleep 0.01;
		};
	};
};

fnc_isInMarker = {
    private ["_p","_m", "_px", "_py", "_mpx", "_mpy", "_msx", "_msy", "_rpx", "_rpy", "_xmin", "_xmax", "_ymin", "_ymax", "_ma", "_res", "_ret"];
    
    _p = _this select 0; // object
    _m = _this select 1; // marker
    
    if (typeName _p == "OBJECT") then {
      _px = position _p select 0;
      _py = position _p select 1;
    }else {
        if(typeName _p == "ARRAY") then {
          _px = _p select 0;
          _py = _p select 1;
        }else{
            _p = server getVariable _p;
            _px = _p select 0;
            _py = _p select 1;
        };
    };
    
    _mpx = getMarkerPos _m select 0;
    _mpy = getMarkerPos _m select 1;
    _msx = getMarkerSize _m select 0;
    _msy = getMarkerSize _m select 1;
    _ma = -markerDir _m;
    _rpx = ( (_px - _mpx) * cos(_ma) ) + ( (_py - _mpy) * sin(_ma) ) + _mpx;
    _rpy = (-(_px - _mpx) * sin(_ma) ) + ( (_py - _mpy) * cos(_ma) ) + _mpy;
    if ((markerShape _m) == "RECTANGLE") then {
      _xmin = _mpx - _msx;_xmax = _mpx + _msx;_ymin = _mpy - _msy;_ymax = _mpy + _msy;
      if (((_rpx > _xmin) && (_rpx < _xmax)) && ((_rpy > _ymin) && (_rpy < _ymax))) then { _ret=true; } else { _ret=false; };
    } else {
      _ret = false; //Who's passing ellipses in?
    };
    _ret;
  };
