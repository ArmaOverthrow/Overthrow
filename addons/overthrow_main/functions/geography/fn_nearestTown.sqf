_ret = "";
if(typename _this == "ARRAY") then {
    if(count _this == 2) then {
        _ret = text ((nearestLocations [ _this select 0, ["NameCityCapital","NameCity","NameVillage","CityCenter"],2200]) select 1);
    }else{
        _ret = text ((nearestLocations [ _this, ["NameCityCapital","NameCity","NameVillage","CityCenter"],2200]) select 0);
    }
}else{
    _ret = text ((nearestLocations [ _this, ["NameCityCapital","NameCity","NameVillage","CityCenter"],2200]) select 0);
};
_ret
