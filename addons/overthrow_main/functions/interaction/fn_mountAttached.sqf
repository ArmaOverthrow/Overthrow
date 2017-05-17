_aug = (_this select 0) getVariable["OT_Attached",false];
if((count (crew _aug)) > 0) exitWith {hint 'Weapon must be empty to mount';};
(_this select 1) moveInGunner _aug;
