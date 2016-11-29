private ["_id","_pos","_building","_tracked","_vehs","_group","_all","_shopkeeper","_groups"];

private _hour = date select 3;
private _town = _this;

private _activeshops = server getVariable [format["activeshopsin%1",_town],[]];

if(count _activeshops > 0) exitWith {
	

	private _groups = [];
		
	{
		private _pos = _x select 0;
		_building = nearestBuilding _pos;
		
		private _group = createGroup civilian;
		_group setBehaviour "CARELESS";
		_groups pushback _group;
		private _start = _building buildingPos 0;
		_shopkeeper = _group createUnit [OT_civType_shopkeeper, _start, [],0, "NONE"];
		
		private _tracked = _building call spawnTemplate;
		private _vehs = _tracked select 0;
		{
			_groups pushback _x;
		}foreach(_vehs);
		
		_cashdesk = _pos nearestObject OT_item_ShopRegister;
		
		_dir = getDir _cashdesk;
		_cashpos = [getpos _cashdesk,1,_dir] call BIS_fnc_relPos;		
		
		_shopkeeper allowDamage false;
		_shopkeeper disableAI "MOVE";
		_shopkeeper disableAI "AUTOCOMBAT";
		_shopkeeper setVariable ["NOAI",true,false];

		_shopkeeper setDir (_dir-180);	
		
		_shopkeeper remoteExec ["initShopLocal",0,_shopkeeper];
		_shopkeeper setVariable ["shop",format["%1",_pos],true];
		[_shopkeeper] call initShopkeeper;	
		
		//Put a light on
		_light = "#lightpoint" createVehicle [_pos select 0,_pos select 1,(_pos select 2)+2.2];
		_light setLightBrightness 0.13;
		_light setLightAmbient[.9, .9, .6];
		_light setLightColor[.5, .5, .4];
		_groups pushback _light;			
		
	}foreach(_activeshops);
	_groups
};

[]