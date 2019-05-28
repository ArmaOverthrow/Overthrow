//They are driving or in a non-civilian vehicle including statics
if !((typeof (vehicle _this)) in (OT_allVehicles+OT_allBoats-["OT_I_Truck_recovery"])) exitWith {
	true;
};
//They are driving or in a car with a weapon attached
if (((vehicle _this) getVariable ["OT_attachedClass",""]) != "") exitWith {
	true;
};
//Drivers are not checked for weapons because you cannot shoot and drive, otherwise...
if(driver (vehicle _this) isEqualTo _this) exitWith{false};
// carrying a weapon or illegal gear
if (
	_this call OT_fnc_hasWeaponEquipped
	|| { ((headgear _this) in OT_illegalHeadgear) || ((vest _this) in OT_illegalVests) }
) exitWith {
	true
};
false
