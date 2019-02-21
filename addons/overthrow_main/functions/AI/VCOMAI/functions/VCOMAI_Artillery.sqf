//AI will use artillery/mortars when possible. This script makes it so each AI gets checked if they are arty capable or not
//First hash 6/14/2014
//Modified 8/15/14 - 8/5/15 - 8/15/2017

//Pull the vehicle the unit is in.
_Vehicle = (vehicle _this);
if (_Vehicle in ArtilleryArray) exitWith {};


//Get the vehicles class name.
private _class = typeOf _Vehicle;
if (isNil ("_class")) exitWith {};

//Figure out if it is defined as artillery
private _ArtyScan = getNumber(configfile/"CfgVehicles"/_class/"artilleryScanner");

//Exit the script if it is not defined as artillery
if (isNil "_ArtyScan") exitWith 
{

//Check if unit somehow is in the ArtilleryArray and remove them.  This can happen to units who were inside artillery pieces but ejected or moved out due to a divine intervention.
	if (_Vehicle in ArtilleryArray) then 
	{
		ArtilleryArray = ArtilleryArray - [_Vehicle];
	};

};

if (_ArtyScan isEqualTo 1) then 
{

	ArtilleryArray pushBack _Vehicle;
	if (VCOM_AIDEBUG isEqualTo 1) then
	{
		[_Vehicle,"I am Artillery :D!!!!",500,20000] remoteExec ["3DText",0];
	};	
};