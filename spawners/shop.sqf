private ["_id","_pos","_building","_tracked","_vehs","_group","_all","_shopkeeper","_groups"];

_hour = date select 3;
_town = _this;
_activeshops = server getVariable [format["activeshopsin%1",_town],[]];

_group = createGroup civilian;
_group setBehaviour "CARELESS";	

_groups = [_group];
	
{
	_pos = _x select 0;
	_building = nearestBuilding _pos;
	
	_tracked = _building call spawnTemplate;
	sleep 0.1;
	_vehs = _tracked select 0;
	{
		_groups pushback _x;
	}foreach(_vehs);
	
	_cashdesk = _pos nearestObject AIT_item_ShopRegister;
	_cashpos = [getpos _cashdesk,1,getDir _cashdesk] call BIS_fnc_relPos;
	
	if(_hour > 8 and _hour < 22) then {
		//Shop is open, spawn shopkeeper		
		_shopkeeper = _group createUnit [AIT_civType_shopkeeper, _cashpos, [],0, "NONE"];
		_shopkeeper disableAI "MOVE";		
		_shopkeeper remoteExec ["initShopLocal",0,true];
		_shopkeeper setVariable ["shop",format["%1",_pos],true];
		[_shopkeeper] call initShopkeeper;	
		
		if((_hour > 18 and _hour < 22) or (_hour < 9 and _hour > 5)) then {
			//Put a light on
			sleep 0.1;
			_pos = getpos _building;
			_light = "#lightpoint" createVehicle [_cashpos select 0,_cashpos select 1,(_cashpos select 2)+2.2];
			_light setLightBrightness 0.11;
			_light setLightAmbient[.9, .9, .6];
			_light setLightColor[.5, .5, .4];
			_vehs pushback _light;				
		};		
	};
	
}foreach(_activeshops);

_groups