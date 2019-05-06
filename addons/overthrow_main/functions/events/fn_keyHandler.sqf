private _handled = false;

if(!dialog) then {
	if(count (player nearObjects [OT_workshopBuilding,10]) > 0) then {
		[] call OT_fnc_workshopDialog;
	}else{
		if((vehicle player) != player && count (player nearObjects [OT_portBuilding,30]) > 0) then {
			createDialog "OT_dialog_vehicleport";
			private _ft = server getVariable ["OT_fastTravelType",1];
			if(!OT_adminMode && _ft > 1) then {
				ctrlEnable [1600,false];
			};
		}else{
			if (player getVariable ["OT_tute_trigger",false]) then {
				player setVariable ["OT_tute_trigger",false,true];
				[] spawn {
					hint format["Take some time to explore the main menu, when you're finished open the map (%1 key)","ShowMap" call OT_fnc_getAssignedKey];

					private _acekey = "Left Windows (default)";
					private _acebind = ["ACE3 Common","ace_interact_menu_InteractKey"] call CBA_fnc_getKeybind;
					if(count _acebind > 0) then {
						_acekey = (cba_keybinding_keynames) getVariable [str ((_acebind select 5) select 0),_acekey];
					};

					sleep 3;
					[
						format [
							"<t align='center'><t size='0.6' color='#ffffff'>Main Menu</t><br/><br/>
							<t size='0.5' color='#ffffff'>From here you can perform basic actions such as recruiting civilians or fast travelling to buildings you own, friendly bases and camps that you place. As you can see on the bottom right, this shack is owned by you, so you can therefore fast travel back here when you need to, but not while wanted.<br/><br/>
							To continue, close this menu (Esc) and open the map (%1 key)</t>",
							"ShowMap" call OT_fnc_getAssignedKey
						], 0, 0.2, 120, 1, 0, 2] call OT_fnc_dynamicText;

					waitUntil {uisleep 1; visibleMap};

					hint format[
						"Holding RMB will pan the map, zoom with the scrollwheel. When you are finished exploring the map, close it with the Esc key.",
						"Action" call OT_fnc_getAssignedKey
					];
					sleep 3;
					[format [
						"<t align='left'><t size='0.7' color='#000000'>Stability</t><br/>
						<t size='0.6' color='#000000'>Yellow areas indicate towns where stability is lowest.Blue icons indicate known NATO installations.</t><br/><br/>
						<t size='0.5' color='#101010'>%3</t>",
						OT_tutorial_backstoryText
					], -0.5, 0.5, 240, 1, 0, 2] call OT_fnc_dynamicText;

					waitUntil {uisleep 1; !visibleMap};
					hint "";
					sleep 3;

					[format [
						"<t align='center'><t size='0.6' color='#ffffff'>Interaction</t><br/>
						<t size='0.5' color='#ffffff'>Some objects, including most of the ones in your shack, have actions that you can perform on them directly. Try it out by moving towards the ammo crate and using your Interact key (%1). Move the mouse over 'Open' and then release the key to perform that action.</t><br/><br/>",
						_acekey
					], 0, 0.2, 20, 1, 0, 2] call OT_fnc_dynamicText;

					sleep 20;
					_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
					[player,getpos _gundealer,"Gun Dealer"] call OT_fnc_givePlayerWaypoint;
					sleep 3;
					hint "Go and speak to the local gun dealer. Head towards the marked location, you have nothing to worry about as long as you are not carrying/wearing any illegal items.";

					waitUntil {uisleep 1; (player distance2d getPosASL _gundealer) < 5};


					_lines = [
						"Hello? Do I know you?",
						format ["No you don't. My name is %1 and I heard that you might be able to help me",name player],
						"Oh, really? Well that depends. With what?"
					];

					_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
					_done = {
						_options = [
							[
								"I am sick of NATO pushing us around, what can I do about it?",
								{
									_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
									[
										player,
										_gundealer,
										[
											(_this select 0),
											"I hear you. I bet it was even them who shot the protester... I tell you what, take this spare pistol I have laying around.",
											"What am I supposed to do with this?",
											"I don't know. But every other guy that's come in here recently that was angry with NATO wanted a gun, and I won't ask questions.",
											"Um.. thanks I guess",
											"No problem, anything you can do to help me stay under their radar is great, I'll pay you $250 if you can take care of them."
										],
										{
											hint format[
												"The gun is in your pocket, you can equip it in your inventory (%1 key) by dragging it to your hands. But be careful, if NATO sees any weapons they will open fire on you, so best to keep it where it is until you uh... 'need' it",
												"Gear" call OT_fnc_getAssignedKey
											];
											[{
												playSound "3DEN_notificationDefault";
												[] call (OT_tutorialMissions select 0);
												hint "You have completed the tutorial. Good luck on your future journey!";
												player setVariable ["OT_tute_inProgress", false];
											},0,10] call CBA_fnc_waitAndExecute;
										}
									] call OT_fnc_doConversation;
									player addItemToUniform OT_item_BasicGun;
									player addItemToUniform OT_item_BasicAmmo;
									player addItemToUniform OT_item_BasicAmmo;
									player addItemToUniform OT_item_BasicAmmo;
								}
							],
							[
								format ["There's too much crime in %1, and NATO isn't doing anything about it",OT_nation],
								{
									_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
									[
										player,
										_gundealer,
										[
											(_this select 0),
											"I agree. I bet it was even them who shot the protester, they would much rather keep this nation in turmoil...",
											"I know, right",
											"I tell you what, take this spare pistol I have laying around.",
											"What am I supposed to do with this?",
											format[
												"Local businessmen are always setting bounties on the gangs around %1, go and claim a few!",
												OT_nation
											],
											"Alright.. thanks",
											"No problem, just come back if you need more ammunition or anything else the stores won't sell you."
										],
										{
											hint format[
												"The gun is in your pocket, you can equip it in your inventory (%1 key) by dragging it to your hands. But be careful, if NATO sees any weapons they will open fire on you.",
												"Gear" call OT_fnc_getAssignedKey
											];
											[{
												playSound "3DEN_notificationDefault";
												[] call (OT_tutorialMissions select 1);
												hint "You have completed the tutorial. Good luck on your future journey!";
												player setVariable ["OT_tute_inProgress", false];
											},1,10] call CBA_fnc_waitAndExecute;
										}
									] call OT_fnc_doConversation;
									player addItemToUniform OT_item_BasicGun;
									player addItemToUniform OT_item_BasicAmmo;
									player addItemToUniform OT_item_BasicAmmo;
									player addItemToUniform OT_item_BasicAmmo;
								}
							],
							[
								"I want to make some cash, and I don't care about breaking the law",
								{
									_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
									[
										player,
										_gundealer,
										[
											(_this select 0),
											"Probably a good idea with everything that's happening. I tell you what, take this spare bud I have laying around.",
											"What am I supposed to do with this?",
											"Sell it to some of the civilians round here, maybe it will calm them down",
											"Um.. thanks I guess",
											"No problem, just come back if you need more, or anything else the stores won't sell you."
										],
										{
											hint format[
												"The drugs are in your pocket, you can see it in your inventory (%1 key).",
												"Gear" call OT_fnc_getAssignedKey
											];
											[{
												playSound "3DEN_notificationDefault";
												[] call (OT_tutorialMissions select 2);
												hint "You have completed the tutorial. Good luck on your future journey!";
												player setVariable ["OT_tute_inProgress", false];
											},2,10] call CBA_fnc_waitAndExecute;
										}
									] call OT_fnc_doConversation;
									player addItemToUniform "OT_Ganja";
								}
							],
							[
								"I want to make some cash, legally",
								{
									_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
									[
										player,
										_gundealer,
										[
											(_this select 0),
											"Well I'm not really the guy to help you there, but there are usually some wrecked vehicles around town, maybe you can salvage some useful resources from them?",
											"OK, thanks.",
											"No problem! See you around."
										],
										{
											hint format["Wrecked vehicles can be salvaged with a toolkit, there should be one in your ammo crate at home. Shops on your map are marked with a circle and icon representing what they buy/sell. Towns with lower stability and population will pay higher prices for all items.",
												"Gear" call OT_fnc_getAssignedKey
											];
											[{
												playSound "3DEN_notificationDefault";
												[] call (OT_tutorialMissions select 3);
												hint "You have completed the tutorial. Good luck on your future journey!";
												player setVariable ["OT_tute_inProgress", false];
											},3,10] call CBA_fnc_waitAndExecute;
										}
									] call OT_fnc_doConversation;

								}
							]
						];

						_options call OT_fnc_playerDecision;
					};
					[_gundealer,player,_lines,_done] call OT_fnc_doConversation;
				};
			};
			if(hcShownBar && count (hcSelected player) > 0) exitWith {
				createDialog "OT_dialog_squad";
			};
			if(!hcShownBar && ({!isplayer _x} count (groupSelectedUnits player) > 0)) exitWith {
				{
					if(isPlayer _x) then {
						player groupSelectUnit [_x,false];
					};
				}foreach(groupSelectedUnits player);
				createDialog "OT_dialog_command";
			};
			if(vehicle player != player) exitWith {
				private _ferry = player getVariable ["OT_ferryDestination",[]];
				if(count _ferry isEqualTo 3) exitWith {
					_veh = vehicle player;

					disableUserInput true;
					_town = _ferry call OT_fnc_nearestTown;

					private _cost = player getVariable ["OT_ferryCost",0];
					if((player getVariable ["money",0]) < _cost) exitWith {
						"You cannot afford that!" call OT_fnc_notifyMinor;
						disableUserInput false;
					};
					[-_cost] call OT_fnc_money;
					cutText [format["Skipping ferry to %1",_town],"BLACK",2];
					player setVariable ["OT_ferryDestination",[],false];
					[_ferry,_veh] spawn {
						params ["_pos","_veh"];
						sleep 2;
						private _driver = driver _veh;
						private _e = [];
						{
							private _p = [_pos,[0,50]] call SHK_pos_fnc_pos;
							moveOut _x;
							_x allowDamage false;
							_x setPos _p;
							_e pushback _x;
						} foreach(crew vehicle player);
						sleep 2;
						disableUserInput false;
						cutText ["","BLACK IN",3];
						deleteVehicle _driver;
						deleteVehicle _veh;
						{
							_x allowDamage true;
						}foreach(_e);
					};
				};
				call {
					if(driver vehicle player != player) exitWith {
						[] spawn OT_fnc_mainMenu;
					};
					if(call OT_fnc_playerIsAtWarehouse) exitWith {
						createDialog "OT_dialog_vehiclewarehouse";
					};
					if(call OT_fnc_playerIsAtHardwareStore) exitWith {
						createDialog "OT_dialog_vehiclehardware";
					};
					createDialog "OT_dialog_vehicle";
					[] spawn OT_fnc_vehicleDialog;
				};
			};

			private _cTarget = cursorTarget;
			if((_cTarget isKindOf "CAManBase") && (alive _cTarget) && (!isplayer _cTarget) && !(side _cTarget isEqualTo west) && (_cTarget distance player) < 10) exitWith {
				if((!(player getVariable ["OT_tute",true]) || !(player getVariable ["OT_tute_inProgress", false]))) exitWith {
					_cTarget call OT_fnc_talkToCiv;
				};
			};
			[] spawn OT_fnc_mainMenu;
		};
	};
}else{
	closeDialog 0;
};
_handled = true;

_handled
