private _cfg = configFile >> "CfgVehicles" >> _this;

if (isText(_cfg >> "displayName")) then {
    getText(_cfg >> "displayName")
}else{
    ""
}
