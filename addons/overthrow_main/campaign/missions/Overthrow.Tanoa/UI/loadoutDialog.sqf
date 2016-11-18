disableSerialization;
OT_context = _this select 0;
createDialog "OT_dialog_loadout";

lbClear 1500;
{			
	_cls = _x;	
		
	_idx = lbAdd [1500,_cls];
	lbSetValue [1500,_idx,0];
	lbSetData [1500,_idx,_cls];
}foreach(profilenamespace getvariable ["OT_loadouts",[]]);

