//Variables required by mission initVar + can be overriden by mission initVar

OT_hasAce = true;
OT_hasTFAR = (isClass (configFile >> "CfgPatches" >> "task_force_radio"));
OT_hasJetsDLC = ("B_Plane_Fighter_01_F" isKindOf "Air");

//Buildings (mission override)
OT_shopBuildings = [];
OT_spawnHouseBuildings = [];
OT_carShopBuildings = [];

//Default Loadouts
OT_CRIMBaseLoadout = [
	["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
	[],
	["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
	["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2]]],
	["V_PlateCarrier1_tna_F",[]],
	[],
	"",
	"",
	[],
	["ItemMap","","","","",""]
];

OT_Unit_Police = "I_soldier_F";
OT_Loadout_Police = [
	[],
	[],
	["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
	["U_BG_Guerilla2_3",[]],
	["V_TacVest_blk_POLICE",[["16Rnd_9x21_Mag",4,17]]],
	[],
	"H_Cap_police",
	"",
	[],
	["","","","","",""]
];

//Default recruit types and squads
OT_Recruitables = [
    //Rifleman
	["I_soldier_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        [],
        "H_HelmetB_tna_F",
        "",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Autorifleman
	["I_Soldier_AR_F",[
        ["arifle_MX_SW_khk_F","","","optic_Aco",["100Rnd_65x39_caseless_khaki_mag",100],[],"bipod_01_F_khk"],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier2_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["100Rnd_65x39_caseless_khaki_mag",5,100]]],
        [],
        "H_HelmetB_Light_tna_F",
        "",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Rifleman (AT)
	["I_Soldier_LAT_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        ["launch_RPG7_F","","","",["RPG7_F",1],[],""],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_FieldPack_oli",[["RPG7_F",4,1]]],
        "H_HelmetB_Light_tna_F","",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Marksman
	["I_Soldier_M_F",[
        ["arifle_MXM_khk_F","","","optic_sos_khk_f",["30Rnd_65x39_caseless_khaki_mag",30],[],"bipod_01_F_khk"],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        [],
        "H_HelmetB_tna_F","",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Sniper
	["I_Sniper_F",[
        ["srifle_LRR_tna_F","","","optic_LRPS_tna_f",["7Rnd_408_Mag",7],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["7Rnd_408_Mag",8,7]]],
        [],
        "H_HelmetB_tna_F","",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Spotter
	["I_Spotter_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        [],
        "H_HelmetB_tna_F",
        "",
        ["Binocular","","","",[],[],""],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Squad Leader
	["I_Soldier_SL_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        [],
        "H_HelmetB_tna_F",
        "",
        ["Binocular","","","",[],[],""],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Medic
	["I_Medic_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_FieldPack_oli",[["ACE_morphine",10],["ACE_epinephrine",10],["ACE_fieldDressing",20]]],
        "H_HelmetB_tna_F",
        "",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //AT
	["I_Soldier_AT_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        ["launch_B_Titan_short_tna_F","","","",["Titan_AT",1],[],""],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_FieldPack_oli",[["Titan_AT",2,1]]],
        "H_HelmetB_Light_tna_F","",
        [],
        ["ItemMap","","","","","NVGoggles_tnaF"]]
    ],
    //AA
	["I_Soldier_AA_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        ["launch_B_Titan_tna_F","","","",["Titan_AA",1],[],""],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_FieldPack_oli",[["Titan_AA",2,1]]],
        "H_HelmetB_Light_tna_F","",
        [],
        ["ItemMap","","","","","NVGoggles_tnaF"]]
    ],
    //Assistant AT
	["I_Soldier_AAT_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_Carryall_oli",[["Titan_AT",3,1]]],
        "H_HelmetB_Light_tna_F",
        "",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Assistant AA
	["I_Soldier_AAA_F",[
        ["arifle_MX_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier1_tna_F",[["16Rnd_9x21_Mag",2,17],["MiniGrenade",2,1],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_Carryall_oli",[["Titan_AA",3,1]]],
        "H_HelmetB_Light_tna_F",
        "",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ],
    //Grenadier
	["I_Soldier_GL_F",[
        ["arifle_MX_GL_khk_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],["1Rnd_HE_Grenade_shell",1],""],
        [],
        ["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",17],[],""],
        ["U_I_C_Soldier_Para_4_F",[["ACE_morphine",1],["ACE_epinephrine",1],["ACE_fieldDressing",2],["ACE_EarPlugs",1]]],
        ["V_PlateCarrier1_tna_F",[["HandGrenade",4,1],["MiniGrenade",4,1],["16Rnd_9x21_Mag",2,17],["30Rnd_65x39_caseless_khaki_mag",6,30]]],
        ["B_Kitbag_sgg",[["1Rnd_HE_Grenade_shell",20,1],["1Rnd_SmokeBlue_Grenade_shell",3,1],["1Rnd_SmokeGreen_Grenade_shell",3,1],["1Rnd_SmokeOrange_Grenade_shell",3,1],["1Rnd_Smoke_Grenade_shell",3,1]]],
        "H_HelmetB_Light_tna_F","",
        [],
        ["ItemMap","","","","","NVGoggles_tna_F"]]
    ]
];

OT_Squadables = [
	["Sentry",["I_Soldier_SL_F","I_soldier_F"],"SEN"],
	["Sniper Squad",["I_Sniper_F","I_Spotter_F"],"SNI"],
	["Light AT Squad",["I_Soldier_SL_F","I_Soldier_LAT_F","I_Soldier_GL_F","I_Medic_F"],"LAT"],
	["AT Squad",["I_Soldier_SL_F","I_Soldier_AT_F","I_Soldier_AAT_F","I_Medic_F"],"AT"],
	["AA Squad",["I_Soldier_SL_F","I_Soldier_AA_F","I_Soldier_AAA_F","I_Medic_F"],"AA"],
	["Fire Team",["I_Soldier_SL_F","I_soldier_F","I_Soldier_AR_F","I_Soldier_LAT_F","I_Soldier_M_F","I_Medic_F"],"FIR"],
	["Infantry Team",["I_Soldier_SL_F","I_soldier_F","I_Soldier_AR_F","I_Soldier_LAT_F","I_Soldier_M_F","I_Medic_F","I_Soldier_AT_F","I_Soldier_AA_F"],"INF"]
];
