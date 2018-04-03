//Execute Example
//
//[BOB,"Guard: Please stand back",15,50] remoteExec ["3DText",0];
//
private ["_Message","_Unit","_WaitTime","_Display","_Distance"];

_Unit = _this select 0;
_objNetId = _Unit call BIS_fnc_netId;
_Message = _this select 1;
_WaitTime = _this select 2;
_Distance = _this select 3;
_Random = (random 2);

call compile format ["_Display = addMissionEventHandler ['Draw3D',{
		
		_Object = (objectFromNetId '%1');
		_Location = _Object modelToWorld [0,0,0];
		_Random = (parsenumber '%4');
		if (player distance _Object < (parsenumber '%3')) then 
		{
			drawIcon3D ['', [1,1,1,1], [_Location select 0,_Location select 1,((_Location select 2) +(0.5 + _Random))], 0, 0, 0, '%2', 2,0.04];
		};


	}

];",_objNetId,_Message,_Distance,_Random];
 
sleep _WaitTime;

if (isNil "_Display") exitwith {};
removeMissionEventHandler ["Draw3D", _Display];

_Display
