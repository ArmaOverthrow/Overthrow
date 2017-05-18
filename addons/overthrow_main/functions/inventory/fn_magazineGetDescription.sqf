private _cfg = configFile >> "CfgVehicles" >> _this;

if (isText(_cfg >> "descriptionShort")) then {
    getText(_cfg >> "descriptionShort")
}else{
    ""
}
