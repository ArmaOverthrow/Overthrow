closedialog 0;
createDialog "OT_dialog_char";
openMap false;

disableSerialization;	

private _fitness = player getVariable ["OT_fitness",1];

private _ctrl = (findDisplay 8003) displayCtrl 1100;
_ctrl ctrlSetStructuredText parseText format["<t size=""2"">Fitness</t><br/><t size=""1.1"">Level %1</t><br/><t size=""0.7"">Increases the distance you can sprint</t>",_fitness];

getFitnessPrice = {
	private _fitness = player getVariable ["OT_fitness",1];
	private _price = 10;
	if(_fitness == 2) then {
		_price = 100;
	};
	if(_fitness == 3) then {
		_price = 500;
	};
	if(_fitness == 4) then {
		_price = 1000;
	};
	_price;
};

private _price = [] call getFitnessPrice;
ctrlSetText [1600,format["Increase Level (-%1 Influence)",_price]];

if(_fitness == 5) then {
	ctrlShow [1600,false];
};

buyFitness = {
	disableSerialization;	
	
	private _fitness = player getVariable ["OT_fitness",1];
	private _price = [] call getFitnessPrice;
	private _inf = player getVariable ["influence",0];
	
	if(_inf < _price) exitWith {"You do not have enough influence" call notify_minor};
	
	_fitness = _fitness + 1;
	player setVariable ["OT_fitness",_fitness,true];
	if(_fitness == 5) then {
		ctrlEnable [1600,false];
	};
	player setVariable ["influence",_inf - _price,true];
	
	private _ctrl = (findDisplay 8003) displayCtrl 1100;
	_ctrl ctrlSetStructuredText parseText format["<t size=""2"">Fitness</t><br/><t size=""1.1"">Level %1</t><br/><t size=""0.7"">Increases the distance you can sprint</t>",_fitness];
	_price = [] call getFitnessPrice;
	ctrlSetText [1600,format["Increase Level (-%1 Influence)",_price]];

	if(_fitness == 5) then {
		ctrlShow [1600,false];
	};	
};