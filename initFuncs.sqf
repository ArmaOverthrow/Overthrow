
//Helper functions
getPublicVar = compileFinal preProcessFileLineNumbers "addons\scripts\getPublicVar.sqf";
townsInRegion = compileFinal preProcessFileLineNumbers "funcs\townsInRegion.sqf";
randomPosition = compileFinal preProcessFileLineNumbers "funcs\randomPosition.sqf";
spawnTemplate = compileFinal preProcessFileLineNumbers "funcs\spawnTemplate.sqf";
inSpawnDistance = compileFinal preProcessFileLineNumbers "funcs\inSpawnDistance.sqf";
nearestTown = compileFinal preProcessFileLineNumbers "funcs\nearestTown.sqf";
getPrice = compileFinal preProcessFileLineNumbers "funcs\getPrice.sqf";
canFit = compileFinal preProcessFileLineNumbers "funcs\canFit.sqf";
totalCarry = compileFinal preProcessFileLineNumbers "funcs\totalCarry.sqf";
unitStock = compileFinal preProcessFileLineNumbers "funcs\unitStock.sqf";

//AI spawn
spawnCiv = compileFinal preProcessFileLineNumbers "spawners\civ.sqf";
spawnGang = compileFinal preProcessFileLineNumbers "spawners\gang.sqf";

//AI init
initCivilian = compileFinal preProcessFileLineNumbers "initCivilian.sqf";
initPolice = compileFinal preProcessFileLineNumbers "initPolice.sqf";
initPolicePatrol = compileFinal preProcessFileLineNumbers "initPolicePatrol.sqf";
initCriminal = compileFinal preProcessFileLineNumbers "initCriminal.sqf";
initCrimLeader = compileFinal preProcessFileLineNumbers "initCrimLeader.sqf";
initShopLocal = compileFinal preProcessFileLineNumbers "initShopLocal.sqf";
initCarShopLocal = compileFinal preProcessFileLineNumbers "initCarShopLocal.sqf";
initGunDealerLocal = compileFinal preProcessFileLineNumbers "initGunDealerLocal.sqf";

//Economy agents
run_shop = compileFinal preProcessFileLineNumbers "economy\shop.sqf";

//Math
rotationMatrix = compileFinal preProcessFileLineNumbers "funcs\rotationMatrix.sqf";
matrixMultiply = compileFinal preProcessFileLineNumbers "funcs\matrixMultiply.sqf";
matrixRotate = compileFinal preProcessFileLineNumbers "funcs\matrixRotate.sqf";

//Actions
buy = compileFinal preProcessFileLineNumbers "actions\buy.sqf";
sell = compileFinal preProcessFileLineNumbers "actions\sell.sqf";
buyBuilding = compileFinal preProcessFileLineNumbers "actions\buyBuilding.sqf";
recruitCiv = compileFinal preProcessFileLineNumbers "actions\recruitCiv.sqf";
rearmGroup = compileFinal preProcessFileLineNumbers "actions\rearmGroup.sqf";
recruitSoldier = compileFinal preProcessFileLineNumbers "actions\recruitSoldier.sqf";
fastTravel = compileFinal preProcessFileLineNumbers "actions\fastTravel.sqf";
setHome = compileFinal preProcessFileLineNumbers "actions\setHome.sqf";
buyAmmobox = compileFinal preProcessFileLineNumbers "actions\buyAmmobox.sqf";
giveMoney = compileFinal preProcessFileLineNumbers "actions\giveMoney.sqf";

//Wanted System
wantedSystem = compileFinal preProcessFileLineNumbers "wantedSystem.sqf";

//Key handler
keyHandler = compileFinal preProcessFileLineNumbers "keyHandler.sqf";

KK_fnc_fileExists = {
    private ["_ctrl", "_fileExists"];
    disableSerialization;
    _ctrl = findDisplay 0 ctrlCreate ["RscHTML", -1];
    _ctrl htmlLoad _this;
    _fileExists = ctrlHTMLLoaded _ctrl;
    ctrlDelete _ctrl;
    _fileExists
};

notify = {
	_txt = format ["<t size='0.8' color='#ffffff'>%1</t>",_this]; 
	[_txt, 1, 0.5, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
};

notify_good = {
	playSound "3DEN_notificationDefault";
	_txt = format ["<t size='0.8' color='#ffffff'>%1</t>",_this]; 
	[_txt, 1, 0.1, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
};

notify_minor = {
	playSound "ClickSoft";
	_txt = format ["<t size='0.5' color='#ffffff'>%1</t>",_this]; 
	[_txt, 1, 0.5, 5, 0, 0, 2] spawn bis_fnc_dynamicText;
};

notify_talk = {
	_txt = format ["<t size='0.6' color='#dddddd'>%1</t>",_this];
	[_txt, -1, 1, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
};

AI_richGuy = compileFinal preProcessFileLineNumbers "AI\AI_richGuy.sqf";

[] execVM "funcs\info.sqf";

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
      _res = (((_rpx-_mpx)^2)/(_msx^2)) + (((_rpy-_mpy)^2)/(_msy^2));
      if ( _res < 1 ) then{ _ret=true; }else{ _ret=false; };
    };
    _ret;
  };