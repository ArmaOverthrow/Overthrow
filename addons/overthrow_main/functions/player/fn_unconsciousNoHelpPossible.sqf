params ["_unit"];

"You are unconscious, there is no one nearby with Epinephrine to revive you" call OT_fnc_notifyMinor;
[
	{_this setDamage 1;}, //rip
	_unit,
	5
] call CBA_fnc_waitAndExecute;