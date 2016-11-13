private ["_shops","_active","_posTown"];

_town    = _this select 0;
_posTown = server getVariable _town;
_stability = server getVariable format["stability%1",_town];
_shops   = 0;
_active  = [];

private _churches = nearestObjects [_posTown, OT_churches, 700];
if(count _churches > 0) then {
	server setVariable [format["churchin%1",_town],getpos (_churches select 0),true];	
};

{  
    if !(_x call hasOwner) then {
        //spawn any main shops
        if((random 120 < _stability)) then {
            _shops        = _shops + 1;
            _stock        = [];
            _itemsToStock = [];
            
            _numitems     = floor(random 6) + 4;
            _count        = 0;
            
            while {_count < _numitems} do {
                _item = (OT_allItems - OT_illegalItems - OT_consumableItems) call BIS_Fnc_selectRandom;
                if!(_item in _itemsToStock) then {
                    _itemsToStock pushback _item;
                    _count = _count + 1;
                };          
            };
            
            //1 Backpack
            _item = (OT_allBackpacks) call BIS_Fnc_selectRandom;
            _itemsToStock pushback _item;       
            
            {
                _num = floor(random 5) + 1;         
                _stock pushBack [_x,_num];
            }foreach(_itemsToStock);
            {
                _num = floor(random 20) + 10;           
                _stock pushBack [_x,_num];
            }foreach(OT_consumableItems);
            
            _active pushback [(getpos _x),_stock];
        };
    };
}foreach(nearestObjects [_posTown, OT_shops, 700]);

server setVariable [format["shopsin%1",_town],_shops,true];
server setVariable [format["activeshopsin%1",_town],_active,true];
_active = [];
{   
    if !(_x call hasOwner) then {
        if((random 100) > 60) then {
			_bdgid = [_x] call fnc_getBuildID;
            _pos   = getpos _x;
            _stock = [];
            {
                _cost = cost getVariable _x;
                _base = _cost select 0;
                
                _max = 20;
                if(_base > 40) then {
                    _max = 5;
                };        
				if(_x in OT_allBackpacks) then {
					_max = 2;
				};
                
                _num = floor(random _max);
                if(_x in OT_consumableItems) then {
                    _num = floor(_num * 2);
                };
                if(_num > 0) then {
                    _stock pushBack [_x,_num];
                };
            }foreach(OT_allItems + OT_allBackpacks);
            server setVariable [format["garrison%1",_bdgid],2 + round(random 4),true];
            _active pushback [(getpos _x),_stock];
        };
    };
}foreach(nearestObjects [_posTown, OT_warehouses, 700]);
server setVariable [format["activedistin%1",_town],_active,true];