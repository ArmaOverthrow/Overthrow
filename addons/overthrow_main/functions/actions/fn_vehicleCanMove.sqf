private _canMove = true;
{
	if (_this getHitPointDamage _x >= 1) exitWith {
		_canMove = false;
	};
} forEach ["HitLFWheel", "HitLF2Wheel", "HitRFWheel", "HitRF2Wheel", "HitFuel", "HitEngine"];
_canMove