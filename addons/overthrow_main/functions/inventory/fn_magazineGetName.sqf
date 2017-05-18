private _cfg = configFile >> "CfgMagazines" >> _this;

if (isText(_cfg >> "displayName")) then {
    getText(_cfg >> "displayName")
}else{
    ""
}
