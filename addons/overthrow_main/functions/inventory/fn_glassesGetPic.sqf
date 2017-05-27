private _cfg = configFile >> "CfgGlasses" >> _this;

if (isText(_cfg >> "picture")) then {
    getText(_cfg >> "picture")
}else{
    ""
}
