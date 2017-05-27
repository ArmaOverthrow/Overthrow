private _cfg = configFile >> "CfgGlasses" >> _this;

if (isText(_cfg >> "displayName")) then {
    getText(_cfg >> "displayName")
}else{
    ""
}
