

closedialog 0;
createDialog "OT_dialog_main";
openMap false;
disableSerialization;		
_buildingtextctrl = (findDisplay 8001) displayCtrl 1102;

_town = (getpos player) call nearestTown;
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
_standing = player getVariable format["rep%1",_town];
_plusmin = "";
if(_standing > -1) then {_plusmin = "+"};

_rep = player getVariable "rep";
_pm = "";
if(_rep > -1) then {_pm = "+"};

_ctrl ctrlSetStructuredText parseText format["
	<t align='left' size='1.3'>%1</t><br/>
	<t align='left' size='1'>%2</t><br/>
	<t align='left' size='0.7'>Standing: %3%4 (Tanoa: %5%6)</t><br/>
	<t align='left' size='0.7'>Influence: %9</t><br/>
	<t align='left' size='0.7'>Weather: %7 (Forecast: %8)</t>
",name player,_town,_plusmin,_standing,_pm,_rep,_weather,server getVariable "forecast",player getVariable ["influence",0]];

sleep 0.1;
//Nearest building info
_b = player call getNearestRealEstate;
_buildingTxt = "";

if(typename _b == "ARRAY") then {
	_building = _b select 0;
	_price = _b select 1;
	_sell = _b select 2;
	_lease = _b select 3;
	_totaloccupants = _b select 4;
	
	_cls = typeof _building;
	_name = _cls call ISSE_Cfg_Vehicle_GetName;
	_pic = getText(configFile >>  "CfgVehicles" >>  _cls >> "editorPreview");
	
	if !(isNil "_pic") then {
		ctrlSetText [1201,_pic];
	};		
	_txt = "";
	
	if(_building call hasOwner) then {
		_owner = _building getVariable "owner";
		_ownername = server getVariable format["name%1",_owner];
		if(_building getVariable ["leased",false]) then {
			_ownername = format["%1<br/>(Leased)",_ownername];
		};
		if(_owner == getplayerUID player) then {
			if(typeof _building == OT_item_Tent) exitWith {
				ctrlSetText [1608,"Sell"];
				ctrlEnable [1608,false];
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];
			
				_buildingTxt = format["
					<t align='left' size='0.9'>Camp</t><br/>
					<t align='left' size='0.7'>Owned by %1</t>
				",_ownername];
			};
			if(typeof _building == OT_item_Flag) exitWith {
				ctrlSetText [1608,"Sell"];
				ctrlEnable [1608,false];
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];
			
				_buildingTxt = format["
					<t align='left' size='0.9'>%1</t><br/>
					<t align='left' size='0.7'>Owned by %2</t>
				",_building getVariable "name",_ownername];
			};
			ctrlSetText [1608,format["Sell ($%1)",[_sell, 1, 0, true] call CBA_fnc_formatNumber]];
			
			if(_building getVariable ["leased",false]) then {
				ctrlEnable [1609,false];
				ctrlEnable [1610,false];
			};
			_buildingTxt = format["
				<t align='left' size='0.9'>%1</t><br/>
				<t align='left' size='0.7'>Owned by %2</t><br/>
				<t align='left' size='0.7'>Lease Value: $%3/hr</t>
			",_name,_ownername,[_lease, 1, 0, true] call CBA_fnc_formatNumber];			
			
		}else{
			ctrlEnable [1608,false];
			ctrlEnable [1609,false];
			ctrlEnable [1610,false];
			if(typeof _building == OT_item_Tent) then {
				_name = "Camp";
			};
			if(typeof _building == OT_item_Flag) then {
				_name = _building getVariable "name";
			};
			_buildingTxt = format["
				<t align='left' size='1'>%1</t><br/>
				<t align='left' size='0.7'>Owned by %2</t>
			",_name,_ownername];
		};
	}else{
		ctrlSetText [1608,format["Buy ($%1)",[_price, 1, 0, true] call CBA_fnc_formatNumber]];
		ctrlEnable [1609,false];
		ctrlEnable [1610,false];
		_buildingTxt = format["
			<t align='left' size='0.9'>%1</t><br/>
			<t align='left' size='0.7'>Capacity: %2</t><br/>
			<t align='left' size='0.7'>Lease Value: $%3/hr</t>
		",_name,_totaloccupants,[_lease, 1, 0, true] call CBA_fnc_formatNumber];
	};	
}else{
	ctrlEnable [1608,false];
	ctrlEnable [1609,false];
	ctrlEnable [1610,false];	
};


_buildingtextctrl ctrlSetStructuredText parseText _buildingTxt;


//Nearest Civ info
_civs = player nearEntities ["Man", 10];
_possible = [];
_civTxt = "";
_civtxtctrl = (findDisplay 8001) displayCtrl 1101;
{
	if !(_x call hasOwner or _x == player or side _x == west or side _x == east) then {
		//"self" returns true ie for shopkeepers, so double check this civ has no owner
		_owner = _x getVariable "owner";
		if(isNil "_owner") then {
			_possible pushBack _x;
		};
		
	};
}foreach(_civs);

if(count _possible > 0) then {
	_possible = [_possible,[],{_x distance player},"ASCEND"] call BIS_fnc_SortBy;
	_civ = _possible select 0;
	
	_cls = typeof _civ;
	
	_name = name _civ;	

	player setVariable ["hiringciv",_civ,false];
	_type = "Civilian";
	if(!isplayer _civ) then {
		_civ disableAI "PATH";
		(group _civ) setFormDir ([_civ,player] call BIS_fnc_dirTo);		
		_civ spawn {			
			waitUntil {sleep 1;!(_this getVariable["OT_talking",false]) and isNull (findDisplay 8001) and isNull (findDisplay 8002)};
			_this enableAI "PATH";
		};		
	}else{
		ctrlEnable [1605,false];
		ctrlEnable [1606,false];
		ctrlSetText [1605,"Give Money"];
		_type = "Player";
	};
	_civTxt = format["
		<t align='left' size='0.9'>%1</t><br/>
		<t align='left' size='0.8'>%2</t><br/>
	",_name,_type];	
}else{
	ctrlEnable [1605,false];
	ctrlEnable [1606,false];
	ctrlEnable [1607,false];	
};

_civtxtctrl ctrlSetStructuredText parseText _civTxt;