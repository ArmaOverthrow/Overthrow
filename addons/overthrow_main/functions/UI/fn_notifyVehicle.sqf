_owner = server getVariable "name"+((vehicle player) call OT_fnc_getOwner);
if(isNil "_owner") then {_owner = "Someone"};
_txt = format["<t align='left' size='1.2' color='#ffffff'>%1</t><br/><t size='0.5' color='#bbbbbb' align='left'>Owner: %2</t>",(typeof vehicle player) call OT_fnc_vehicleGetName,_owner];
[_txt, -0.5, 1, 5, 1, 0, 5] spawn bis_fnc_dynamicText;
