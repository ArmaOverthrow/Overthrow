//Lets open dat dialog!
(finddisplay 49) closedisplay 1;
closeDialog 5230;

createDialog "VCOM_PARAMS";

((findDisplay (7123)) displayCtrl 1200) ctrlSetText "VcomAI\Background.paa"; 

lbClear 1500;
{
	lbAdd [1500,(_x select 0)];
} foreach VCOM_AllSettings;


_DI = "SELECT A PARAM TO GET ITS DESCRIPTION";
((findDisplay 7123) displayCtrl (27201))  ctrlSetPosition [0,0];
((findDisplay 7123) displayCtrl (27201))  ctrlCommit 0;
((findDisplay 7123) displayCtrl (27201))  ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	


_display = (findDisplay 7123) displayCtrl 1500;
_display ctrlSetEventHandler ["LBSelChanged","[_this select 0,_this select 1] call dis_PARAMSLBChangedMM"];



