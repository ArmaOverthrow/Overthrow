private _name = _this;
if(_name isEqualTo "Factory") exitWith {[OT_factoryPos,"Factory"]};
_data = [];
{
    if((_x select 1) isEqualTo _name) exitWith {_data = _x};
}foreach(OT_economicData);
_data;
