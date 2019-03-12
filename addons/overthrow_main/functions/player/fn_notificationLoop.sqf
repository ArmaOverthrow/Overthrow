if (alive _this) then {
	if(count OT_notifies > 0) then {
		[OT_notifies joinString "<br/>", -1, -0.2, 10, 0.5, 0, 9876] call OT_fnc_dynamicText;
		OT_notifies = [];
		[OT_fnc_notificationLoop,_this,11.5] call CBA_fnc_waitAndExecute;
	} else {
		[OT_fnc_notificationLoop,_this,1] call CBA_fnc_waitAndExecute;
	};
};