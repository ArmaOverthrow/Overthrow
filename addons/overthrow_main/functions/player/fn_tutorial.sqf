hint "Get familiar with the basic controls, then press Y to continue";
sleep 0.2;

private _txt = "<t align='right'><t size='0.6' color='#ffffff'>Basic Controls</t><br/>";

private _acekey = "Left Windows (default)";
private _acebind = ["ACE3 Common","ace_interact_menu_InteractKey"] call CBA_fnc_getKeybind;
if(count _acebind > 0) then {
	_acekey = (cba_keybinding_keynames) getVariable [str ((_acebind select 5) select 0),_acekey];
};

_acekey = format["Hold %1",_acekey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Move Forward  <t size='0.6'>%2</t></t><br/>",_txt,"MoveForward" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Move Back  <t size='0.6'>%2</t></t><br/>",_txt,"MoveBack" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Move Left  <t size='0.6'>%2</t></t><br/>",_txt,"TurnLeft" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Move Right  <t size='0.6'>%2</t></t><br/><br/>",_txt,"TurnRight" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Vault  <t size='0.6'>%2</t></t><br/><br/>",_txt,"GetOver" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Interact  <t size='0.6'>%2</t></t><br/>",_txt,_acekey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Open Inventory  <t size='0.6'>%2</t></t><br/>",_txt,"Gear" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Open Map  <t size='0.6'>%2</t></t><br/>",_txt,"ShowMap" call OT_fnc_getAssignedKey];
_txt = format ["%1<t size='0.4' color='#ffffff'>Main Menu  <t size='0.6'>Y</t></t><br/>",_txt];
_txt = format ["%1<t size='0.4' color='#ffffff'>Go Back  <t size='0.6'>Esc</t></t><br/>",_txt];

_txt = format["%1</t>",_txt];

[_txt, 0.25, 0.2, 120, 1, 0, 2] spawn bis_fnc_dynamicText;

OT_menuHandler = {
	hint format["Take some time to explore the main menu, when you're finished open the map (%1 key)","ShowMap" call OT_fnc_getAssignedKey];
	OT_menuHandler = {};

	private _acekey = "Left Windows (default)";
	private _acebind = ["ACE3 Common","ace_interact_menu_InteractKey"] call CBA_fnc_getKeybind;
	if(count _acebind > 0) then {
		_acekey = (cba_keybinding_keynames) getVariable [str ((_acebind select 5) select 0),_acekey];
	};

	private _txt = "<t align='center'><t size='0.6' color='#ffffff'>Main Menu</t><br/><br/>";
	_txt = format ["%1<t size='0.5' color='#ffffff'>From here you can perform basic actions such as recruiting civilians or fast travelling to buildings you own, friendly bases and camps that you place. As you can see on the bottom right, this shack is owned by you, so you can therefore fast travel back here when you need to, but not while wanted.<br/><br/>To continue, close this menu (Esc) and open the map (%2 key)</t>",_txt,"ShowMap" call OT_fnc_getAssignedKey];
	sleep 3;
	[_txt, 0, 0.2, 120, 1, 0, 2] spawn bis_fnc_dynamicText;

	waitUntil {sleep 1; visibleMap};

	hint format["Holding RMB will pan the map, zoom with the scrollwheel. When you are finished exploring the map, close it with the Esc key.","Action" call OT_fnc_getAssignedKey];
	sleep 3;
	_txt = "<t align='left'><t size='0.7' color='#000000'>Stability</t><br/>";
	_txt = format ["%1<t size='0.6' color='#000000'>Yellow areas indicate towns where stability is lowest. Blue icons indicate known NATO installations.</t><br/><br/>",_txt];
	_txt = format ["%1<t size='0.5' color='#101010'>%2</t>",_txt,OT_tutorial_backstoryText];

	[_txt, -0.5, 0.5, 240, 1, 0, 2] spawn bis_fnc_dynamicText;

	waitUntil {sleep 1; !visibleMap};
	hint "";
	sleep 3;

	_txt = "<t align='center'><t size='0.6' color='#ffffff'>Interaction</t><br/>";
	_txt = format ["%1<t size='0.5' color='#ffffff'>Some objects, including most of the ones in your shack, have actions that you can perform on them directly. Try it out by moving towards the ammo crate and using your Interact key (%2). Move the mouse over 'Open' and then release the key to perform that action.</t><br/><br/>",_txt,_acekey];

	[_txt, 0, 0.2, 20, 1, 0, 2] spawn bis_fnc_dynamicText;

	sleep 20;
	_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
	[player,getpos _gundealer,"Gun Dealer"] call OT_fnc_givePlayerWaypoint;
	sleep 3;
	hint "Go and speak to the local gun dealer. Head towards the marked location, you have nothing to worry about as long as you are not carrying/wearing any illegal items.";

	waitUntil {(player distance getpos _gundealer) < 5};


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
					private _end = {
						hint format["The gun is in your pocket, you can equip it in your inventory (%1 key) by dragging it to your hands. But be careful, if NATO sees any weapons they will open fire on you, so best to keep it where it is until you uh... 'need' it", "Gear" call OT_fnc_getAssignedKey];
						sleep 10;
						playSound "3DEN_notificationDefault";
						[] spawn (OT_tutorialMissions select 0);
					};
					[player,_gundealer,[(_this select 0),"I hear you. I bet it was even them who shot the protester... I tell you what, take this spare pistol I have laying around.","What am I supposed to do with this?","I don't know. But every other guy that's come in here recently that was angry with NATO wanted a gun, and I won't ask questions.","Um.. thanks I guess","No problem, anything you can do to help me stay under their radar is great, I'll pay you $250 if you can take care of them."],_end] spawn OT_fnc_doConversation;
					player addItemToUniform OT_item_BasicGun;
					player addItemToUniform OT_item_BasicAmmo;
					player addItemToUniform OT_item_BasicAmmo;
					player addItemToUniform OT_item_BasicAmmo;
				}
			],
			[
				"There's too much crime in Tanoa, and NATO isn't doing anything about it",
				{
					_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
					private _end = {
						hint format["The gun is in your pocket, you can equip it in your inventory (%1 key) by dragging it to your hands. But be careful, if NATO sees any weapons they will open fire on you.", "Gear" call OT_fnc_getAssignedKey];
						sleep 10;
						playSound "3DEN_notificationDefault";
						[] spawn (OT_tutorialMissions select 1);
					};
					[player,_gundealer,[(_this select 0),"I agree. I bet it was even them who shot the protester, they would much rather keep this nation in turmoil...", "I know, right", "I tell you what, take this spare pistol I have laying around.","What am I supposed to do with this?",format["Local businessmen are always setting bounties on the gangs around %1, go and claim a few!",OT_nation],"Alright.. thanks","No problem, just come back if you need more ammunition or anything else the stores won't sell you."],_end] spawn OT_fnc_doConversation;
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
					private _end = {
						hint format["The drugs are in your pocket, you can see it in your inventory (%1 key).", "Gear" call OT_fnc_getAssignedKey];
						sleep 10;
						playSound "3DEN_notificationDefault";
						[] spawn (OT_tutorialMissions select 2);
					};
					[player,_gundealer,[(_this select 0),"Probably a good idea with everything that's happening. I tell you what, take this spare bud I have laying around.","What am I supposed to do with this?","Sell it to some of the civilians round here, maybe it will calm them down","Um.. thanks I guess","No problem, just come back if you need more, or anything else the stores won't sell you."],_end] spawn OT_fnc_doConversation;
					player addItemToUniform "OT_Ganja";
				}
			],
			[
				"I want to make some cash, legally",
				{
					_gundealer = spawner getVariable format["gundealer%1",(getpos player) call OT_fnc_nearestTown];
					private _end = {
						hint format["Wrecked vehicles can be salvaged with a toolkit, there should be one in your ammo crate at home. Shops on your map are marked with a circle and icon representing what they buy/sell. Towns with lower stability and population will pay higher prices for all items.", "Gear" call OT_fnc_getAssignedKey];
						sleep 10;
						playSound "3DEN_notificationDefault";
						[] spawn (OT_tutorialMissions select 3);
					};
					[player,_gundealer,[(_this select 0),"Well I'm not really the guy to help you there, but there are usually some wrecked vehicles around town, maybe you can salvage some useful resources from them?","OK, thanks.","No problem! See you around."],_end] spawn OT_fnc_doConversation;

				}
			]
		];

		_options spawn OT_fnc_playerDecision;
	};
	[_gundealer,player,_lines,_done] spawn OT_fnc_doConversation;
};
