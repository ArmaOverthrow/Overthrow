private _sn = str (_this select 0) splitString " ";
private _id = (_sn select 1);

_id select [0,count _id - 1];
