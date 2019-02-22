private _list = position player nearObjects ["#explosion",20];
hint format ["%1",_list];


private _BOBBY = true;
while {_BOBBY} do 
{
sleep 1;
_list = position player nearObjects ["#crater",100];
{
	_hierarchy = configHierarchy (configFile >> "CfgVehicles" >> (typeof _x));
	hint format ["%1",_hierarchy];
} foreach _list;
};

//#crater - ground hits,
//#crateronvehicle - vehicle/body/buildings (possible not all buildings/structures) hits.

//(these two are long living, so must be obtained each already existing to sift off old ones (for this eg craters can be checked first time around aiming position in shooting moment, before bullet reach its destination), still it is not reliable, as there can be many new impacts there in one check cycle, if more than one bullet flies towards that point at the moment) 

//additionally: #explosion object type for "boom!s" - short live. 