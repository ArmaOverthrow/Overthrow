private ["_building","_pos","_rel","_DCM","_o","_dir","_bdir","_vdir","_template","_objects","_type"];

_item = _this select 0;
_template = _this select 1;
_heightoffset = ((boundingCenter _item) select 2);

_objects = [];
{
	_cls = _x select 0;
	_pos = _x select 1;
	_dir = _x select 2;

	_pos = [_pos select 0,_pos select 1,(_pos select 2)-_heightoffset];
	_o = _cls createVehicle [0,0,0];
	_ho = ((boundingCenter _o) select 2)-0.001;

	_pos = [_pos select 0,_pos select 1,(_pos select 2)+_ho];
	_o attachTo [_item,_pos];
	_objects pushback _o;
	_o setDir _dir;
}foreach(_template);

_objects
