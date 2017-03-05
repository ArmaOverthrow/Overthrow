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
OT_fnc_mapInfoDialog = compileFinal preprocessFileLineNumbers "actions\townInfo.sqf";
OT_fnc_showMemberInfo = compileFinal preprocessFileLineNumbers "UI\actions\fn_showMemberInfo.sqf";
OT_fnc_showBusinessInfo = compileFinal preprocessFileLineNumbers "UI\actions\fn_showBusinessInfo.sqf";
OT_fnc_factoryDialog = compileFinal preProcessFileLineNumbers "UI\fn_factoryDialog.sqf";
OT_fnc_vehicleDialog = compileFinal preProcessFileLineNumbers "UI\fn_vehicleDialog.sqf";
OT_fnc_factoryRefresh = compileFinal preProcessFileLineNumbers "UI\actions\fn_factoryRefresh.sqf";
OT_fnc_factorySet = compileFinal preProcessFileLineNumbers "UI\actions\fn_factorySet.sqf";
OT_fnc_newGameDialog = compileFinal preProcessFileLineNumbers "UI\fn_newGameDialog.sqf";

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

//Other Systems
perkSystem = compileFinal preProcessFileLineNumbers "perkSystem.sqf";
statsSystem = compileFinal preProcessFileLineNumbers "stats.sqf";
intelSystem = compileFinal preProcessFileLineNumbers "intelSystem.sqf";

//Key handler
keyHandler = compileFinal preProcessFileLineNumbers "keyHandler.sqf";
menuHandler = {};

fnc_getBuildID = compileFinal preProcessFileLineNumbers "funcs\fnc_getBuildID.sqf";

OT_fnc_getTaxIncome = {
	private _total = 0;
	private _inf = 0;
	{
		private _town = _x;
		_total = _total + 250;
		if(_town in OT_allAirports) then {
			_total = _total + ((server getVariable ["stabilityTanoa",100]) * 2); //Tourism income
		};
		_inf = _inf + 1;
		if(_town in OT_allTowns) then {
			private _population = server getVariable format["population%1",_town];
			private _stability = server getVariable format["stability%1",_town];
			private _garrison = server getVariable [format['police%1',_town],0];
			private _add = round(_population * (_stability/100));
			if(_stability > 49) then {
				_add = round(_add * 4);
			};
			if(_garrison == 0) then {
				_add = round(_add * 0.5);
			};
			_total = _total + _add;
		};
	}foreach(server getVariable ["NATOabandoned",[]]);
	[_total,_inf];
};

OT_fnc_getOfflinePlayerAttribute = {
	params ["_uid","_attr"];
	private _val = "";
	{
		_x params ["_k","_v"];
		if(_k == _attr) exitWith {_val=_v};
	}foreach(server getVariable [_uid,[]]);
	_val;
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
	private _baseprice = 600000;
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
		format["%1 (%2 Standing)",_this select 2,_this select 1] call notify_minor;
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
    format["%1$%2",_plusmin,[_amount, 1, 0, true] call CBA_fnc_formatNumber] call notify_minor;

};

stability = {
    _town = _this select 0;

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

notify_long = {
    _txt = format ["<t size='0.5' color='#ffffff'>%1</t>",_this];
    [_txt, 0, -0.136, 30, 1, 0, 2] spawn bis_fnc_dynamicText;
};

notify_talk = {
    _txt = format ["<t size='0.5' color='#dddddd'>%1</t>",_this];
	OT_notifies pushback _txt;
};

[] execVM "funcs\info.sqf";
