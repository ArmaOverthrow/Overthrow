private _cfg = configFile >> "CfgMagazines" >> _this;

if (isText(_cfg >> "picture")) then {
    getText(_cfg >> "picture")
}else{
    ""
}
