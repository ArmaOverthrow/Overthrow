private ["_handled","_key","_showing"];
_handled = false;
_showing = false;

_key = _this select 1;
if (_key == 21) then
{
	if(!dialog) then {
		if(count (groupSelectedUnits player) > 0) exitWith {			
			createDialog "OT_dialog_command";
		};
		if(vehicle player != player) exitWith {			
			createDialog "OT_dialog_vehicle";
		};
		[] spawn mainMenu;	
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