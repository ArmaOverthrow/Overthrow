if (!hasInterface) exitWith {};

_counter = _this select 0;
_del = _this select 1;

if !(_del) then {
	with uiNamespace do {
		ctrlDelete (uiNamespace getVariable "pBar");
		ctrlDelete (uiNamespace getVariable "pBartext");
		pBar = findDisplay 46 ctrlCreate ["RscProgress", -1];
		pBar ctrlSetPosition [ 0.345, -0.15 ];
		pBar progressSetPosition 0;
		pBar ctrlSetTextColor [0,0.5,0,1];
		pBar ctrlCommit 0;

	    [ "TIMER", "onEachFrame", {
	        params[ "_start", "_end" ];
	        _progress = linearConversion[ _start, _end, time, 0, 1 ];
	        (uiNamespace getVariable "pBar") progressSetPosition _progress;

			if ( _progress > 1 ) then {
	            [ "TIMER", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler;
				ctrlDelete (uiNamespace getVariable "pBar");

	        };
	    }, [ time, time + _counter ] ] call BIS_fnc_addStackedEventHandler;
	};
}
else {
	with uiNamespace do {
		ctrlDelete (uiNamespace getVariable "pBar");
		ctrlDelete (uiNamespace getVariable "pBartext");
	};
};