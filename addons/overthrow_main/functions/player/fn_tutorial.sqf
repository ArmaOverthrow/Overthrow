hint "Get familiar with the basic controls, then press Y (or Z for QWERTZ-Layouts) to continue";
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

