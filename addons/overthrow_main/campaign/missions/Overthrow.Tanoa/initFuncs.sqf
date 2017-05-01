//Helper functions
totalCarry = compileFinal preProcessFileLineNumbers "funcs\totalCarry.sqf";
searchStock = compileFinal preProcessFileLineNumbers "funcs\searchStock.sqf";
giveIntel = compileFinal preProcessFileLineNumbers "funcs\giveIntel.sqf";
displayShopPic = compileFinal preProcessFileLineNumbers "funcs\displayShopPic.sqf";
displayWarehousePic = compileFinal preProcessFileLineNumbers "funcs\displayWarehousePic.sqf";
dumpStuff = compileFinal preProcessFileLineNumbers "funcs\dumpStuff.sqf";
takeStuff = compileFinal preProcessFileLineNumbers "funcs\takeStuff.sqf";
progressBar = compileFinal preProcessFileLineNumbers "funcs\progressBar.sqf";
revealToNATO = compileFinal preProcessFileLineNumbers "funcs\revealToNATO.sqf";
revealToCRIM = compileFinal preProcessFileLineNumbers "funcs\revealToCRIM.sqf";

intelEvent = compileFinal preProcessFileLineNumbers "funcs\intelEvent.sqf";
intelLevel = compileFinal preProcessFileLineNumbers "funcs\intelLevel.sqf";
doConversation = compileFinal preProcessFileLineNumbers "funcs\doConversation.sqf";
playerDecision = compileFinal preProcessFileLineNumbers "funcs\playerDecision.sqf";

OT_fnc_NATOConvoy = compileFinal preProcessFileLineNumbers "AI\fn_NATOConvoy.sqf";

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
gunDealerDialog = compileFinal preProcessFileLineNumbers "UI\gunDealerDialog.sqf";

resistanceScreen = compileFinal preprocessFileLineNumbers "UI\fn_resistanceDialog.sqf";
OT_fnc_resistanceDialog = resistanceScreen;
OT_fnc_mapInfoDialog = compileFinal preprocessFileLineNumbers "actions\townInfo.sqf";
OT_fnc_showMemberInfo = compileFinal preprocessFileLineNumbers "UI\actions\fn_showMemberInfo.sqf";
OT_fnc_showBusinessInfo = compileFinal preprocessFileLineNumbers "UI\actions\fn_showBusinessInfo.sqf";
OT_fnc_factoryDialog = compileFinal preProcessFileLineNumbers "UI\fn_factoryDialog.sqf";
OT_fnc_reverseEngineerDialog = compileFinal preProcessFileLineNumbers "UI\fn_reverseEngineerDialog.sqf";
OT_fnc_vehicleDialog = compileFinal preProcessFileLineNumbers "UI\fn_vehicleDialog.sqf";
OT_fnc_factoryRefresh = compileFinal preProcessFileLineNumbers "UI\actions\fn_factoryRefresh.sqf";
OT_fnc_factorySet = compileFinal preProcessFileLineNumbers "UI\actions\fn_factorySet.sqf";
OT_fnc_newGameDialog = compileFinal preProcessFileLineNumbers "UI\fn_newGameDialog.sqf";
OT_fnc_optionsDialog = compileFinal preProcessFileLineNumbers "UI\fn_optionsDialog.sqf";

template_playerDesk = [] call compileFinal preProcessFileLineNumbers "templates\playerdesk.sqf";
template_checkpoint = [] call compileFinal preProcessFileLineNumbers "templates\NATOcheckpoint.sqf";

[] call compileFinal preProcessFileLineNumbers "funcs\dict.sqf";

//Events
illegalContainerOpened = compileFinal preProcessFileLineNumbers "events\illegalContainerOpened.sqf";

//Insertion
reGarrisonTown = compileFinal preProcessFileLineNumbers "spawners\insertion\reGarrisonTown.sqf";
sendCrims = compileFinal preProcessFileLineNumbers "spawners\insertion\sendCrims.sqf";
newLeader = compileFinal preProcessFileLineNumbers "spawners\insertion\newLeader.sqf";

//Local interactions
initObjectLocal = compileFinal preProcessFileLineNumbers "interaction\initObjectLocal.sqf";
initStaticMGLocal = compileFinal preProcessFileLineNumbers "interaction\initStaticMGLocal.sqf";

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
takeLegit = compileFinal preProcessFileLineNumbers "actions\takeLegit.sqf";
talkToCiv = compileFinal preProcessFileLineNumbers "actions\talkToCiv.sqf";
addPolice = compileFinal preProcessFileLineNumbers "actions\addPolice.sqf";
warehouseTake = compileFinal preProcessFileLineNumbers "actions\warehouseTake.sqf";
exportAll = compileFinal preProcessFileLineNumbers "actions\exportAll.sqf";
import = compileFinal preProcessFileLineNumbers "actions\import.sqf";
restoreLoadout = compileFinal preProcessFileLineNumbers "actions\restoreLoadout.sqf";
removeLoadout = compileFinal preProcessFileLineNumbers "actions\removeLoadout.sqf";
OT_fnc_getMission = compileFinal preProcessFileLineNumbers "actions\fn_getMission.sqf";
OT_fnc_getLocalMission = compileFinal preProcessFileLineNumbers "actions\fn_getLocalMission.sqf";
OT_fnc_salvageWreck = compileFinal preProcessFileLineNumbers "actions\fn_salvageWreck.sqf";

OT_fnc_takeFunds = compileFinal preProcessFileLineNumbers "UI\actions\fn_takeFunds.sqf";
OT_fnc_giveFunds = compileFinal preProcessFileLineNumbers "UI\actions\fn_giveFunds.sqf";
OT_fnc_transferFunds = compileFinal preProcessFileLineNumbers "UI\actions\fn_transferFunds.sqf";
OT_fnc_makeGeneral = compileFinal preProcessFileLineNumbers "UI\actions\fn_makeGeneral.sqf";


//Modes
placementMode = compileFinal preProcessFileLineNumbers "actions\placementMode.sqf";

//Wanted System
unitSeen = compileFinal preProcessFileLineNumbers "funcs\unitSeen.sqf";
unitSeenCRIM = compileFinal preProcessFileLineNumbers "funcs\unitSeenCRIM.sqf";
unitSeenNATO = compileFinal preProcessFileLineNumbers "funcs\unitSeenNATO.sqf";
wantedSystem = compileFinal preProcessFileLineNumbers "wantedSystem.sqf";

//Other Systems
perkSystem = compileFinal preProcessFileLineNumbers "perkSystem.sqf";
statsSystem = compileFinal preProcessFileLineNumbers "stats.sqf";
intelSystem = compileFinal preProcessFileLineNumbers "intelSystem.sqf";

//Key handler
keyHandler = compileFinal preProcessFileLineNumbers "keyHandler.sqf";
menuHandler = {};

fnc_getBuildID = compileFinal preProcessFileLineNumbers "funcs\fnc_getBuildID.sqf";

OT_fnc_generateBanditPositions = {
	_num = 10;
	_mobsters = [];
	_t = 0;
	for "_i" from 0 to _num do {
		_pp = [OT_centerPos,[0,20000]] call SHK_pos;
		{
			_pos = _x select 0;
			_pos set [2,0];
			if !(_pos isFlatEmpty  [-1, -1, 0.5, 10] isEqualTo []) then {
				_ob = _pos call OT_fnc_nearestObjective;
				_town = _pos call OT_fnc_nearestTown;

				_obpos = _ob select 0;
				_obdist = _obpos distance _pos;

				_towndist = 500;
				if (!isNil "_town") then {
					if !(_town in (server getVariable ["NATOabandoned",[]])) then {
						_stability = server getVariable format ["stability%1",_town];
						_population = server getVariable format ["population%1",_town];
						_towndist = (server getVariable _town) distance _pos;
						if(_stability < 20) then {
							_towndist = _towndist * 2;
						};
						if(_stability > 60) then {
							_towndist = _towndist * 0.5;
						};
						if(_population < 160) then {
							_towndist = _towndist * 2;
						};
					};
				};

				_control = _pos call OT_fnc_nearestCheckpoint;
				_cdist = (getmarkerpos _control) distance _pos;

				_mdist = 2000;
				if(_obdist > 1000 and _towndist > 400 and _cdist > 800 and _mdist > 700) then {
					_mobsters pushback _pos;
				};
			};
		}foreach (selectBestPlaces [_pp, 1200,"(1 + forest + trees) * (1 - houses) * (1 - sea)",10,600]);
		hint format["Generated %1 positions",count _mobsters];
	};
	copyToClipboard format["%1",_mobsters];
	hint format["Done! Generated %1 positions",count _mobsters];
};

OT_fnc_playerIsOwner = {
	(_this getVariable ["owner",""]) == (getplayeruid player)
};

OT_fnc_playerAtWarehouse = {
	private _iswarehouse = false;
	_b = (position player) call OT_fnc_nearestRealEstate;
	if(typename _b == "ARRAY") then {
		_building = _b select 0;
		if((typeof _building) == OT_warehouse and _building call OT_fnc_hasOwner) then {
			_iswarehouse = true;
		};
	};
	_iswarehouse
};

OT_fnc_lockVehicle = {
	private _veh = vehicle player;
	if((_veh getVariable ["owner",""]) != (getplayeruid player)) exitWith {};
	if(_veh getVariable ["OT_locked",false]) then {
		_veh setVariable ["OT_locked",false,true];
		"Vehicle unlocked" call notify_minor;
	}else{
		_veh setVariable ["OT_locked",true,true];
		"Vehicle locked" call notify_minor;
	};
};

OT_fnc_squadAssignVehicle = {
	_squad = (hcselected player) select 0;
	_veh = cursorObject;
	if((_veh isKindOf "Air") or (_veh isKindOf "Land") or (_veh isKindOf "Ship")) then {
		_squad addVehicle _veh;
		[] call OT_fnc_squadGetIn;
		player hcSelectGroup [_squad,false];
		format["%1 assigned to %2",(typeof _veh) call ISSE_Cfg_Vehicle_GetName,groupId _squad] call notify_minor;
	};
};

OT_fnc_squadGetIn = {
	{
		_squad = _x;
		(units _squad) orderGetIn true;
		player hcSelectGroup [_squad,false];
	}foreach(hcSelected player);
};

OT_fnc_squadGetOut = {
	{
		_squad = _x;
		(units _squad) orderGetIn false;
		player hcSelectGroup [_squad,false];
	}foreach(hcSelected player);
};

OT_fnc_regionIsConnected = {
	params ["_f","_t"];
	private _por = "";
	private _region = "";
	if((typename _f) == "ARRAY") then {
		_por = _f call OT_fnc_getRegion;
	}else{
		_por = _f;
	};
	if((typename _t) == "ARRAY") then {
		_region = _t call OT_fnc_getRegion;
	}else{
		_region = _t;
	};
	if(_por == _region) exitWith {true};
	private _ret = false;
	{
		if(((_x select 0) == _por) and ((_x select 1) == _region)) exitWith {_ret = true};
	}foreach(OT_connectedRegions);
	_ret;
};

OT_fnc_getRegion = {
	_pos = _this;
	_region = "";
	{
		if(_pos inArea _x) exitWith {_region = _x};
	}foreach(OT_regions);
	_region;
};

OT_fnc_missionSuccess = {
	player globalchat "Mission success";
	player setVariable [format["MissionData",_this],[],false];
};

OT_fnc_increaseTax = {
	private _rate = server getVariable ["taxrate",0];
	_rate = _rate + 5;
	if(_rate > 100) then {_rate = 100};
	server setVariable ["taxrate",_rate,true];
	format["Tax rate is now %1%2",_rate,"%"] call notify_minor;
};

OT_fnc_decreaseTax = {
	private _rate = server getVariable ["taxrate",0];
	_rate = _rate - 5;
	if(_rate < 0) then {_rate = 0};
	server setVariable ["taxrate",_rate,true];
	format["Tax rate is now %1%2",_rate,"%"] call notify_minor;
};

OT_fnc_hireEmployee = {
	private _idx = lbCurSel 1501;
	private _name = lbData [1501,_idx];
	private _rate = server getVariable [format["%1employ",_name],0];
	_rate = _rate + 1;
	if(_rate > 20) exitWith {};
	server setVariable [format["%1employ",_name],_rate,true];
	_name remoteExec ["OT_fnc_refreshEmployees",2,false];
	[] call OT_fnc_showBusinessInfo;
};

OT_fnc_playerIsGeneral = {
	(!isMultiplayer) or ((getPlayerUID player) in (server getvariable ["generals",[]]))
};

OT_fnc_refreshEmployees = {
	private _data = _this call OT_fnc_getEconomicData;
	private _pos = _data select 0;
	private _group = spawner getVariable [format["employees%1",_this],grpNull];
	{
		deleteVehicle _x;
	}foreach(units _group);
	deleteGroup _group;
	_pos call OT_fnc_resetSpawn;
};

OT_fnc_fireEmployee = {
	private _idx = lbCurSel 1501;
	private _name = lbData [1501,_idx];
	private _rate = server getVariable [format["%1employ",_name],0];
	_rate = _rate - 1;
	if(_rate < 0) then {_rate = 0};
	server setVariable [format["%1employ",_name],_rate,true];
	_name remoteExec ["OT_fnc_refreshEmployees",2,false];
	[] call OT_fnc_showBusinessInfo;
};

OT_fnc_getTaxIncome = {
	private _total = 0;
	private _inf = 0;
	{
		private _town = _x;
		_total = _total + 250;
		if(_town in OT_allAirports) then {
			_total = _total + ((server getVariable ["stabilityTanoa",100]) * 3); //Tourism income
		};
		_inf = _inf + 1;
		if(_town in OT_allTowns) then {
			private _population = server getVariable format["population%1",_town];
			private _stability = server getVariable format["stability%1",_town];
			private _garrison = server getVariable [format['police%1',_town],0];
			private _add = round(_population * 2 * (_stability/100));
			if(_stability > 49) then {
				_add = round(_add * 4);
			};
			_total = _total + _add;
		};
	}foreach(server getVariable ["NATOabandoned",[]]);
	[_total,_inf];
};

OT_fnc_takeFromContainers = {
	 params ["_input","_num","_pos"];
	 if(_num == 0) exitWith {true};
	 if(_num < 1) then {_num = 1};
	 _gotit = false;
	{
		_c = _x;
		{
			_x params ["_cls","_amt"];
			if(_cls == _input and _amt >= _num) exitWith {
				[_c, _cls, _num] call CBA_fnc_removeItemCargo;
				_gotit = true;
			};
		}foreach(_c call OT_fnc_unitStock);
	}foreach(_pos nearObjects [OT_item_CargoContainer, 50]);
	_gotit
};

OT_fnc_reverseEngineer = {
	private _idx = lbCurSel 1500;
	private _cls = lbData [1500,_idx];
	_cost = cost getVariable[_cls,[]];
	private _blueprints = server getVariable ["GEURblueprints",[]];
	if((count _cost) > 0 and !(_cls in _blueprints)) then {
		_blueprints pushBack _cls;
		server setVariable ["GEURblueprints",_blueprints,true];
		closeDialog 0;
		"Item is now available for production" call notify_minor;

		if(!(_cls isKindOf "Bag_Base") and _cls isKindOf "AllVehicles") then {
			private _veh = OT_factoryPos nearestObject _cls;
			deleteVehicle _veh;
		}else{
			player removeItem _cls;
		};
	}else{
		"Cannot reverse-engineer this item, please contact Overthrow Devs on Discord" call notify_minor;
	};
};

OT_fnc_hasFromContainers = {
	 params ["_input","_num","_pos"];
	 if(_num == 0) exitWith {true};
	 if(_num < 1) then {_num = 1};
	 _gotit = false;
	{
		_c = _x;
		{
			_x params ["_cls","_amt"];
			if(_cls == _input and _amt >= _num) exitWith {
				_gotit = true;
			};
		}foreach(_c call OT_fnc_unitStock);
	}foreach(_pos nearObjects [OT_item_CargoContainer, 50]);
	_gotit
};

OT_fnc_getOfflinePlayerAttribute = {
	params ["_uid","_attr"];
	private _val = "";
	if(count _this > 2) then {
		_val = _this select 2;
	};
	{
		_x params ["_k","_v"];
		if(_k == _attr) exitWith {_val=_v};
	}foreach(server getVariable [_uid,[]]);
	_val;
};
OT_fnc_setOfflinePlayerAttribute = {
	params ["_uid","_attr","_value"];
	private _params = server getVariable [_uid,[]];
	private _done = false;
	{
		_x params ["_k","_v"];
		if(_k == _attr) exitWith {_done=true;_x set [1,_value]};
	}foreach(_params);
	if(!_done) then {
		_params pushback [_attr,_value];
	};
	server setVariable [_uid,_params,true];
};

OT_fnc_getEconomicData = {
	private _name = _this;
	if(_name == "Factory") exitWith {[OT_factoryPos,"Factory"]};
	_data = [];
	{
		if((_x select 1) == _name) exitWith {_data = _x};
	}foreach(OT_economicData);
	_data;
};

OT_fnc_getBusinessPrice = {
	private _data = _this call OT_fnc_getEconomicData;
	private _baseprice = 300000;
	if(count _data == 2) then {
		//turns nothing into money
		_baseprice = round(_baseprice * 1.8);
	};
	if(count _data == 3) then {
		//turns something into money
		_baseprice = round(_baseprice * 1.3);
	};
	if(count _data == 4) then {
		if((_data select 2) != "" and (_data select 3) != "") then {
			//turns something into something
			_baseprice = round(_baseprice * 1.2);
		};
		if((_data select 2) == "" and (_data select 3) != "") then {
			if((_data select 3) == "OT_Steel") then {
				_baseprice = round(_baseprice * 2.4);
			};
			if((_data select 3) == "OT_Sugarcane") then {
				_baseprice = round(_baseprice * 0.4);
			};
		};
	};
	private _stability = 1.0 - ((server getVariable ["stabilityTanoa",100]) / 100);

	_baseprice + (_baseprice * _stability)
};

OT_fnc_resetSpawn = {
	_pars = _this;
	{
		_p = _x select 1;
		if(_p isEqualTo _pars) exitWith {
			_id = _x select 0;
			OT_allSpawned deleteAt (OT_allSpawned find _id);
		};
	}foreach(OT_allSpawners);
};

OT_fnc_resistanceFunds = {
	_funds = player getVariable ["money",0];
	if(isMultiplayer) then {
		_funds = server getVariable ["money",0];
	};
	if(count _this > 0) then {
		_funds = _funds + (_this select 0);
		if(isMultiplayer) then {
			server setVariable ["money",_funds,true];
		}else{
			player setVariable ["money",_funds,true];
		}
	};
	_funds;
};

OT_fnc_initRecruit = {
	private ["_civ"];

	_civ = _this select 0;

	removeAllActions _civ;
	_civ removeAllEventHandlers "FiredNear";

	[_civ, (OT_voices_local call BIS_fnc_selectRandom)] remoteExecCall ["setSpeaker", 0, _civ];

	_civ setSkill 1.0;
	_civ setRank "PRIVATE";
	_civ setVariable ["NOAI",false,true];

	_civ spawn wantedSystem;

	_recruits = server getVariable ["recruits",[]];
	_nameparts = (name _civ) splitString " ";

	_recruits pushback [getplayeruid player,[name _civ]+_nameparts,_civ,"PRIVATE",[],typeof _civ];
	server setVariable ["recruits",_recruits,true];
};

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
					(_this select 1),"Acts_carFixingWheel"] remoteExec ["playMoveNow",(_this select 1),false]
					,{},
					{[(_this select 1),""] remoteExec ["switchMove",(_this select 1),false];[(_this select 0)] Call AUG_Action;},
					[{[(_this select 1),""] remoteExec ["switchMove",(_this select 1),false];},[],13,1.5,false,false] Call BIS_fnc_holdActionAdd;
	(_this select 0) setVariable ["AUG_Act",_ls,false];

};
AUG_UpdateGetInState = {
	//Update Action
	(_this select 0) setUserActionText [(_this select 0) getVariable ["AUG_Act_GetIn",""],(_this select 1),(_this select 2)];
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
	params ["_obj","_dir"];
	if !(isNil "_dir") then {
		_obj setDir _dir;
	};
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
	if(OT_useDynamicSimulation) then {
		_group enableDynamicSimulation true;
	};
	if(OT_serverTakesLoad) then {
		if(random 100 > (100 / ((count OT_activeClients) + 1))) then {
			_send = false;
		};
	};
	if(_send) then {
		_group setGroupOwner owner(selectRandom OT_activeClients);
	};
};

OT_fnc_newGame = {
	closeDialog 0;
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

assignedKey = {
	(cba_keybinding_dikDecToStringTable select ((actionKeys _this) select 0)+1) select 1
};

standing = {
	if!(hasInterface) exitWith {};
    _town = _this select 0;
    _rep = (player getVariable [format["rep%1",_town],0])+(_this select 1);
    player setVariable [format["rep%1",_town],_rep,true];
    _totalrep = (player getVariable ["rep",0])+(_this select 1);
    player setVariable ["rep",_totalrep,true];

	if(count _this > 2) then {
		format["%1 (%2 %3)",_this select 2,_this select 1,_town] call notify_minor;
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
	if!(hasInterface) exitWith {};
    _totalrep = (player getVariable ["influence",0])+_this;
    player setVariable ["influence",_totalrep,true];
	_plusmin = "";
    if(_this > 0) then {
        _plusmin = "+";
    };
    format["%1%2 Influence",_plusmin,_this] call notify_minor;
};

influenceSilent = {
	if!(hasInterface) exitWith {};
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

OT_fnc_experience = {
	_who = _this select 0;
	_amount = _this select 1;
	if(isPlayer _who) then {
		[_amount] remoteExec ["experience",_who,false];
	}else{
		_xp = _who getVariable ["OT_xp",0];
		_who setVariable ["OT_xp",_xp + _amount,true];
	};
};

money = {
	if!(hasInterface) exitWith {};
    _amount = _this select 0;
    _rep = (player getVariable ["money",0])+_amount;
    if(_rep < 0) then {
        _rep = 0;
    };
    player setVariable ["money",_rep,true];
    playSound "3DEN_notificationDefault";
    _plusmin = "";
    if(_amount > 0) then {
        _plusmin = "+";
    };
	if(count _this > 1) then {
		format["%3: %1$%2",_plusmin,[_amount, 1, 0, true] call CBA_fnc_formatNumber,_this select 1] call notify_minor;
	}else{
		format["%1$%2",_plusmin,[_amount, 1, 0, true] call CBA_fnc_formatNumber] call notify_minor;
	};
};

stability = {
    _town = _this select 0;
	if !(_town in OT_allTowns) exitWith{};

    _townmrk = format["%1-abandon",_town];
    _stability = (server getVariable [format["stability%1",_town],0])+(_this select 1);
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
		if(_town in _abandoned) then {
        	_town setMarkerColor "ColorRed";
		}else{
			_town setMarkerColor "ColorYellow";
		};
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
    };
	if !(_town in _abandoned) then {
		_townmrk setMarkerAlpha 0;
		_townmrk setMarkerAlphaLocal 0;
	};
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

notify_big = {
    _txt = format ["<t size='0.7' color='#ffffff'>%1</t>",_this];
	OT_notifies pushback _txt;
};

notify_minor = {
    _txt = format ["<t size='0.5' color='#ffffff'>%1</t>",_this];
	OT_notifies pushback _txt;
};

notify_vehicle = {
	_txt = format["<t align='left' size='1.2' color='#ffffff'>%1</t><br/><t size='0.5' color='#bbbbbb' align='left'>Owner: %2</t>",(typeof vehicle player) call ISSE_Cfg_Vehicle_GetName,server getVariable "name"+((vehicle player) getVariable ["owner",""])];
    [_txt, -0.5, 1, 5, 1, 0, 5] spawn bis_fnc_dynamicText;
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
