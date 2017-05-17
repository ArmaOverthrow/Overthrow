private ["_handled","_key","_showing"];
_handled = false;
_showing = false;

_key = _this select 1;
if (_key == 21) then
{
	if(!dialog) then {
		if(count (player nearObjects [OT_workshopBuilding,10]) > 0) then {
			[] call OT_fnc_workshopDialog;
		}else{
			if((vehicle player) != player and count (player nearObjects [OT_portBuilding,30]) > 0) then {
				createDialog "OT_dialog_vehicleport";
			}else{
				[] spawn menuHandler;
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
						[-_cost] call money;
						cutText [format["Skipping ferry to %1",_town],"BLACK",2];
						player setVariable ["OT_ferryDestination",[],false];
						[_ferry,_veh] spawn {
							params ["_pos","_veh"];
							sleep 2;
							private _driver = driver _veh;
							{
								private _p = [_pos,[0,50]] call SHK_pos;
								moveOut _x;
								_x setPos _p;
							} foreach(crew vehicle player);
							sleep 2;
							disableUserInput false;
							cutText ["","BLACK IN",3];
							deleteVehicle _driver;
							deleteVehicle _veh;
						};
					};
					if(call OT_fnc_playerAtWarehouse) then {
						createDialog "OT_dialog_vehiclewarehouse";
					}else{
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
}
else
{
	if (_key == 207 and !OT_hasAce) then
	{
		if (soundVolume <= 0.5) then
		{
			0.5 fadeSound 1;
			hintSilent "You've taken out your ear plugs.";
		}
		else
		{
			0.5 fadeSound 0.1;
			hintSilent "You've inserted your ear plugs.";
		};
		_handled = true;
	};
};
_handled

/* keypress codes
ESC = 1
F1 = 59
F2 = 60
F3 = 61
F4 = 62
F5 = 63
F6 = 64
F7 = 65
F8 = 66
F9 = 67
F10 = 68
F11 = 87
F12 = 88
PRINT = 183
SCROLL = 70
PAUSE = 197
^ = 41
1 = 2
2 = 3
3 = 4
4 = 5
5 = 6
6 = 7
7 = 8
8 = 9
9 = 10
0 = 11
ß = 12
´ = 13
Ü = 26
Ö = 39
Ä = 40
# = 43
< = 86
, = 51
. = 52
- = 53
+ = NOT DEFINED
POS1 = 199
TAB = 15
ENTER = 28
DELETE = 211
BACKSPACE = 14
INSERT = 210
END = 207
PAGEUP = 201
PAGEDOWN = 209
CAPS = 58
A = 30
B = 48
C = 46
D = 32
E = 18
F = 33
G = 34
H = 35
I = 23
J = 36
K = 37
L = 38
M = 50
N = 49
O = 24
P = 25
Q = 16
U = 22
R = 19
S = 31
T = 20
V = 47
W = 17
X = 45
Y = 21
Z = 44
SHIFTL = 42
SHIFTR = 54
UP = 200
DOWN = 208
LEFT = 203
RIGHT = 205
NUM_0 = 82
NUM_1 = 79
NUM_2 = 80
NUM_3 = 81
NUM_4 = 75
NUM_5 = 76
NUM_6 = 77
NUM_7 = 71
NUM_8 = 72
NUM_9 = 73
NUM_+ = 78
NUM = 69
NUM_/ = 181
NUM_* = 55
NUM_- = 74
NUM_, = 83
NUM_ENTER = 156
STRGL = 29
STRGR = 157
WINL = 220
WINR = 219
ALT = 56
SPACE = 57
ALTGR = 184
APP = 221
*/
