if !(captive player) exitWith {"You cannot build while wanted" call OT_fnc_notifyMinor};
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



if ((!_isbase) && !(_closest in (server getVariable ["NATOabandoned",[]]))) exitWith {
	if(_isobj) then {
		format ["NATO does not allow construction this close to %1.",_closest] call OT_fnc_notifyMinor;
	}else{
		format ["NATO is currently not allowing any construction in %1",_closest] call OT_fnc_notifyMinor;
	};
};

if((player distance _center) > modeMax) exitWith {format ["You need to be within %1m of the %2.",modeMax,_buildlocation] call OT_fnc_notifyMinor};

openMap false;
_playerpos = (getpos player);

_campos = [(_playerpos select 0)+35,(_playerpos select 1)+35,(_playerpos select 2)+70];
_start = [position player select 0, position player select 1, 2];
buildcam = "camera" camCreate _start;

buildFocus = createVehicle ["Sign_Sphere10cm_F", [_start,1000,getDir player] call BIS_fnc_relPos, [], 0, "NONE"];
buildFocus setObjectTexture [0,"\overthrow_main\ui\clear.paa"];

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
	params ["_control","_relX","_relY"];
	modeValue = screenToWorld getMousePosition;
	modeValue = [modeValue select 0,modeValue select 1,0];
	if(!isNull modeTarget) then {
		modeTarget setPos modeValue;
		modeVisual setPos modeValue;
		modeVisual setVectorDirAndUp [[0,0,-1],[0,1,0]];
		modeTarget setVectorDirAndUp [[0,1,0],[0,1,0]];
		modeTarget setDir buildRotation;

		if(modeMode == 0) then {
			if(surfaceIsWater modeValue || (modeTarget distance modeCenter > modeMax) || ({!(_x isKindOf "Man") && (typeof _x != OT_flag_IND) && !(_x isEqualTo modeTarget) && !(_x isEqualTo modeVisual)} count(nearestObjects [modeTarget,[],10]) > 0)) then {
				if (canBuildHere) then {
					canBuildHere = false;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
				};
			}else{
				if !(canBuildHere) then {
					canBuildHere = true;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(0,1,0,0.5)'];
				};
			};
		}else{
			if(surfaceIsWater modeValue || (modeTarget distance modeCenter > modeMax)) then {
				if (canBuildHere) then {
					canBuildHere = false;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(1,0,0,0.5)'];
				};
			}else{
				if !(canBuildHere) then {
					canBuildHere = true;
					modeVisual setObjectTexture [0,'#(argb,8,8,3)color(0,1,0,0.5)'];
				};
			};
		};
	};
	if(buildCamRotating && buildCamMoving) exitWith {
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
	params ["_relX","_relY","_relZ"];

	private _pos = getpos buildcam;
	buildcam camSetPos [(_pos select 0)+_relX,(_pos select 1)-_relY,(_pos select 2)+_relZ];
	_pos = getpos buildFocus;
	buildFocus setPos [(_pos select 0)+_relX,(_pos select 1)-_relY,(_pos select 2)+_relZ];
	buildcam camSetTarget buildFocus;
	buildcam camCommit 0;
};

buildOnKeyUp = {
	params ["","_key"];
	if (_key isEqualTo 42 or _key isEqualTo 54) then {
		//Shift
		OT_shiftHeld = false;
	};
	if(_this select 2) then {
		buildCamRotating = false;
	};
};

OT_shiftHeld = false;

buildRotation = 0;

buildOnKeyDown = {
	params ["", "_key"];
	private _handled = false;
	if(_this select 2) then {
		buildCamRotating = true;
	};
	[_key] call {
		params ["_key"];
		if (_key isEqualTo 42 || _key isEqualTo 54) exitWith {
			//Shift
			OT_shiftHeld = true;
		};
		if (_key isEqualTo 17) exitWith {
			//W
			_handled = true;
			_rel = [[0,0,0],2,(getDir buildCam)+90] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};
		if (_key isEqualTo 31) exitWith {
			//S
			_handled = true;
			_rel = [[0,0,0],-2,(getDir buildCam)+90] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};
		if (_key isEqualTo 30) exitWith {
			//A
			_handled = true;
			_rel = [[0,0,0],-2,(getDir buildCam)] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};
		if (_key isEqualTo 32) exitWith {
			//D
			_handled = true;
			_rel = [[0,0,0],2,(getDir buildCam)] call BIS_fnc_relPos;
			_rel call buildMoveCam;
		};

		if(isNull modeTarget) exitWith {};
		_dir = buildRotation;

		if(_key isEqualTo 57 && modeMode isEqualTo 1) exitWith {
			//Space
			_handled = true;
			deleteVehicle modeTarget;
			modeIndex = modeIndex + 1;
			if(modeIndex > ((count modeValues)-1)) then {modeIndex = 0};

			_cls = modeValues select modeIndex;

			modeTarget = createVehicle [_cls, modeValue, [], 0, "CAN_COLLIDE"];
			modeTarget enableDynamicSimulation true;
			modeTarget setDir _dir;
		};
		_amt = 5;
		if (_key isEqualTo 16) exitWith {
			//Q
			_handled = true;
			_newdir = _dir - _amt;
			if(_newdir < 0) then {_newdir = 359};
			modeTarget setDir (_newdir);
			buildRotation = _newDir;
		};
		if (_key isEqualTo 18) exitWith {
			//E
			_handled = true;
			_newdir = _dir + _amt;
			if(_newdir > 359) then {_newdir = 0};
			modeTarget setDir (_newdir);
			buildRotation = _newDir;
		};
	};
	_handled
};

buildOnMouseDown = {
	params ["", "_btn"];
	if(_btn isEqualTo 1) then {
		buildCamMoving = true;
	};
};

buildOnMouseUp = {
	params ["", "_btn", "_sx"];
	if(_btn isEqualTo 1) then {
		buildCamMoving = false;
	};
	if(_btn isEqualTo 2) then {
		buildCamRotating = false;
	};
	if(_btn isEqualTo 0 && _sx > (safezoneX + (0.1 * safezoneW)) && _sx < (safezoneX + (0.9 * safezoneW))) then {
		//Click LMB
		if(!isNull modeTarget && canBuildHere) then {
			_money = player getVariable "money";
			if(_money < modePrice) then {
				"You cannot afford that" call OT_fnc_notifyMinor;
			}else{
				_created = objNULL;
				playSound "3DEN_notificationDefault";
				player setVariable ["money",_money-modePrice,true];
				if(modeMode isEqualTo 0) then {
					_objects = [modeValue,getDir modeTarget,modeValues] call BIS_fnc_objectsMapper;
					{
						clearWeaponCargoGlobal _x;
						clearMagazineCargoGlobal _x;
						clearBackpackCargoGlobal _x;
						clearItemCargoGlobal _x;
						[_x,getplayeruid player] call OT_fnc_setOwner;
						_x call OT_fnc_initObjectLocal;
					}foreach(_objects);
					_created = _objects select 0;
					deleteVehicle modeTarget;
				}else{
					_created = modeTarget;
					[modeTarget,getplayeruid player] call OT_fnc_setOwner;
					modeTarget = objNull;
				};

				if(modeCode != "") then {
					_created setVariable ["OT_init",modeCode,true];
					[_created,modeValue,modeCode] remoteExec ["OT_fnc_initBuilding",2];
				};
				_clu = createVehicle ["Land_ClutterCutter_large_F", (getpos modeTarget), [], 0, "CAN_COLLIDE"];
				_clu enableDynamicSimulation true;
			};
			deleteVehicle modeVisual;
			if(OT_shiftHeld) then {
				modeSelected call build;
			};
		};
		if(!canBuildHere) then {
			"You cannot build that there" call OT_fnc_notifyMinor;
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
		if((_x select 0) isEqualTo modeSelected) exitWith {_def = _x};
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
	modeVisual allowDamage false;
	modeTarget setMass 0;
	modeVisual setMass 0;
	modeTarget setDir buildRotation;
	modeTarget allowDamage false;

	[
		format [
			"<t size='1.1' color='#eeeeee'>%1</t><br/><t size='0.8' color='#bbbbbb'>$%2</t><br/><t size='0.4' color='#bbbbbb'>%3</t><br/><br/><t size='0.5' color='#bbbbbb'>Q,E = Rotate (Shift for smaller)<br/>Space = Change Type<br/>Left Click = Build It<br/>Right Click = Move Camera<br/>Mouse Wheel = Zoom<br/>Shift = Build multiple</t>",
			_name,
			[modePrice, 1, 0, true] call CBA_fnc_formatNumber,
			_description
		],
		[safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)],
		0.5,
		10,
		0,
		0,
		2
	] call OT_fnc_dynamicText;
};

createDialog format["OT_dialog_build%1",_buildlocation];

waitUntil {sleep 1;modeFinished || modeCancelled || !dialog};

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
