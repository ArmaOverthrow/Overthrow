private _cfg = configFile >> "CfgVehicles" >> _this;

if (isText(_cfg >> "Library" >> "libTextDesc")) then {
    getText(_cfg >> "Library" >> "libTextDesc")
}else{
    ""
}
