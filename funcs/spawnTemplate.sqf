private ["_building","_pos","_rel","_DCM","_o","_dir","_bdir","_vdir","_template","_objects","_type"];

_building = _this;
_template = templates getVariable typeOf(_building);

if(isNil "_template") exitWith {hint format["Error: no template for %1",typeOf(_building)];[[]]};


_buildingpos = getposatl _building;

_offset = [0,0,0];
_buildingpos = [(_buildingpos select 0)+(_offset select 0),(_buildingpos select 1)+(_offset select 1),(_buildingpos select 2)+(_offset select 2)];
_bdir = getDir _building;
_vdir = vectorDir _building;

_objects = [];
//_objects = [_buildingpos,_dir,_template,0] call BIS_fnc_ObjectsMapper;

{
	_type = _x select 0;
	_rel = _x select 1;
	_dir = (_x select 2);
	
	_DCM = _building call rotationMatrix;
	
	//Transform the relative position of this item by the rotation matrix of the building (yes, this is the furniture spawning magic you were looking for, enjoy)	
	//we need to rotate the relative position 90 degrees around Z first for some reason (I guess BIS vectorDirs are rotated 90)	
	//_rel = [(_rel select 1) * -1,(_rel select 0),_rel select 2];
	_rel = [_DCM,_rel] call matrixRotate;
	
	_pos = [(_buildingpos select 0)+(_rel select 0),(_buildingpos select 1)+(_rel select 1),(_buildingpos select 2)+(_rel select 2)];

	_o = _type createVehicle _pos;
	_o setPos _pos;
	_dir = _dir + _bdir;
	if(_dir > 359) then {
		_dir = _dir - 360;
	};
	_o setVectorDir _vdir;
	_o setDir _dir;

	clearWeaponCargoGlobal _o;
	clearMagazineCargoGlobal _o;
	clearBackpackCargoGlobal _o;
	clearItemCargoGlobal _o;	
	
	_objects pushBack _o;
}foreach(_template);

_building setVariable ["furniture",_objects,true];

[_objects];
