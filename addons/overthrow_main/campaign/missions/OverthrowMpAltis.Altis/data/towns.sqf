/*
Use the following to fetch town data automatically, or copy/paste to override/tweak

OT_townData = [];

{
    OT_townData pushback [getArray(_x >> "position"),getText(_x >> "name")];
}foreach("(getText(_x >> 'type') in ['NameCity','NameVillage','NameCityCapital'])" configClasses (configfile >> "CfgWorlds" >> "Altis" >> "Names"));
*/

OT_townData = [
    [[3687.78,13776.1,0],"Aggelochori"],
    [[4116.11,11736.1,0],"Neri"],
    [[5033.31,11245.2,0],"Panochori"],
    [[9091.81,11961.9,0],"Zaros"],
    [[10618.9,12237.3,0],"Therisa"],
    [[11701.1,13672.1,0],"Katalaki"],
    [[12502,14337,0],"Neochori"],
    [[12950.1,15041.6,0],"Stavros"],
    [[12282,15732.3,0],"Lakka"],
    [[11112.6,14573.7,0],"Alikampos"],
    [[9187.95,15947.8,0],"Agios Dionysios"],
    [[7062.42,16472.1,0],"Kore"],
    [[4885.98,16171.3,0],"Negades"],
    [[3948.77,17277.8,0],"Agios Konstantinos"],
    [[7375.81,15429.5,0],"Topolia"],
    [[14479.8,17614.3,0],"Gravia"],
    [[13993,18709.4,0],"Athira"],
    [[14612.5,20786.7,0],"Frini"],
    [[12787,19679.3,0],"Ifestiona"],
    [[8625.13,18301.6,0],"Syrta"],
    [[10270.3,19036,0],"Galati"],
    [[11786.7,18372.4,0],"Koroni"],
    [[9425.42,20284,0],"Abdera"],
    [[16207,17296.7,0],"Telos"],
    [[16584.3,16104,0],"Anthrakia"],
    [[17826.5,18129.4,0],"Kalithea"],
    [[19339.4,17641.6,0],"Agios Petros"],
    [[20885.4,16958.8,0],"Paros"],
    [[21351.6,16361.9,0],"Kalochori"],
    [[25680.5,21365.1,0],"Sofia"],
    [[26943.9,23170.7,0],"Molos"],
    [[23199.7,19986.6,0],"Ioannina"],
    [[23908.6,20144.7,0],"Delfinaki"],
    [[19473.3,15453.7,0],"Nifi"],
    [[18049.1,15264.1,0],"Charkia"],
    [[19336.9,13252.3,0],"Dorida"],
    [[20194.6,11660.7,0],"Chalkeia"],
    [[20490.2,8907.12,0],"Panagia"],
    [[21640.7,7583.93,0],"Feres"],
    [[20769.8,6736.46,0],"Selakano"],
    [[16780.6,12604.5,0],"Pyrgos"],
    [[3458.95,12966.4,0],"Kavala"],
    [[10966.5,13435.3,0],"Poliakko"],
    [[4560.45,21460.6,0],"Oreokastro"],
    [[16668.5,20487,0],"Agia Triada"],
    [[10410.4,17243.1,0],"Orino"],
    [[17059.7,9992.32,0],"Ekali"],
    [[18753.4,16597.1,0],"Rodopoli"],
    [[3608.63,10281.1,0],"Athanos"]
];

OT_spawnTowns = ["Oreokastro","Agios Konstantinos","Negades","Kore","Syrta","Abdera"];
OT_capitals = ["Kavala","Athira","Pyrgos"]; //region capitals
OT_sprawling = [];
