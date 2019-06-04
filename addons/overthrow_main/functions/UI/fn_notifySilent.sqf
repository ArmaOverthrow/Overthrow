OT_notifyHistory pushback format["(%1) %2",call OT_fnc_formatTime, _this];
if(count OT_notifyHistory > 16) then {
    OT_notifyHistory deleteAt 0;
};
