params ["_unit","_danger"];
_danger params ["_dangercause","_dangerpos","_dangeruntil","_dangercausedby"];

/*
DEFINE_ENUM_BEG(DangerCause)
  0 - DCEnemyDetected, // the first enemy detected
  1 - DCFire, // fire visible
  2 - DCHit, // vehicle hit
  3 - DCEnemyNear, // enemy very close to me
  4 - DCExplosion, // explosion detected
  5 - DCDeadBodyGroup, // dead soldier from my group found
  6 - DCDeadBody, // other dead soldier found
  7 - DCScream // hit soldier screaming
  8 - DCCanFire
  9 - DCBulletClose
DEFINE_ENUM_END(DangerCause)
*/

if (!isNil "OT_deepDebug" && OT_deepDebug) then {
    diag_log format ["DangerCaused: %1", _this];
};
