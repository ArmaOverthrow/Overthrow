private ["_handled","_key","_showing"];
_handled = false;
_showing = false;


if(!dialog) then {
	if(count (player nearObjects [OT_workshopBuilding,10]) > 0) then {
		[] call OT_fnc_workshopDialog;
	}else{
		if((vehicle player) != player and count (player nearObjects [OT_portBuilding,30]) > 0) then {
			createDialog "OT_dialog_vehicleport";
			private _ft = server getVariable ["OT_fastTravelType",1];
			if(!OT_adminMode and _ft > 1) then {
				ctrlEnable [1600,false];
			};
		}else{
			[] spawn OT_menuHandler;
			if(hcShownBar and count (hcSelected player) > 0) exitWith {
				createDialog "OT_dialog_squad";
			};
			if(!hcShownBar and ({!isplayer _x} count (groupSelectedUnits player) > 0)) exitWith {
				{
					if(isPlayer _x) then {
						player groupSelectUnit [_x,false];
					};
				}foreach(groupSelectedUnits player);
				createDialog "OT_dialog_command";
			};
			if(vehicle player != player) exitWith {
				private _ferry = player getVariable ["OT_ferryDestination",[]];
				if(count _ferry == 3) exitWith {
					_veh = vehicle player;

					disableUserInput true;
					_town = _ferry call OT_fnc_nearestTown;

					private _cost = player getVariable ["OT_ferryCost",0];
					if((player getVariable "money") < _cost) exitWith {
						"You cannot afford that!" call OT_fnc_notifyMinor;
					};
					[-_cost] call OT_fnc_money;
					cutText [format["Skipping ferry to %1",_town],"BLACK",2];
					player setVariable ["OT_ferryDestination",[],false];
					[_ferry,_veh] spawn {
						params ["_pos","_veh"];
						sleep 2;
						private _driver = driver _veh;
						private _e = [];
						{
							private _p = [_pos,[0,50]] call SHK_pos;
							moveOut _x;
							_x allowDamage false;
							_x setPos _p;
							_e pushback _x;
						} foreach(crew vehicle player);
						sleep 2;
						disableUserInput false;
						cutText ["","BLACK IN",3];
						deleteVehicle _driver;
						deleteVehicle _veh;
						{
							_x allowDamage true;
						}foreach(_e);
					};
				};
				call {
					if(driver vehicle player != player) exitWith {
						[] spawn OT_fnc_mainMenu;
					};
					if(call OT_fnc_playerIsAtWarehouse) exitWith {
						createDialog "OT_dialog_vehiclewarehouse";
					};
					if(call OT_fnc_playerIsAtHardwareStore) exitWith {
						createDialog "OT_dialog_vehiclehardware";
					};
					createDialog "OT_dialog_vehicle";
					[] spawn OT_fnc_vehicleDialog;
				};
			};
			[] spawn OT_fnc_mainMenu;
		};
	};
}else{
	closeDialog 0;
};
_handled = true;

_handled
