class CfgPatches {
	class ADDON {
		name = "Overthrow";
		units[] = {"OT_GanjaItem"};
		weapons[] = {"OT_Ganja"};
		requiredVersion = 0.1;
		requiredAddons[] = {};
		author = "ARMAzac";
	};
};

class CfgMissions
{
	class Missions
	{
		class Overthrow
		{			
			directory = "Overthrow\Overthrow.Tanoa";
			author="ARMAzac";
			displayName = "[SP] Overthrow.Tanoa";
		};
	};
	class MPMissions
	{
		class Overthrow
		{			
			#include "Overthrow\Overthrow.Tanoa\description.ext";
			directory = "Overthrow\Overthrow.Tanoa";
			briefingName = "[CO-OP] Overthrow.Tanoa";
			author="ARMAzac";
		};
	};
};

#include "macros.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"