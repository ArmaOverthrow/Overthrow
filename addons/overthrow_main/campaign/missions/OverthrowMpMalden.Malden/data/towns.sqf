/*
Use the following to fetch town data automatically, or copy/paste to override/tweak

OT_townData = [];

{
    OT_townData pushback [getArray(_x >> "position"),getText(_x >> "name")];
}foreach("(getText(_x >> 'type') in ['NameCity','NameVillage','NameCityCapital'])" configClasses (configfile >> "CfgWorlds" >> "Malden" >> "Names"));
*/

OT_townData = [
    [[6012.54,8627.26,0],"Larche"],
    [[7263.75,7931.26,0],"La Trinite"],
    [[3115.53,6330.82,0],"La Pessagne"],
    [[5835.55,3529.72,0],"Chapoi"],
    [[3068.5,6835.06,0],"Vigny"],
    [[5546.52,4232.86,0],"Sainte Marie"],
    [[3731.48,3257.96,0],"La Riviere"],
    [[5404.27,2796.07,0],"Cancon"],
    [[8192.56,3117.11,0],"Le Port"],
    [[7121.48,6074.55,0],"Houdan"],
    [[7035.72,7108.35,0],"Dourdan"],
    [[5537.25,6983.24,0],"Arudy"],
    [[3584.88,8520.04,0],"Goisse"],
    [[7143.06,8968.49,0],"Saint Louis"],
    [[5567.41,11187.5,0],"Lolisse"],
    [[883.14,11987.7,0],"Moray"]
];

OT_spawnTowns = ["Goisse","La Riviere","Lolisse"];
OT_capitals = ["La Trinite"]; //region capitals
OT_sprawling = [];
