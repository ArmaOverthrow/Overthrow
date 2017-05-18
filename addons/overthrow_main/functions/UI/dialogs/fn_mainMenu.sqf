

closedialog 0;
createDialog "OT_dialog_main";

openMap false;
disableSerialization;
_buildingtextctrl = (findDisplay 8001) displayCtrl 1102;

private _donerem = false;
if !(isNull cursorObject) then {
	if((player distance cursorObject) < 20) then {
		if (cursorObject in ((allMissionObjects "Static") + vehicles)) then {
			if !((cursorObject isKindOf "CAManBase") or (side cursorObject) == west or (typeof cursorObject) == OT_flag_IND) then {
				call {
					if(((cursorObject isKindOf "Land") or (cursorObject isKindOf "Air")) and ("ToolKit" in (items player)) and (damage cursorObject) == 1) exitWith {
						_donerem = true;
						private _type = typeof cursorObject;
						_pic = getText(configfile >> "CfgVehicles" >> _type >> "editorPreview");
						ctrlSetText [1202,_pic];
						if(player distance cursorObject < 5) then {
							ctrlSetText [1614,"Salvage"];
							buttonSetAction [1614, "[] spawn OT_fnc_salvageWreck"];
						}else{
							ctrlSetText [1614,"Salvage (too far)"];
							ctrlEnable [1614,false];
						};
					};
					if((call OT_fnc_playerIsGeneral) or (cursorObject call OT_fnc_playerIsOwner)) exitWith {
						_donerem = true;
						private _type = typeof cursorObject;
						_pic = getText(configfile >> "CfgVehicles" >> _type >> "editorPreview");
						ctrlSetText [1202,_pic];
					};
				};
			};
		};
	};
};

if !(_donerem) then {
	ctrlShow [1614,false];
	ctrlShow [1202,false];
};


_town = (getpos player) call OT_fnc_nearestTown;
_standing = player getVariable format['rep%1',_town];

_weather = "Clear";
if(overcast > 0.4) then {
	_weather = "Cloudy";
};
if(rain > 0.1) then {
	_weather = "Rain";
};
if(rain > 0.9) then {
	_weather = "Storm";
};

_ctrl = (findDisplay 8001) displayCtrl 1100;
_standing = [_town] call OT_fnc_standing;
_plusmin = "";
if(_standing > -1) then {_plusmin = "+"};

_rep = player getVariable "rep";
_pm = "";
if(_rep > -1) then {_pm = "+"};

_extra = "";

if(isMultiplayer) then {
	if((getplayeruid player) in (server getVariable ["generals",[]])) then {
		_extra = format["<t align='left' size='0.65'>Resistance Funds: $%1 (Tax Rate %2%3)</t>",[server getVariable ["money",0], 1, 0, true] call CBA_fnc_formatNumber,server getVariable ["taxrate",0],"%"];
	};
};

_ctrl ctrlSetStructuredText parseText format["
	<t align='left' size='0.65'>Standing: %2 (%3%4) %12 (%5%6)</t><br/>
	<t align='left' size='0.65'>Influence: %9</t><br/>
	<t align='left' size='0.65'>Weather: %7 (Forecast: %8)</t><br/>
	<t align='left' size='0.65'>Fuel Price: $%11/L</t><br/>
	%10
",name player,_town,_plusmin,_standing,_pm,_rep,_weather,server getVariable "forecast",player getVariable ["influence",0],_extra,[OT_nation,"FUEL",100] call OT_fnc_getPrice,OT_nation];

_ctrl = (findDisplay 8001) displayCtrl 1106;
_ctrl ctrlSetStructuredText parseText format["<t align='right' size='0.9'>$%1</t>",[player getVariable "money", 1, 0, true] call CBA_fnc_formatNumber];


sleep 0.1;
//Nearest building info
_b = player call OT_fnc_nearestRealEstate;
_buildingTxt = "";

if(typename _b == "ARRAY") then {
	_building = _b select 0;
	_price = _b select 1;
	_sell = _b select 2;
	_lease = _b select 3;
	_totaloccupants = _b select 4;

	_cls = typeof _building;
	_name = _cls call OT_fnc_vehicleGetName;
	_pic = getText(configFile >>  "CfgVehicles" >>  _cls >> "editorPreview");

	if !(isNil "_pic") then {
		ctrlSetText [1201,_pic];
	};
	_txt = "";

	if(_building call OT_fnc_hasOwner) then {

		_owner = _building call OT_fnc_getOwner;
		_ownername = server getVariable format["name%1",_owner];
		if(isNil "_ownername") then {_ownername = "Someone"};

		if(_owner == getplayerUID player) then {
			_leased = player getVariable ["leased",[]];
			_id = [_building] call OT_fnc_getBuildID;
			if(_id in _leased) then {
				_ownername = format["%1 (Leased)",_ownername];
			};

			if(typeof _building == OT_item_Tent) exitWith {
				ctrlSetText [1608,"Sell"];
				ctrlEnable [1608,false];
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];

				_buildingTxt = format["
					<t align='left' size='0.8'>Camp</t><br/>
					<t align='left' size='0.65'>Owned by %1</t>
				",_ownername];
			};

			ctrlSetText [1608,format["Sell ($%1)",[_sell, 1, 0, true] call CBA_fnc_formatNumber]];

			if(typeof _building == OT_warehouse) exitWith {
				ctrlEnable [1609,true];
				ctrlSetText [1609,"Procurement"];

				_buildingTxt = format["
					<t align='left' size='0.8'>Warehouse</t><br/>
					<t align='left' size='0.65'>Owned by %1</t><br/>
					<t align='left' size='0.65'>Damage: %2%3</t>
				",_ownername,round((damage _building) * 100),"%"];
			};

			if(_id in _leased) then {
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];
			};
			if(damage _building == 1) then {
				_lease = 0;
			};
			_buildingTxt = format["
				<t align='left' size='0.8'>%1</t><br/>
				<t align='left' size='0.65'>Owned by %2</t><br/>
				<t align='left' size='0.65'>Lease Value: $%3/6hrs</t><br/>
				<t align='left' size='0.65'>Damage: %4%5</t>
			",_name,_ownername,[_lease, 1, 0, true] call CBA_fnc_formatNumber,round((damage _building) * 100),"%"];

		}else{
			ctrlEnable [1608,false];
			ctrlEnable [1609,false];
			ctrlEnable [1610,false];
			if(typeof _building == OT_item_Tent) then {
				_name = "Camp";
			};
			if(typeof _building == OT_flag_IND) then {
				_name = _building getVariable "name";
			};
			_buildingTxt = format["
				<t align='left' size='0.8'>%1</t><br/>
				<t align='left' size='0.65'>Owned by %2</t><br/>
				<t align='left' size='0.65'>Damage: %2%3</t>
			",_name,_ownername,round((damage _building) * 100),"%"];
		};
		if(typeof _building == OT_barracks) then {
			_owner = _building call OT_fnc_getOwner;
			_ownername = server getVariable format["name%1",_owner];
			ctrlSetText [1608,"Sell"];
			ctrlEnable [1608,false];
			ctrlEnable [1609,true];
			ctrlSetText [1609,"Recruit"];
			//ctrlEnable [1609,false];
			//ctrlEnable [1610,false];

			_buildingTxt = format["
				<t align='left' size='0.8'>Barracks</t><br/>
				<t align='left' size='0.65'>Built by %1</t><br/>
				<t align='left' size='0.65'>Damage: %2%3</t>
			",_ownername,round((damage _building) * 100),"%"];
		};
		if(typeof _building == OT_trainingCamp) then {
			_owner = _building call OT_fnc_getOwner;
			_ownername = server getVariable format["name%1",_owner];
			ctrlSetText [1608,"Sell"];
			ctrlEnable [1608,false];
			ctrlEnable [1609,true];
			ctrlSetText [1609,"Recruit"];
			//ctrlEnable [1609,false];
			ctrlEnable [1610,false];

			_buildingTxt = format["
				<t align='left' size='0.8'>Training Camp</t><br/>
				<t align='left' size='0.65'>Built by %1</t><br/>
				<t align='left' size='0.65'>Damage: %2%3</t>
			",_ownername,round((damage _building) * 100),"%"];
		};

		if(typeof _building == OT_refugeeCamp) then {
			_owner = _building call OT_fnc_getOwner;
			_ownername = server getVariable format["name%1",_owner];
			ctrlSetText [1608,"Sell"];
			ctrlEnable [1608,false];
			ctrlEnable [1609,false];
			ctrlEnable [1610,false];

			_buildingTxt = format["
				<t align='left' size='0.8'>Refugee Camp</t><br/>
				<t align='left' size='0.65'>Built by %1</t><br/>
				<t align='left' size='0.65'>Damage: %2%3</t>
			",_ownername,round((damage _building) * 100),"%"];
		};

		if(typeof _building == OT_flag_IND) then {
			_base = [];
			{
				if((_x select 0) distance _building < 5) exitWith {_base = _x};
			}foreach(server getvariable ["bases",[]]);

			_ownername = server getVariable format["name%1",_base select 2];
			ctrlSetText [1608,"Sell"];
			ctrlEnable [1608,true];
			ctrlSetText [1608,"Garrison"];
			ctrlEnable [1609,false];
			//ctrlEnable [1609,false];
			ctrlEnable [1610,false];

			_buildingTxt = format["
				<t align='left' size='0.8'>%1</t><br/>
				<t align='left' size='0.65'>Founded by %2</t>
			",_base select 1,_ownername];
		};

		if(damage _building == 1) then {
			if((_owner == getplayerUID player) or (call OT_fnc_playerIsGeneral)) then {
				ctrlEnable [1608,false]; //Not allowed to sell
				ctrlSetText [1609,"Repair"]; //Replace lease/manage with repair
				ctrlEnable [1609,true];
				ctrlEnable [1610,false];
			};
		};
	}else{
		if(isNil "_price") then {
			ctrlEnable [1608,false];
			ctrlEnable [1609,false];
			ctrlEnable [1610,false];
		}else{
			ctrlSetText [1608,format["Buy ($%1)",[_price, 1, 0, true] call CBA_fnc_formatNumber]];
			ctrlEnable [1609,false];
			ctrlEnable [1610,false];
			if(typeof _building == OT_warehouse) exitWith {
				_buildingTxt = "<t align='left' size='0.8'>Warehouse</t>";
			};
			_buildingTxt = format["
				<t align='left' size='0.8'>%1</t><br/>
				<t align='left' size='0.65'>Lease Value: $%2/6hrs</t>
			",_name,[_lease, 1, 0, true] call CBA_fnc_formatNumber];

			if(typeof _building == OT_barracks) then {
				ctrlSetText [1608,"Sell"];
				ctrlEnable [1608,false];
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];

				_buildingTxt = format["
					<t align='left' size='0.8'>Barracks</t><br/>
				",_ownername];
			};
		};
	};

	if(typeof _building == OT_policeStation) then {
		_owner = _building call OT_fnc_getOwner;
		_ownername = server getVariable format["name%1",_owner];
		ctrlSetText [1608,"Sell"];
		ctrlEnable [1608,false];
		ctrlSetText [1609,"Manage"];
		ctrlEnable [1609,true];
		//ctrlEnable [1610,false];

		_buildingTxt = format["
			<t align='left' size='0.8'>Police Station</t><br/>
			<t align='left' size='0.65'>Built by %1</t>
		",_ownername];
	};

	if(typeof _building == "Land_Cargo_House_V4_F") then {
		_owner = _building call OT_fnc_getOwner;
		_ownername = server getVariable format["name%1",_owner];
		ctrlSetText [1608,"Sell"];
		ctrlEnable [1608,false];
		ctrlEnable [1609,false];
		//ctrlEnable [1610,false];

		_buildingTxt = format["
			<t align='left' size='0.8'>Workshop</t><br/>
			<t align='left' size='0.65'>Built by %1</t>
		",_ownername];
	};

	if(!((typeof _building) in OT_allRealEstate + [OT_flag_IND])) then {
		ctrlEnable [1609,false];
		ctrlEnable [1610,false];
		ctrlEnable [1608,false];
		_lease = 0;
		ctrlSetText [1608,"Buy"];
		_buildingTxt = format["
			<t align='left' size='0.8'>%1</t>
		",_name];
	};
}else{
	private _ob = (getpos player) call OT_fnc_nearestObjective;
	_ob params ["_obpos","_obname"];
	if(_obpos distance player < 250) then {
		if(_obname in (server getVariable ["NATOabandoned",[]])) then {
			ctrlSetText [1201,"\A3\ui_f\data\map\markers\flags\Tanoa_ca.paa"];
			_buildingTxt = format["
				<t align='left' size='0.8'>%1</t><br/>
				<t align='left' size='0.65'>Under resistance control</t>
			",_obname];
			ctrlEnable [1609,true];
		}else{
			ctrlSetText [1201,"\A3\ui_f\data\map\markers\flags\nato_ca.paa"];
			_buildingTxt = format["
				<t align='left' size='0.8'>%1</t><br/>
				<t align='left' size='0.65'>Under NATO control</t>
			",_obname];
			ctrlEnable [1609,false];
		};
		ctrlSetText [1608,"Garrison"];
		ctrlEnable [1608,true];
		ctrlSetText [1609,"Procurement"];
		ctrlEnable [1610,false];
	}else{
		private _ob = (getpos player) call OT_fnc_nearestLocation;
		if((_ob select 1) == "Business") then {
			_obpos = (_ob select 2) select 0;
			_obname = (_ob select 0);

			if(_obpos distance player < 250) then {
				if(_obname in (server getVariable ["GEURowned",[]])) then {
					ctrlSetText [1201,"\A3\ui_f\data\map\markers\flags\Tanoa_ca.paa"];
					_buildingTxt = format["
						<t align='left' size='0.8'>%1</t><br/>
						<t align='left' size='0.65'>Operational</t><br/>
						<t align='left' size='0.65'>(see resistance screen)</t><br/>
					",_obname];

					ctrlEnable [1608,false];
					ctrlEnable [1609,false];
					ctrlEnable [1610,false];
				}else{
					_price = _obname call OT_fnc_getBusinessPrice;
					ctrlSetText [1201,"\ot\ui\closed.paa"];
					_buildingTxt = format["
						<t align='left' size='0.8'>%1</t><br/>
						<t align='left' size='0.65'>Out Of Operation</t><br/>
						<t align='left' size='0.65'>$%2</t>
					",_obname,[_price, 1, 0, true] call CBA_fnc_formatNumber];
					ctrlEnable [1609,false];
					ctrlEnable [1610,false];
					if !(call OT_fnc_playerIsGeneral) then {
						ctrlEnable [1608,false];
					}
				};
			};
		}else{
			if((getpos player) distance OT_factoryPos < 150) then {
				_obname = "Factory";
				if(_obname in (server getVariable ["GEURowned",[]])) then {
					ctrlSetText [1201,"\A3\ui_f\data\map\markers\flags\Tanoa_ca.paa"];
					_buildingTxt = format["
						<t align='left' size='0.8'>%1</t><br/>
						<t align='left' size='0.65'>Operational</t>
					",_obname];
					ctrlEnable [1608,true];
					ctrlSetText [1608,"Manage"];
					ctrlEnable [1609,false];
					ctrlEnable [1610,false];
				}else{
					_price = _obname call OT_fnc_getBusinessPrice;
					ctrlSetText [1201,"\ot\ui\closed.paa"];
					_buildingTxt = format["
						<t align='left' size='0.8'>%1</t><br/>
						<t align='left' size='0.65'>Out Of Operation</t><br/>
						<t align='left' size='0.65'>$%2</t>
					",_obname,[_price, 1, 0, true] call CBA_fnc_formatNumber];
					ctrlEnable [1609,false];
					ctrlEnable [1610,false];
				};
			}else{
				ctrlEnable [1608,false];
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];
			};
		};
	};
};



OT_interactingWith = objNull;
_buildingtextctrl ctrlSetStructuredText parseText _buildingTxt;


//Nearest Civ info
_possible = (player nearEntities ["CAManBase", 20]) - [player];
_civTxt = "";
_civtxtctrl = (findDisplay 8001) displayCtrl 1101;
if(count _possible > 0) then {
	_possible = [_possible,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
	_civ = _possible select 0;

	_cls = typeof _civ;

	_name = name _civ;

	OT_interactingWith = _civ;
	player setVariable ["hiringciv",_civ,false];
	_type = "Civilian";
	if(!isplayer _civ) then {
		if !((_civ getvariable ["shop",[]]) isEqualTo []) then {_type = "Shopkeeper"};
		if (_civ getvariable ["carshop",false]) then {_type = "Car Dealer"};
		if (_civ getvariable ["harbor",false]) then {_type = "Boat Dealer"};
		if (_civ getvariable ["gundealer",false]) then {_type = "Gun Dealer"};

		if !((_civ getvariable ["garrison",""]) isEqualTo "") then {
			if(side _civ == west) exitWith {
				_type = (typeof _civ) call OT_fnc_vehicleGetName;
			};
			if(side _civ == east) exitWith {
				_type = "Bandit";
			};
			if(side _civ == resistance) exitWith {
				_type = "Policeman";
			};
		};

		if (_civ getvariable ["factionrep",false]) then {
			_type = format["Representative (%1)",_civ getvariable ["factionrepname",false]];
		};

		if(_civ call OT_fnc_hasOwner) then {
			call {
				if(side _civ == resistance) exitWith {
					_type = (typeof _civ) call OT_fnc_vehicleGetName;
				};
			};
			ctrlEnable [1605,false];
			ctrlEnable [1606,false];
		}else{
			if(side _civ == civilian) then {
				[_civ,[_civ,player] call BIS_fnc_dirTo] remoteExec ['OT_fnc_orderStopAndFace',_civ,false];
			};
		};
	}else{
		ctrlEnable [1605,false];
		ctrlEnable [1606,false];
		_type = "Player";
	};
	_civTxt = format["
		<t align='left' size='0.8'>%1</t><br/>
		<t align='left' size='0.7'>%2</t><br/>
	",_name,_type];
}else{
	ctrlEnable [1605,false];
	ctrlEnable [1606,false];
	ctrlEnable [1607,false];
};

_civtxtctrl ctrlSetStructuredText parseText _civTxt;
