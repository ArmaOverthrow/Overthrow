if !(captive player) exitWith {"You cannot build while wanted" call notify_minor};
_base = (getpos player) call OT_fnc_nearestBase;
_closest = "";
_isbase = false;
_isobj = false;
_center = getpos player;
modeMax = 350;
_buildlocation = "base";
if !(isNil "_base") then {
	if((_base select 0) distance player < 120) then {
		_closest = _base select 1;
		_center = _base select 0;
		_isbase = true;
		modeMax = 100;
	};
};

if(!_isBase) then {
	_obj = (getpos player) call OT_fnc_nearestObjective;
	_objpos = _obj select 0;

	_town = (getpos player) call OT_fnc_nearestTown;
	_townpos = server getVariable _town;

	_closest = _town;
	_center = _townpos;
	if((_objpos distance player) < 250) then {
		_closest = _obj select 1;
		_isobj = true;
		_center = _objpos;
		_buildlocation = "objective";
		modeMax = 250;
	}else{
		_buildlocation = "town";
		if(_town in OT_capitals) then {
			modeMax = 750;
		};
	};
};



if ((!_isbase) and !(_closest in (server getVariable ["NATOabandoned",[]]))) exitWith {
	if(_isobj) then {
		format ["NATO does not allow construction this close to %1.",_closest] call notify_minor;
	}else{
		format ["NATO is currently not allowing any construction in %1",_closest] call notify_minor;
	};
};

if((player distance _center) > modeMax) exitWith {format ["You need to be within %1m of the %2.",modeMax,_buildlocation] call notify_minor};

openMap false;
_playerpos = (getpos player);

_campos = [(_playerpos select 0)+35,(_playerpos select 1)+35,(_playerpos select 2)+70];
_start = [position player select 0, position player select 1, 2];
buildcam = "camera" camCreate _start;

buildFocus = createVehicle ["Sign_Sphere10cm_F", [_start,1000,getDir player] call BIS_fnc_relPos, [], 0, "NONE"];
buildFocus setObjectTexture [0,"\ot\ui\clear.paa"];

buildcam camSetTarget buildFocus;
buildcam cameraEffect ["internal", "BACK"];
buildcam camCommit 0;

showCinemaBorder false;
waitUntil {camCommitted buildcam};

if(currentVisionMode player > 0) then {
	camUseNVG true;
};

buildFocus setPos _playerpos;
buildcam camSetTarget buildFocus;
buildcam camSetPos _campos;
buildcam camCommit 2;
waitUntil {camCommitted buildcam};

modeFinished = false;
modeCancelled = false;

cancelBuild = {
	modeCancelled = true;
};
modeValue = [0,0,0];

buildCamMoving = false;
buildCamRotating = false;
canBuildHere = false;

modeCenter = _center;

buildOnMouseMove = {
	_relX = _this select 1;
	_relY = _this select 2;
	modeValue = screenToWorld getMousePosition;
	modeValue = [modeValue select 0,modeValue select 1,0];
	if(!isNull modeTarget) then {
		modeTarget setPos modeValue;
		modeVisual setPos modeValue;
		modeVisual setVectorDirAndUp [[0,0,-1],[0,1,0]];

		if(modeMode == 0) then {
			if(surfaceIsWater modeValue or (modeTarget distance modeCenter > modeMax) or ({!(_x isKindOf "Man") and (typeof _x != OT_item_Flag) and !(_x == modeTarget) and !(_x == modeVisual)} count(nearestObjects [modeTarget,[],10]) > 0)) then {
				if (canBuildHere) then {
					canBuildHere = false;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
				}
			}else{
				if !(canBuildHere) then {
					canBuildHere = true;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(0,1,0,0.5)'];
				}
			};
		}else{
			if(surfaceIsWater modeValue or (modeTarget distance modeCenter > modeMax)) then {
				if (canBuildHere) then {
					canBuildHere = false;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
				}
			}else{
				if !(canBuildHere) then {
					canBuildHere = true;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(0,1,0,0.5)'];
				}
			};
		};
	};
	if(buildCamRotating and buildCamMoving) exitWith {
		_pos = getpos buildcam;
		buildcam camSetPos [(_pos select 0)+_relX,(_pos select 1)+_relY,(_pos select 2)];
		buildcam camSetTarget buildFocus;
		buildcam camCommit 0;
	};
	if(buildCamMoving) exitWith {
		_pos = getpos buildcam;
		buildcam camSetPos [(_pos select 0)+_relX,(_pos select 1)-_relY,(_pos select 2)];
		_pos = getpos buildFocus;
		buildFocus setPos [(_pos select 0)+_relX,(_pos select 1)-_relY,_pos select 2];
		buildcam camSetTarget buildFocus;
		buildcam camCommit 0;
	};

};

buildMoveCam = {
	_relX = _this select 0;
	_relY = _this select 1;
	_relZ = _this select 2;

	_pos = getpos buildcam;
	buildcam camSetPos [(_pos select 0)+_relX,(_pos select 1)-_relY,(_pos select 2)+_relZ];
	_pos = getpos buildFocus;
	buildFocus setPos [(_pos select 0)+_relX,(_pos select 1)-_relY,(_pos select 2)+_relZ];
	buildcam camSetTarget buildFocus;
	buildcam camCommit 0;
};

buildOnKeyUp = {
	if(_this select 2) then {
		buildCamRotating = false;
	};
};

buildOnKeyDown = {
	_key = _this select 1;
	_handled = false;
	if(_this select 2) then {
		buildCamRotating = true;
	};
	call {
		if (_key == 17) exitWith {
			//W
			_handled = true;
			_rel = [[0,0,0],2,(getDir buildCam)+90] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};
		if (_key == 31) exitWith {
			//S
			_handled = true;
			_rel = [[0,0,0],-2,(getDir buildCam)+90] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};
		if (_key == 30) exitWith {
			//A
			_handled = true;
			_rel = [[0,0,0],-2,(getDir buildCam)] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};
		if (_key == 32) exitWith {
			//D
			_handled = true;
			_rel = [[0,0,0],2,(getDir buildCam)] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};

		if(isNull modeTarget) exitWith {};
		_dir = getDir modeTarget;

		if(_key == 57 and modeMode == 1) exitWith {
			//Space
			_handled = true;
			deleteVehicle modeTarget;
			modeIndex = modeIndex + 1;
			if(modeIndex > ((count modeValues)-1)) then {modeIndex = 0};

			_cls = modeValues select modeIndex;

			modeTarget = createVehicle [_cls, modeValue, [], 0, "CAN_COLLIDE"];
			modeTarget enableDynamicSimulation true;
			modeTarget remoteExec ["enableSimulationGlobal false",2,false];
			modeTarget setDir _dir;
		};
		_amt = 5;
		if(_this select 2) then {
			_amt = 1;
		};
		if (_key == 16) exitWith {
			//Q
			_handled = true;
			_newdir = _dir - _amt;
			if(_newdir < 0) then {_newdir = 359};
			modeTarget setDir (_newdir);
		};
		if (_key == 18) exitWith {
			//E
			_handled = true;
			_newdir = _dir + _amt;
			if(_newdir > 359) then {_newdir = 0};
			modeTarget setDir (_newdir);
		};
	};
	_handled
};

buildOnMouseDown = {
	_btn = _this select 1;
	if(_btn == 1) then {
		buildCamMoving = true;
	};
};

buildOnMouseUp = {
	_btn = _this select 1;
	_sx = _this select 2;
	if(_btn == 1) then {
		buildCamMoving = false;
	};
	if(_btn == 2) then {
		buildCamRotating = false;
	};
	if(_btn == 0 and _sx > (safezoneX + (0.1 * safezoneW)) and _sx < (safezoneX + (0.9 * safezoneW))) then {
		//Click LMB
		if(!isNull modeTarget and canBuildHere) then {
			_money = player getVariable "money";
			if(_money < modePrice) then {
				"You cannot afford that" call notify_minor;
			}else{
				_created = objNULL;
				playSound "3DEN_notificationDefault";
				player setVariable ["money",_money-modePrice,true];
				if(modeMode == 0) then {
					_objects = [modeValue,getDir modeTarget,modeValues] call BIS_fnc_objectsMapper;
					{
						clearWeaponCargoGlobal _x;
						clearMagazineCargoGlobal _x;
						clearBackpackCargoGlobal _x;
						clearItemCargoGlobal _x;
						_x setVariable ["owner",getplayeruid player,true];
						_x call initObjectLocal;
					}foreach(_objects);
					_created = _objects select 0;
					deleteVehicle modeTarget;
				}else{
					_created = modeTarget;
					modeTarget setVariable ["owner",getplayeruid player,true];
					modeTarget enableSimulationGlobal true;
					modeTarget = objNull;
				};

				if(modeCode != "") then {
					_created setVariable ["OT_init",modeCode,true];
					[modeValue,modeCode] remoteExec ["structureInit",2];
				};
				_clu = createVehicle ["Land_ClutterCutter_large_F", (getpos modeTarget), [], 0, "CAN_COLLIDE"];
				_clu enableDynamicSimulation true;
			};
			deleteVehicle modeVisual;

		};
		if(!isNull modeTarget and !canBuildHere) then {
			"You cannot build that there" call notify_minor;
		};
	};
};

buildOnMouseWheel = {
	_z = _this select 1;
	_pos = position buildcam;

	if(_z < 0) then {
		if((_pos select 2) < 30) exitWith {
			buildcam camSetPos [(_pos select 0),(_pos select 1),(_pos select 2)+5];
		};
		if((_pos select 2) < 200) exitWith {
			buildcam camSetPos [(_pos select 0),(_pos select 1),(_pos select 2)+20];
		};
	}else{
		if((_pos select 2) > 30) exitWith {
			buildcam camSetPos [(_pos select 0),(_pos select 1),(_pos select 2)-20];
		};
		if((_pos select 2) > 10) exitWith {
			buildcam camSetPos [(_pos select 0),(_pos select 1),(_pos select 2)-5];
		};
	};
	buildcam camSetTarget buildFocus;
	buildCam camCommit 0.1;
};

modeTarget = objNull;
modeValues = [];
modeMode = 0;
modePrice = 0;
modeSelected = "";
modeVisual = objNull;
modeIndex = 0;
modeCode = "";

build = {
	canBuildHere = false;
	modeSelected = _this;
	_def = [];
	{
		if((_x select 0) == modeSelected) exitWith {_def = _x};
	}foreach(OT_Buildables);
	modeIndex = 0;
	_name = _def select 0;
	_description = _def select 5;
	modeCode = _def select 3;
	modeValues = _def select 2;
	modePrice = _def select 1;
	_isTemplate = _def select 4;
	_buildcls = "";
	if(_isTemplate) then {
		modeMode = 0;
		_buildcls = (modeValues select 0) select 0;
	}else{
		modeMode = 1;
		_buildcls = modeValues select modeIndex;
	};

	if(!isNull modeTarget) then {
		deleteVehicle modeTarget;
		deleteVehicle modeVisual;
	};
	modeTarget = createVehicle [_buildcls,modeValue,[],0,"CAN_COLLIDE"];
	modeVisual = createVehicle ["Sign_Circle_F",modeValue,[],0,"CAN_COLLIDE"];
	{
		modeTarget disableCollisionWith _x;
		modeVisual disableCollisionWith _x;
	}foreach(vehicles + allUnits);

	modeVisual setVectorDirAndUp [[0,0,-1],[0,1,0]];
	modeVisual setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
	modeTarget remoteExec ["enableSimulationGlobal false",2];
	modeTarget enableSimulation false;
	modeVisual allowDamage false;
	modeTarget setMass 0;
	modeVisual setMass 0;
	modeTarget setDir (getDir buildCam);
	modeTarget allowDamage false;

	_txt = format ["<t size='1.1' color='#eeeeee'>%1</t><br/><t size='0.8' color='#bbbbbb'>$%2</t><br/><t size='0.4' color='#bbbbbb'>%3</t><br/><br/><t size='0.5' color='#bbbbbb'>Q,E = Rotate (Shift for smaller)<br/>Space = Change Type<br/>Left Click = Build It<br/>Right Click = Move Camera<br/>Mouse Wheel = Zoom</t>",_name,[modePrice, 1, 0, true] call CBA_fnc_formatNumber,_description];
	[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
};

createDialog format["OT_dialog_build%1",_buildlocation];

waitUntil {sleep 1;modeFinished or modeCancelled or !dialog};

if(!isNull modeTarget) then {
	deleteVehicle modeTarget;
	deleteVehicle modeVisual;
};

deleteVehicle buildFocus;

closeDialog 0;
buildcam cameraEffect ["Terminate", "BACK" ];
buildcam = nil;

modeTarget = nil;
modeCancelled = nil;
modeFinished = nil;
modeValue = nil;
modeValues = nil;
modeSelected = nil;
modeMode = nil;
modeCode = nil;
