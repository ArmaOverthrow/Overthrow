townChange = {
	_town = _this;
	_pop = server getVariable format["population%1",_town];
	_stability = server getVariable format["stability%1",_town];
	_rep = player getVariable format["rep%1",_town];
	_txt = format ["<t size='1.5' color='#eeeeee'>%1</t><br/><t size='0.5' color='#bbbbbb'>Population: %2</t><br/><t size='0.5' color='#bbbbbb'>Stability: %3%4</t><br/><t size='0.5' color='#bbbbbb'>Your Standing: %5</t>",_town,[_pop, 1, 0, true] call CBA_fnc_formatNumber,_stability,"%",_rep];
	[_txt, [safeZoneX + (0.8 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;
};
_town = (getPos player) call nearestTown;
_town call townChange;

_timer = -1;

player addEventHandler ["InventoryOpened", {
	[] spawn {
		waitUntil {!isNull (findDisplay 602)}; // Wait until the right dialog is really open 
		player addEventHandler ["InventoryClosed", {
			removeMissionEventHandler ["Draw3D", missionNamespace getVariable "WGP_UI_redraw"];
		}];
		_whileopen = addMissionEventHandler ["Draw3D", {
			_load = (round (loadAbs player* (1 / 2.2046) * 10 ^ 2 / 10)) / 10 ^ 2; // Load converted to kg and rounded to two decimals. Change the "^2" to change the number of decimal places. Remove the "* (1 / 2.2046)" to have weight in lb.
			(findDisplay 602 displayCtrl 111) ctrlSetText (name player + " " + str(_load)+ "kg");
		}];
		missionNamespace setVariable ["WGP_UI_redraw", _whileopen];
	};
}];

player spawn wantedSystem;
_closestcount = 0;

while {true} do {
	sleep 2;
		
	if(_closestcount <= 0) then {
		_closest = (getPos player) call nearestTown;
		if(_closest != _town) then {
			_closest call townChange;	
			_closestcount = 20;		
		};		
	};	
	_closestcount = _closestcount - 2;	
};

