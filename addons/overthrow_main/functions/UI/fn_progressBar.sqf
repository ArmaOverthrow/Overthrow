if (!hasInterface) exitWith {};

private _counter = _this select 0;
private _del = _this select 1;
if !(_del) then {
 with uiNamespace do {
	 ctrlDelete (uiNamespace getVariable "pBar");
	 ctrlDelete (uiNamespace getVariable "pBartext");
	 pBar = findDisplay 46 ctrlCreate ["RscProgress", -1];
	 pBar ctrlSetPosition [ 0.345, -0.15 ];
	 pBar progressSetPosition 0;
	 pBar ctrlSetTextColor [0,0.5,0,1];
	 pBar ctrlCommit 0;
	 pBarText = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
	 pBarText ctrlSetPosition [ 0.345, -0.15, (ctrlPosition (uiNamespace getVariable "pBar"))#2,(ctrlPosition (uiNamespace getVariable "pBar"))#3];
	 pBarText ctrlSetTextColor [1,1,1,1];
	 pBarText ctrlCommit 0;

	 [ "TIMER", "onEachFrame", {
		 params[ "_start", "_end" ];
		 private _progress = linearConversion[ _start, _end, time, 0, 1 ];
		 (uiNamespace getVariable "pBar") progressSetPosition _progress;
		 (uiNamespace getVariable "pBarText") ctrlSetStructuredText parseText format["<t align='center' font='PuristaMedium' size='0.65'>%1%2</t>",round (_progress*100),"%"];
		 if ( _progress > 1 ) then {
			 [ "TIMER", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler;
			 ctrlDelete (uiNamespace getVariable "pBar");
			 ctrlDelete (uiNamespace getVariable "pBarText");
		 };
   }, [ time, time + _counter ] ] call BIS_fnc_addStackedEventHandler;
 };
}	else {
	with uiNamespace do {
		ctrlDelete (uiNamespace getVariable "pBar");
		ctrlDelete (uiNamespace getVariable "pBartext");
	};
};
