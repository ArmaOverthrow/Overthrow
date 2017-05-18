private _cfg = configFile >> "CfgVehicles" >> _this;

if (isText(_cfg >> "picture")) then {
    getText(_cfg >> "picture")
}else{
    ""
}
