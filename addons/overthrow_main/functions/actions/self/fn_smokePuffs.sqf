params ["_unit"];

private _source = "logic" createVehicleLocal (getPos _unit);
private _fog = "#particleSource" createVehicleLocal getPos _source;
_fog setParticleParams ["\A3\data_f\cl_basic",
"",
"Billboard",
0.5,
2,
[0,0,0],
[0, 0.1, -0.1],
1, 1.2, 1, 0.1,
[0.1, 0.2,0.1],
[[0.2,0.2,0.2, 0.3], [0,0,0, 0.01], [1,1,1, 0]],
[500],
1,
0.04,
"",
"",
_source];
_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
_fog setDropInterval 0.005;

_source attachTo [_unit, [0,0.06,0], "head"];
sleep 0.4;

deleteVehicle _source;