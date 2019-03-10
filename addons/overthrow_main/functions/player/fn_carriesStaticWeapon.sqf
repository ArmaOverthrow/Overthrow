{
	if(typeOf _x in OT_staticWeapons) exitWith {
		true
	};
	false
}foreach(attachedObjects _this)