//This script will have the AI perform certain actions.
private ["_Unit", "_UnitGroup", "_CurrentAction", "_RandomAction", "_rnd", "_dist", "_dir", "_UnitPosition", "_positions", "_RandomAnimationList", "_ClosestUnit", "_positions2", "_Fire", "_Counter", "_SwitchMoveList", "_PlayActionList"];
_Unit = _this select 0;
_UnitGroup = _this select 1;


While {_Unit getvariable ["VCOM_LOITERING",true] && alive _Unit} do
{
	_CurrentAction = _Unit getvariable ["VCOM_LOITERINGACT",0];
	
	_RandomAction = ([1,2,3,4] - [_CurrentAction]) call BIS_fnc_selectrandom;
	switch (_RandomAction) do 
	{
			case 1: 
			{
				//Wander around and play random animation
				//Get random position
				_Unit setVariable ["VCOM_LOITERINGACT",1];
				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				_Unit doMove _positions;
				WaitUntil {(_Unit distance _positions) < 2};
				_RandomAnimationList = ["AmovPercMstpSnonWnonDnon_exercisePushup","SitDown","AmovPercMstpSnonWnonDnon_SaluteIn","AmovPercMstpSrasWrflDnon_AinvPknlMstpSlayWrflDnon"] call BIS_fnc_selectrandom;
				[_Unit,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
			};
			case 2: 
			{
				_Unit setVariable ["VCOM_LOITERINGACT",2];
				_ClosestUnit = [(_UnitGroup - [_Unit]),_Unit] call VCOMAI_ClosestObject;
				_ClosestUnit setVariable ["VCOM_LOITERINGACT",2];
				
				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				_positions2 = [(_positions select 0) + 5, (_positions select 1) + 5,_positions select 2];
				
				_Unit doMove _positions;
				_ClosestUnit doMove _positions2;
				
				WaitUntil {(_Unit distance _positions) < 2 && (_ClosestUnit distance _positions2) < 2};
				
				sleep 10;
				_Unit lookAt _ClosestUnit;
				_ClosestUnit lookAt _Unit;			
				sleep 5;
				
				
				
				[_Unit,"Acts_B_hub01_briefing"] remoteExec ["switchMoveEverywhere",0];
				sleep 2;
				[_ClosestUnit,"Acts_Kore_TalkingOverRadio_loop"] remoteExec ["switchMoveEverywhere",0];
				sleep 80;
				[_Unit,""] remoteExec ["switchMoveEverywhere",0];
				[_ClosestUnit,""] remoteExec ["switchMoveEverywhere",0];				
				
				
				
			};
			case 3:
			{
				_Unit setVariable ["VCOM_LOITERINGACT",3];
				_ClosestUnit = [(_UnitGroup - [_Unit]),_Unit] call VCOMAI_ClosestObject;
				_ClosestUnit setVariable ["VCOM_LOITERINGACT",3];
			
				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				

				_Unit doMove _positions;
				_ClosestUnit doMove _positions;
				
				WaitUntil {(_Unit distance _positions) < 5 && (_ClosestUnit distance _positions) < 5};
					
				_rnd = random 5;
				_dist = (_rnd + 3);
				_dir = random 360;
				_positions2 = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];					
				_ClosestUnit doMove _positions2;
				
				sleep 10;
				
				_Fire = "FirePlace_burning_F" createvehicle _positions2;
				_Fire spawn {sleep 120;deletevehicle _this;};
				
				sleep 2;
				_ClosestUnit lookAt _Fire;
				_Unit lookAt _Fire;
				
				_ClosestUnit spawn
				{
					_Counter = 0;
					While {_Counter < 11} do
					{
						sleep (random 2);
						_RandomAnimationList = ["AmovPercMstpSnonWnonDnon_exercisePushup","SitDown","AmovPercMstpSnonWnonDnon_SaluteIn"] call BIS_fnc_selectrandom;
						[_this,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
						_Counter = _Counter + 1;
						sleep 10;
					};
				};
				
				_Unit spawn
				{
					_Counter = 0;
					While {_Counter < 11} do
					{
						sleep (random 2);
						_RandomAnimationList = ["AmovPercMstpSnonWnonDnon_exercisePushup","SitDown","AmovPercMstpSnonWnonDnon_SaluteIn"] call BIS_fnc_selectrandom;
						[_this,_RandomAnimationList] remoteExec ["playMoveEverywhere",0];
						_Counter = _Counter + 1;
						sleep 12;
					};
				};				
				
								
								
				
			
			};
			case 4:
			{
				//Wander around and sitdown
				//Get random position
				_Unit setVariable ["VCOM_LOITERINGACT",4];
				_rnd = random 10;
				_dist = (_rnd + 5);
				_dir = random 360;
				_UnitPosition = getposworld _Unit;
				_positions = [(_UnitPosition select 0) + (sin _dir) * _dist, (_UnitPosition select 1) + (cos _dir) * _dist, 0];
				_Unit doMove _positions;
				WaitUntil {(_Unit distance _positions) < 2};
				sleep 2;
				[_Unit,"SitDown"] remoteExec ["playActionNowEverywhere",0];
				sleep 100;
				[_Unit,"walkf"] remoteExec ["playActionNowEverywhere",0];
				
			
			};
	};
		
				//_SwitchMoveList = ["Acts_Kore_TalkingOverRadio_loop","Acts_B_hub01_briefing"];
			//_PlayActionList = ["reloadMagazine"];
			//[player,"Acts_WarmUp_actions"] remoteExec ["switchMoveEverywhere",0];
			//[player,"AmovPercMstpSrasWrflDnon_AmovPercMevaSrasWrflDb"] remoteExec ["playMoveEverywhere",0];
			//[player,"Acts_ComingInSpeakingWalkingOut_2"] remoteExec ["playMoveEverywhere",0];
			//[player,"grabdrag"] remoteExec ["playActionNowEverywhere",0];
	
	
sleep 120;
};