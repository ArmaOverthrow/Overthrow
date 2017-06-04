params ["_name"];

_loadout = profileNamespace setVariable [format["OT_loadout_%1",_name],nil];

_loadouts = profileNamespace getVariable ["OT_loadouts",[]];
_loadouts deleteAt (_loadouts find _name);
profileNamespace setVariable ["OT_loadouts",_loadouts];

lbClear 1500;
{			
	_cls = _x;	
		
	_idx = lbAdd [1500,_cls];
	lbSetValue [1500,_idx,0];
	lbSetData [1500,_idx,_cls];
}foreach(_loadouts);