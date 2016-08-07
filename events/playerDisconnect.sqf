_me = _this select 0;
_uid = _this select 2;

_data = [];

{
	_data pushback [_x,_me getVariable _x];
}foreach(allVariables _me);

server setVariable [_uid,_data,false];