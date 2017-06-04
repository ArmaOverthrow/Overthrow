private _cfg = configFile >> "CfgWeapons" >> _this;

if (isText(_cfg >> "picture")) then {
    getText(_cfg >> "picture")
}else{
    ""
}
