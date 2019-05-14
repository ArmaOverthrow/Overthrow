player setVariable ["OT_tute_inProgress",true];

hint "Get familiar with the basic controls, then press Y (or Z for QWERTZ-Layouts) to continue";
sleep 0.2;


private _acekey = "Left Windows (default)";
private _acebind = ["ACE3 Common","ace_interact_menu_InteractKey"] call CBA_fnc_getKeybind;
if(count _acebind > 0) then {
	_acekey = (cba_keybinding_keynames) getVariable [str ((_acebind select 5) select 0),_acekey];
};

private _txt = format [
	"<t align='right'><t size='0.6' color='#ffffff'>Basic Controls</t><br/>
	<t size='0.4' color='#ffffff'>Move Forward  <t size='0.6'>%1</t></t><br/>
	<t size='0.4' color='#ffffff'>Move Back  <t size='0.6'>%2</t></t><br/>
	<t size='0.4' color='#ffffff'>Move Left  <t size='0.6'>%3</t></t><br/>
	<t size='0.4' color='#ffffff'>Move Right  <t size='0.6'>%4</t></t><br/><br/>
	<t size='0.4' color='#ffffff'>Vault  <t size='0.6'>%5</t></t><br/><br/>
	<t size='0.4' color='#ffffff'>Interact  <t size='0.6'>Hold %6</t></t><br/>
	<t size='0.4' color='#ffffff'>Open Inventory  <t size='0.6'>%7</t></t><br/>
	<t size='0.4' color='#ffffff'>Open Map  <t size='0.6'>%8</t></t><br/>
	<t size='0.4' color='#ffffff'>Main Menu  <t size='0.6'>Y</t></t><br/>
	<t size='0.4' color='#ffffff'>Go Back  <t size='0.6'>Esc</t></t><br/></t>",
	"MoveForward" call OT_fnc_getAssignedKey,
	"MoveBack" call OT_fnc_getAssignedKey,
	"TurnLeft" call OT_fnc_getAssignedKey,
	"TurnRight" call OT_fnc_getAssignedKey,
	"GetOver" call OT_fnc_getAssignedKey,
	_acekey,
	"Gear" call OT_fnc_getAssignedKey,
	"ShowMap" call OT_fnc_getAssignedKey
];

[_txt, 0.25, 0.2, 120, 1, 0, 2] call OT_fnc_dynamicText;

player setVariable ["OT_tute_trigger",true]
