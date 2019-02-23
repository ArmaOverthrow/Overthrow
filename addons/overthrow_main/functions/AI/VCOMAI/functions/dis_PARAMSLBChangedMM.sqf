_Line1 = _this select 0; //Dialog Control Number
_index = _this select 1; //Index number
_text = lbText [1500, _index];
_FinalSelect = "";
_ActualVariable = "NIL";

{
	if (_text isEqualTo (_x select 0)) exitWith {_FinalSelect = _x select 2;_ActualVariable = _x select 1;};
} foreach VCOM_AllSettings;

((findDisplay 7123) displayCtrl (27201)) ctrlSetPosition [0,0];
((findDisplay 7123) displayCtrl (27201)) ctrlCommit 0;
((findDisplay 7123) displayCtrl (27201)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_FinalSelect]);

ctrlSetText [1400,str _ActualVariable];