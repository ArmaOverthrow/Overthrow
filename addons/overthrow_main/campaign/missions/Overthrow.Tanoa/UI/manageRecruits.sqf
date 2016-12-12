closedialog 0;
createDialog "OT_dialog_recruits";
openMap false;



ctrlEnable [1600,false];


refreshRecruits = {
	lbClear 1500;
	_t = 1;
	{
		if !(isPlayer _x) then {
			_idx = lbadd [1500,format["%1. %2 (%3)",_t,name _x,rank _x]];
			lbSetValue [1500,_idx,_t];
		};
		_t = _t + 1;
	}foreach(units(group player));
};

recruitSelected = {
	ctrlEnable [1600,true];
	_recruit = (units group player) select (lbValue[1500,lbCurSel 1500]-1);
	_town = (getpos _recruit) call OT_fnc_nearestTown;
	disableSerialization;	
	_ctrl = (findDisplay 8004) displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText format["
		<t align='left' size='1.3'>%1</t><br/>
		<t align='left' size='1'>Currently In %2</t><br/>	
		<t align='left' size='0.7'>Rank: %3</t>
	",name _recruit,_town,rank _recruit];
};

dismissRecruit = {
	_recruit = (units group player) select (lbValue[1500,lbCurSel 1500]-1);
	deleteVehicle _recruit;
	ctrlEnable [1600,false];
	[] call refreshRecruits;
	disableSerialization;	
	_ctrl = (findDisplay 8004) displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText "";	
};

[] call refreshRecruits;