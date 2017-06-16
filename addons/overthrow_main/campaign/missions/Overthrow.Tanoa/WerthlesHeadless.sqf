//WerthlesHeadless.sqf v2.3
//Part of Werthles' Headless Kit v2.3
//Split AI Groups Evenly Among Headless Clients

//private variables
private ["_recurrent", "_timeBetween", "_debug", "_advanced", "_startDelay", "_pause", "_report", "_moreBadNames", "_badNames", "_syncGroup", "_trigSyncs", "_waySyncs", "_objSyncs", "_objs", "_wayPoint", "_localCount", "_groupMoving", "_HCName", "_transfers", "_hintType", "_hintParams", "_lineString", "_breakString", "_debugString", "_hintParams1", "_hintParams2", "_stringInfo1", "_stringInfo2", "_stringInfo3", "_stringInfo4", "_strTransfers", "_strRecurrent", "_arb", "_debugging", "_check", "_hcColour", "_z", "_On", "_counts", "_HCgroups", "_null", "_recurrentCheck", "_ll", "_who", "_amount", "_gg", "_whom", "_inWHKHeadlessArray", "_headlessCount", "_unitsInGroup", "_size", "_lead", "_leadOwner", "_leadHeadless", "_WHKDummyWaypoint", "_moveToHC", "_bad", "_syncTrigArray", "_syncWayArray", "_wayNum", "_syncedTrigs", "_syncedWays", "_syncObjectsArray", "_syncObjects", "_nameOfSync", "_found", "_zz", "_HC", "_fewest", "_local", "_newSum", "_firstWaypoint", "_balanced", "_maxHC", "_minHC", "_diff", "_maxHCName", "_maxGroupCount", "_maxGroup"];

//Ignored Special Variables: _this, _x, _forEachIndex.
//script parameters
_recurrent = _this select 0; // run repeatedly
_timeBetween = _this select 1; // time between each check
_debug = _this select 2; // debug available for all or just admin
_advanced = _this select 3; // selects which AI distribution method to use
_startDelay = _this select 4; // how long to wait before running
_pause = _this select 5; // how long to wait between each setGroupOwner, longer aids syncing
_report = _this select 6; // turn setup report on or off
_moreBadNames = _this select 7; // check for units, groups, classes, vehicles or modules with these words in their name, then ignore the associated unit's group

//Check the script is run in multiplayer only
if (isMultiplayer) then
{
	WHKDEBUGHC = false;
	_badNames = ["ignore"] + _moreBadNames;

	//default to server only
	if (isServer and hasInterface) then
	{
		WHKDEBUGGER = player;
		publicVariable "WHKDEBUGGER";
	}
	else
	{
		if (serverCommandAvailable "#kick") then
		{
			WHKDEBUGGER = player;
			publicVariable "WHKDEBUGGER";
		};
	};

	//set up arrays
	WHKHeadlessArray = [];
	WHKHeadlessLocalCounts = [];
	WHKHeadlessNames = [];
	WHKHeadlessGroups = [];
	WHKHeadlessGroupOwners = [];
	
	WHKSyncArrays = compileFinal "
		_syncGroup = _this select 0;
		_trigSyncs = _this select 1;
		_waySyncs = _this select 2;
		_objSyncs = _this select 3;
		{
			_objs = _objSyncs select _forEachIndex;
			_x synchronizeObjectsAdd _objs;
		}forEach units _syncGroup;

		{
			_wayPoint = _x;
			{
				_x synchronizeTrigger [_wayPoint];
			}forEach (_trigSyncs select _forEachIndex);
			{
				_x synchronizeWaypoint [_wayPoint];
			}forEach (_waySyncs select _forEachIndex);
		}forEach waypoints _syncGroup;
	";

	//debug activating
	//[[1,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//debug deactivating
	//[[2,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//unit counts
	//[[3,[profileName,_localCount]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//initial report
	//[[4,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//next cycle
	//[[5,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//HC assignment
	//[[6,[_groupMoving,_HCName]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//setup report
	//[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	//cycle ended
	//[[8,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
	
	//debug hints for humans
	if (hasInterface) then
	{
		//Toggle debug action if admin/host
		WHKCondition = "";
		if not (_debug) then
		{
			WHKCondition = "serverCommandAvailable ""#kick""";
		};

		//debug hint function
		WHKDebugHint = compileFinal "
			_hintType = _this select 0;
			_hintParams = _this select 1;
			
			_lineString = parseText ""<t color='#C5C1AA' align='center'>-------------------------------------------------------</t>"";
			_breakString = parseText ""<br/>"";
			_debugString = parseText ""<t color='#C67171' align='center'>Debug Mode</t>"";
			
			hintArray = [_lineString,_breakString];
			
			switch (_hintType) do
			{
				case 1: {hintArray append [parseText ""<t color='#C67171' align='center'>Debug Mode Activating...</t>""];};
				case 2: {hintArray append [parseText ""<t color='#C67171' align='center'>Debug Mode Deactivating...</t>""];};
				case 3: {
					_hintParams1 = _hintParams select 0;
					_hintParams2 = _hintParams select 1;
					_stringInfo1 = ""<t color='#8E8E38' align='center'>"" + _hintParams1 + "": "" + ""</t>"";
					_stringInfo2 = ""<t color='#FFFACD' align='center'>"" + str _hintParams2 + ""</t>"";
					_stringInfo3 = ""<t color='#8E8E38' align='center'>"" + "" Local Units"" + ""</t>"";
					
					hintArray append [
						_debugString,
						_breakString,
						parseText _stringInfo1,
						parseText _stringInfo2,
						parseText _stringInfo3
					];
				};
				case 4: {hintArray append [parseText ""<t color='#7D9EC0' align='center'>Werthles Headless Script Is Now Running</t>""];};
				case 5: {
					hintArray append [
						_debugString,
						_breakString,
						parseText ""<t color='#7D9EC0' align='center'>Next Cycle Is Starting...</t>""
					];
				};
				case 6: {
					
					_hintParams1 = _hintParams select 0;
					_hintParams2 = _hintParams select 1;
					
					_stringInfo1 = ""<t color='#7D9EC0' align='center'>"" + ""Group: "" + ""</t>"";
					_stringInfo2 = ""<t color='#FFFACD' align='center'>"" + str _hintParams1 + ""</t>"";
					_stringInfo3 = ""<t color='#7D9EC0' align='center'>"" + ""Assigned To: "" + ""</t>"";
					_stringInfo4 = ""<t color='#FFFACD' align='center'>"" + str _hintParams2 + ""</t>"";
					
					hintArray append [
						_debugString,
						_breakString,
						parseText _stringInfo1,
						parseText _stringInfo2,
						_breakString,
						parseText _stringInfo3,
						parseText _stringInfo4
					];
				};
				case 7: {
					
					_hintParams1 = _hintParams select 0;
					_hintParams2 = _hintParams select 1;
					
					_strTransfers = ""<t color='#FFFACD' align='center'>"" + str _hintParams1 + ""</t>"";
					_strRecurrent = """";
					
					if (_hintParams2) then
					{
						_strRecurrent = ""<t color='#388E8E' align='center'>WHS Will Continue To Check For AI Units Throughout The Mission</t>"";
					}
					else
					{
						_strRecurrent = ""<t color='#8E388E' align='center'>WHS Will Now Terminate</t>"";
					};
					
					hintArray append [
						parseText ""<t color='#7D9EC0' align='center'>Werthles Headless Script</t>"",
						_breakString,
						parseText ""<t color='#7D9EC0' align='center'>Has Transferred</t>"",
						_breakString,
						parseText _strTransfers,
						_breakString,
						parseText ""<t color='#7D9EC0' align='center'>Units To Headless Clients</t>"",
						_breakString,
						_breakString,
						parseText _strRecurrent
					];
				};
				case 8: {
					hintArray append [
						_debugString,
						_breakString,
						parseText ""<t color='#7D9EC0' align='center'>Cycle Finished</t>""
					];
				};
			};
			
			hintArray append [_breakString,_lineString];
			hintSilent composeText hintArray;
		";
		
		WHKAction = player addAction ["<t color='#C67171'>Toggle WHK Debug",
		{
			if (WHKDEBUGGER == player) then
			{
				WHKDEBUGHC = !WHKDEBUGHC;
				publicVariable "WHKDEBUGHC";
			}
			else
			{
				WHKDEBUGGER = player;
				publicVariable "WHKDEBUGGER";
				WHKDEBUGHC = true;
				publicVariable "WHKDEBUGHC";
			};
			if (WHKDEBUGHC) then
			{
				[1,[]] call WHKDebugHint;
			}
			else
			{
				[2,[]] call WHKDebugHint;
			};
		},nil,-666,false,true,"",WHKCondition];
		_arb = player addEventHandler ["respawn",
		{
			(_this select 1) removeAction WHKAction;
			if (WHKDEBUGGER == (_this select 1)) then
			{
				WHKDEBUGGER = (_this select 0);
				publicVariable "WHKDEBUGGER";
			};
			if (isNull WHKDEBUGGER) then
			{
				WHKDEBUGGER = false;
				publicVariable "WHKDEBUGGER";
				WHKDEBUGHC = false;
				publicVariable "WHKDEBUGHC";
			};
			WHKAction = (_this select 0) addAction ["<t color='#C67171'>Toggle WHK Debug",
			{
			
				if (WHKDEBUGGER == player) then
				{
					WHKDEBUGHC = !WHKDEBUGHC;
					publicVariable "WHKDEBUGHC";
				}
				else
				{
					WHKDEBUGGER = player;
					publicVariable "WHKDEBUGGER";
					WHKDEBUGHC = true;
					publicVariable "WHKDEBUGHC";
				};
				if (WHKDEBUGHC) then
				{
					[1,[]] call WHKDebugHint;
				}
				else
				{
					[2,[]] call WHKDebugHint;
				};
			},nil,-666,false,true,"",WHKCondition];
		}];
		
		//draw icons if debug is activated for a player
		_debugging = [_debug] spawn {
			_check = true;
			
			//check if debug has been (de)activated
			while {true} do
			{
				if ((WHKDEBUGHC and _check and WHKDEBUGGER == player) and (serverCommandAvailable "#kick" or (_this select 0))) then
				{
					_check = false;
					
					["HCWHKDEBUGGER", "onEachFrame", {
						_hcColour = [];
						_z = 0;
						_On = "";
						{
							if (count units _x > 0 and ((getPos (units _x select 0)) distance [0,0,0])>100) then
							{
								if (count WHKHeadlessGroups == 0) then
								{
									_hcColour = [205/255,0/255,0/255,0.6];
									_On = "Awaiting HC Response";
								}
								else
								{
									_On = "";
									_z = WHKHeadlessGroups find _x;
									//if on player's machine
									if (local _x) then
									{
										if (isServer) then
										{
											_hcColour = [237/255,145/255,33/255,0.6];
											_On = "Server/Player's Group";
										}
										else
										{
											_hcColour = [113/255,198/255,113/255,0.6];
											_On = "Player/Player-Controlled Unit";
										};
									}
									else
									{
										//if not on HC
										if (_z == -1) then
										{
											_hcColour = [1,1,80/255,0.6];
											_On = "Not On HC";
										}
										else
										{
										
											//if on HC
											if (count WHKHeadlessGroupOwners > _z) then
											{
												_On = "On: " + str (WHKHeadlessGroupOwners select _z);
												_hcColour = [30/255,30/255,205/255,0.6];
											};
										};
									};
								};
								{
									//draw HC
									drawIcon3D ["\a3\ui_f\data\map\vehicleicons\iconvirtual_ca.paa", _hcColour, [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2], 1, 1, 0, _On, 0.5, 0.02, "EtelkaNarrowMediumPro", "center", true];
									
									//draw cross
									if (_z == -1) then
									{
										drawIcon3D ["\a3\ui_f\data\map\mapcontrol\taskiconfailed_ca.paa", [1,0,0,0.5], [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) + 2], 1, 1, 0];
									};
								}forEach units _x;
							};
						}forEach allGroups;

					},[]] call BIS_fnc_addStackedEventHandler;
				}
				else
				{
					if ((!(WHKDEBUGHC) or (!(serverCommandAvailable "#kick") and !(_this select 0)) or (WHKDEBUGGER != player)) and !_check) then
					{
						if (WHKDEBUGHC and (WHKDEBUGGER == player)) then
						{
							WHKDEBUGHC = false;
							publicVariable "WHKDEBUGHC";
						};
						_check = true;
						["HCWHKDEBUGGER", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
						[parseText "","hintSilent",WHKDEBUGGER,false] call BIS_fnc_MP;
					};
				};
				sleep 10;
			}; //while
		}; //spawn
	}; //if hasInterface

	if not (isServer or hasInterface) then
	{
		WHKSendInfo = compileFinal "
			sleep (random 1);
			_counts = {local _x} count allUnits;
			_HCgroups = [];
			{
				if (local _x) then
				{
					_HCgroups append [_x];
				};
			}forEach allGroups;
			[[player,_counts,_HCgroups],""WHKAddHeadless"",false,false] call bis_fnc_mp;
		";
	}
	else
	{
		WHKSendInfo = compileFinal "";
	};

	//displays number of units local to each client as a hint, if debug is on
	_null = [] spawn {
		while {true} do
		{
			//make sure hints are not always displayed together
			sleep (7 + random 7);
			if (WHKDEBUGHC) then
			{
				//count local units
				_localCount = {local _x} count allUnits;
				[[3,[profileName,_localCount]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
			};
		};
	};
	
	//Run only on server
	if (isServer) then
	{
		if (_report) then
		{
			//Inform WHKDEBUGGER WH is running
			[[4,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
		};
		
		_transfers = -1;
		_recurrentCheck = true;
		
		//Headless client incrementer
		if not (_advanced) then
		{
			_ll = -1;
		};
		
		//function to add id and counts to WHKHeadlessArray and WHKHeadlessLocalCounts
		WHKAddHeadless = compileFinal "
			_who = _this select 0;
			_amount = _this select 1;
			_HCgroups = _this select 2;
			
			WHKHeadlessGroups append _HCgroups;

			_gg = count _HCgroups;
			While {_gg >0} do
			{
				WHKHeadlessGroupOwners append [_who];
				_gg =_gg - 1;
			};
			
			_whom = owner _who;
			_inWHKHeadlessArray = WHKHeadlessArray find _whom;
			if (_inWHKHeadlessArray > -1) then
			{
				WHKHeadlessLocalCounts set [_inWHKHeadlessArray,_amount];
				WHKHeadlessNames set [_inWHKHeadlessArray,_who];
			}
			else
			{
				WHKHeadlessArray append [_whom];
				_inWHKHeadlessArray = WHKHeadlessArray find _whom;
				WHKHeadlessLocalCounts set [_inWHKHeadlessArray,_amount];
				WHKHeadlessNames set [_inWHKHeadlessArray,_who];
			};
		";
		
		//sleep for the length of the start delay
		sleep _startDelay;
				
		//if recurrent, repeat
		while {_recurrentCheck} do
		{
			//reset array
			WHKHeadlessArray = [];
			WHKHeadlessLocalCounts = [];
			WHKHeadlessGroups = [];
			WHKHeadlessGroupOwners = [];
			WHKHeadlessNames = [];
			
			//end if not recurrent
			if not (_recurrent) then
			{
				_recurrentCheck = false;
			};
			
			//causes WHKDEBUGGER to receive hints
			if (WHKDEBUGHC) then
			{
				[[5,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
			};
			
			//tell HCs to send info
			[0,"WHKSendInfo",true,false] call BIS_fnc_MP;
			
			//wait for replies
			sleep 5;
			
			//broadcast debug stuff
			if (WHKDEBUGHC) then
			{
				publicVariable "WHKHeadlessGroups";
				publicVariable "WHKHeadlessGroupOwners";
			};
			
			//Count the number of headless clients connected
			_headlessCount = count WHKHeadlessArray;
			
			//if there are headless clients connected, split AIs
			if (_headlessCount > 0) then
			{
				//clean up groups
				{
					//check if groups are empty
					_unitsInGroup = count units _x;
					if (_unitsInGroup == 0) then
					{
						deleteGroup _x;
					};
				}forEach allGroups;
				
				//loop all groups				
				{
					//get the group
					_groupMoving = _x;
					_size = count (units _groupMoving);
					_lead = leader _groupMoving;
					_leadOwner = owner _lead;
					_leadHeadless = WHKHeadlessArray find _leadOwner;
					
					//if group leader isn't a human and isn't controlled by a HC
					if (!(isPlayer _lead) and (_leadHeadless == -1) and (_size > 0)) then
					{
						//add dummy waypoint
						_WHKDummyWaypoint = _groupMoving addWaypoint [position _lead, 0.1, currentWaypoint _groupMoving, "WHKDummyWaypoint"];
						_WHKDummyWaypoint setWaypointTimeout [6,6,6];
						_WHKDummyWaypoint setWaypointCompletionRadius 100;
						
						sleep (_pause/3);
						
						_moveToHC = false;
						_bad = false;
						
						//Remember syncs from waypoints to other waypoints and triggers
						_syncTrigArray = [];
						_syncWayArray = [];
						{
							_wayNum = _forEachIndex;
							_syncedTrigs = synchronizedTriggers _x;
							_syncTrigArray set [_wayNum,_syncedTrigs];
							_syncedWays = synchronizedWaypoints _x;
							_syncWayArray set [_wayNum,_syncedWays];
						}forEach waypoints _groupMoving;

						//remember syncs to objects
						_syncObjectsArray = [];
						{
							_syncObjects = synchronizedObjects _x;
							_syncObjectsArray = _syncObjectsArray + [_syncObjects];
						}forEach units _groupMoving;
						
						//check for bad modules with ignore
						{
							{
								_nameOfSync = str _x;
								{
									_found = _nameOfSync find _x;
									if (_found>-1) then
									{
										_bad = true;
									};
								}forEach _badNames;
								_nameOfSync = typeOf _x;
								{
									_found = _nameOfSync find _x;
									if (_found>-1) then
									{
										_bad = true;
									};
								}forEach _badNames + ["SupportProvider"];
							}forEach _x;
						}forEach _syncObjectsArray;
						
						//check for units with ignore
						{
							_nameOfSync = str _x;
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames + ["BIS_SUPP_HQ_"];
						}forEach units _groupMoving;
						
						//check for unit type with ignore phrase
						{
							_nameOfSync = typeOf _x;
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;
						
						//check for unit vehicle type with ignore phrase
						{
							_nameOfSync = typeOf (vehicle _x);
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;
						
						//check for unit vehicle with ignore phrase
						{
							_nameOfSync = str (vehicle _x);
							{
								_found = _nameOfSync find _x;
								if (_found>-1) then
								{
									_bad = true;
								};
							}forEach _badNames;
						}forEach units _groupMoving;
						
						//check for groups with ignore
						_nameOfSync = str _x;
						{
							_found = _nameOfSync find _x;
							if (_found>-1) then
							{
								_bad = true;
							};
						}forEach _badNames;
						
						//move it to HC
						if not (_bad) then
						{
							_zz = 0;
							_HC = 0;
							_HCName = objNull;
							if (_advanced) then
							{
								//find the headless client with the fewest AIs
								_fewest = WHKHeadlessLocalCounts select 0;
								{
									//the total local units for the current HC
									if (_x < _fewest) then
									{
										_zz = _forEachIndex;
										_fewest = _x;
									};
								}forEach WHKHeadlessLocalCounts;
								
								//add group size to _local arrays
								_fewest = WHKHeadlessLocalCounts select _zz;
								_newSum = _fewest + _size;
								WHKHeadlessLocalCounts set [_zz,_newSum];
						
								//select the emptiest Headless Client
								_HC = WHKHeadlessArray select _zz;
								_HCName = WHKHeadlessNames select _zz;
							}
							else
							{
								//increment HC
								_ll = _ll + 1;
								if !(_ll < _headlessCount) then
								{
									_ll = 0;
								};
								
								//select a headless client
								_HC = WHKHeadlessArray select _ll;
								_HCName = WHKHeadlessNames select _ll;
								
								//update WHKHeadlessLocalCounts
								_newSum = WHKHeadlessLocalCounts select _ll;
								_newSum = _newSum + _size;
								WHKHeadlessLocalCounts set [_ll,_newSum];
							};
							
							//Move unit to 
							_moveToHC = _groupMoving setGroupOwner _HC;
							
							sleep (_pause/3);
							
							//reattach triggers and waypoints
							[[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray],"WHKSyncArrays",true,false] call BIS_fnc_MP;
							
							//broadcast debug stuff
							if (WHKDEBUGHC and _moveToHC) then
							{
								[0,"WHKSendInfo",true,false] call BIS_fnc_MP;
								[[6,[_groupMoving,_HCName]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
								publicVariable "WHKHeadlessGroups";
								publicVariable "WHKHeadlessGroupOwners";
							};
							
							sleep (_pause/3);
														
							//reattach triggers and waypoints
							[[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray],"WHKSyncArrays",true,false] call BIS_fnc_MP;
							
							sleep (_pause/3);
						};
							
							//_firstWaypoint = (waypoints _groupMoving) select 1;
							{
								if (waypointName _x == "WHKDummyWaypoint") then
								{
									deleteWaypoint _x;
								};
							}forEach waypoints _groupMoving;
					};
				}forEach allGroups;
				
				//show report only after the first cycle
				if (_transfers == -1 and _report) then
				{
					//count units moved to HCs
					_transfers = 0;
					{
						_transfers = _transfers + _x;
					}forEach WHKHeadlessLocalCounts;
					
					sleep 2;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					sleep 0.5;
					[[7,[_transfers,_recurrent]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
					//broadcast group locations
					publicVariable "WHKHeadlessGroups";
					publicVariable "WHKHeadlessGroupOwners";
					sleep 10;
				};
				
			};

			//rebalancing
			if (_advanced and _recurrent and (_headlessCount > 1)) then
			{
				_balanced = false;
				while {not _balanced} do
				{
					_maxHC = 0;
					{
						if ((WHKHeadlessLocalCounts select _maxHC) < (WHKHeadlessLocalCounts select _forEachIndex)) then
						{
							_maxHC = _forEachIndex;
						};
					}forEach WHKHeadlessLocalCounts;

					_minHC = 0;
					{
						if ((WHKHeadlessLocalCounts select _minHC) > (WHKHeadlessLocalCounts select _forEachIndex)) then
						{
							_minHC = _forEachIndex;
						};
					}forEach WHKHeadlessLocalCounts;

					_diff = ((WHKHeadlessLocalCounts select _maxHC) - (WHKHeadlessLocalCounts select _minHC));
					
					//if unbalanced, check for a group to move
					if (_diff > 1) then
					{
						//name of HC with the most units
						_maxHCName = str (WHKHeadlessNames select _maxHC);
						_maxGroupCount = 0;
						_maxGroup = 0;
						{
							If (str _x == _maxHCName) then
							{
								//count the units in the related group
								_z = (count units (WHKHeadlessGroups select _forEachIndex));
								
								//if not more than half the diff and the group biggest yet
								if ((_z <= (_diff/2)) and (_z  >_maxGroupCount)) then
								{
									_maxGroup = _forEachIndex;
									_maxGroupCount = _z;
								};
							};
						}forEach WHKHeadlessGroupOwners;

						//if no such group found, exit, else move the group
						if (_maxGroupCount == 0) then
						{
							_balanced = true;
						}
						else
						{
							//get the group
							_groupMoving = (WHKHeadlessGroups select _maxGroup);

							//add dummy waypoint
							_WHKDummyWaypoint = _groupMoving addWaypoint [position _lead, 0.1, currentWaypoint _groupMoving, "WHKDummyWaypoint"];
							_WHKDummyWaypoint setWaypointTimeout [6,6,6];
							_WHKDummyWaypoint setWaypointCompletionRadius 100;

							sleep (_pause/3);

							_moveToHC = false;
							_bad = false;

							//Remember syncs from waypoints to other waypoints and triggers
							_syncTrigArray = [];
							_syncWayArray = [];
							{
							_wayNum = _forEachIndex;
							_syncedTrigs = synchronizedTriggers _x;
							_syncTrigArray set [_wayNum,_syncedTrigs];
							_syncedWays = synchronizedWaypoints _x;
							_syncWayArray set [_wayNum,_syncedWays];
							}forEach waypoints _groupMoving;

							//remember syncs to objects
							_syncObjectsArray = [];
							{
							_syncObjects = synchronizedObjects _x;
							_syncObjectsArray = _syncObjectsArray + [_syncObjects];
							}forEach units _groupMoving;

							//relocate group
							_moveToHC = (WHKHeadlessGroups select _maxGroup) setGroupOwner (WHKHeadlessArray select _minHC);

							//reattach triggers and waypoints
							[[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray],"WHKSyncArrays",true,false] call BIS_fnc_MP;

							sleep (_pause/3);
							//reattach triggers and waypoints
							[[_groupMoving,_syncTrigArray,_syncWayArray,_syncObjectsArray],"WHKSyncArrays",true,false] call BIS_fnc_MP;

							//show debug
							if (WHKDEBUGHC and _moveToHC) then
							{
							[0,"WHKSendInfo",true,false] call BIS_fnc_MP;
							[[6,[_groupMoving,_HCName]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
							publicVariable "WHKHeadlessGroups";
							publicVariable "WHKHeadlessGroupOwners";
							};

							//update counts
							if (_moveToHC) then
							{
								WHKHeadlessLocalCounts set [_minHC,(WHKHeadlessLocalCounts select _minHC) + _maxGroupCount];
								WHKHeadlessLocalCounts set [_maxHC,(WHKHeadlessLocalCounts select _maxHC) - _maxGroupCount];
							};
							sleep (_pause/3);


							//_firstWaypoint = (waypoints _groupMoving) select 1;
							{
								if (waypointName _x == "WHKDummyWaypoint") then
								{
									deleteWaypoint _x;
								};
							}forEach waypoints _groupMoving;

							//delete moved group from array
							WHKHeadlessGroups set [_maxGroup,"DELETEELEMENT"];
							WHKHeadlessGroupOwners set [_maxGroup,"DELETEELEMENT"];
							WHKHeadlessGroups = WHKHeadlessGroups - ["DELETEELEMENT"];
							WHKHeadlessGroupOwners = WHKHeadlessGroupOwners - ["DELETEELEMENT"];
						};

					}
					else
					{
						_balanced = true;
					};

				};
			};
			
			//causes WHKDEBUGGER to receive hints
			if (WHKDEBUGHC) then
			{
				sleep 2;
				[0,"WHKSendInfo",true,false] call BIS_fnc_MP;
				[[8,[]],"WHKDebugHint",WHKDEBUGGER,false] call BIS_fnc_MP;
				sleep 5;
				//broadcast group locations
				publicVariable "WHKHeadlessGroups";
				publicVariable "WHKHeadlessGroupOwners";
			};
			
			//time between checks
			sleep _timeBetween;
		};
	};	
}
else
{
	//Inform players WH is not running
	hintSilent composeText [
		parseText "<t color='#C5C1AA' align='center'>-------------------------------------------------------</t>",
		parseText "<br/>",
		parseText "<t color='#7D9EC0' align='center'>Headless Clients Can Only Connect To Multiplayer Games, So Werthles Headless Script Has Terminated</t>",
		parseText "<br/>",
		parseText "<t color='#C5C1AA' align='center'>-------------------------------------------------------</t>"
	];
};