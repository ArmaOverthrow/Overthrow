params ["_pos"];

spawner setVariable ["GUERradarPositions",(spawner getVariable ["GUERradarPositions",[]]) + [_pos],true];
