_ls = [ (_this select 0),"","","","speed _target <= 1 AND speed _target >= -1 AND _target distance _this < 5  AND vehicle _this == _this AND ( typeNAME (_target getVariable 'OT_Attached') != 'BOOL' OR typeNAME (_target getVariable 'OT_Local') != 'BOOL')","true",{},{},{},{},[],13,nil,false,false] call BIS_fnc_holdActionAdd;
_vls = (_this select 0) addAction ["", {[(_this select 0),(_this select 1)] spawn OT_fnc_mountAttached;},[],5.5,true,true,"","typeNAME (_target getVariable 'OT_Attached') != 'BOOL' AND _target distance _this < 5"];
(_this select 0) setVariable ["OT_Act",_ls,false];
(_this select 0) setVariable ["OT_Act_GetIn",_vls,false];
(_this select 0) setVariable["OT_Attached",false,true];
(_this select 0) setVariable["OT_Local",false,true];
