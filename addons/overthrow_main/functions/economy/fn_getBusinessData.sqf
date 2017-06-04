private _name = _this;
if(_name == "Factory") exitWith {[OT_factoryPos,"Factory"]};
_data = [];
{
    if((_x select 1) == _name) exitWith {_data = _x};
}foreach(OT_economicData);
_data;
