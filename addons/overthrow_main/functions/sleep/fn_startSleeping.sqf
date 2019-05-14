
closeDialog 0;
player allowDamage false;
showCinemaBorder false;
_camz = "camera" camCreate [getPosATL player#0,getPosATL player#1,((getPosATL player#2)+2.5)];
_camz camSetTarget player;
_camz cameraEffect ["internal", "BACK"];
_camz camSetFov 0.75;
_camz camCommit 0;

cutText ["","BLACK OUT",8];
_camz camSetPos [(getPosATL player #0),(getPosATL player #1),(getPosATL player #2) + 50];
_relPos = player getRelPos [1000, random 360];
_camz camSetTarget [(_relPos #0),(_relPos #1),(_relPos #2) + 100];
_camz camSetFov 1.2;
_camz camCommit 8;
uiSleep 8;
cutText ["","BLACK FADED",10];

uiSleep 1;
OT_sleepTime = nil;
cutText ["","BLACK IN",10];
_camz camSetPos [getPosATL player#0,getPosATL player#1,((getPosATL player#2)+2.5)];
_camz camSetTarget player;
_camz camSetFov 0.75;
_camz camCommit 10;
uiSleep 1;
[[[format["%1, %2",(getpos player) call OT_fnc_nearestTown,OT_nation],"align = 'center' size = '0.7' font='PuristaBold'"],["","<br/>"],[format["%1/%2/%3",date#2,date#1,date#0]],["","<br/>"],[format["%1",[daytime,"HH:MM"] call BIS_fnc_timeToString],"align = 'center' size = '0.7'"],["s","<br/>"]]] spawn BIS_fnc_typeText2;
uiSleep 9;
_camz cameraEffect ["terminate", "BACK"];
deleteVehicle _camz;
player allowDamage true;
