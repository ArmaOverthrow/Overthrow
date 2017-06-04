private _cfg = configFile >> "CfgWeapons" >> _this;

if (isText(_cfg >> "displayName")) then {
    getText(_cfg >> "displayName")
}else{
    ""
}
