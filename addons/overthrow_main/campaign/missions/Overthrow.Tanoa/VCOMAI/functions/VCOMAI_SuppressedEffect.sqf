private ["_DynBlur", "_FlmGr", "_cc"];

player setCustomAimCoef VCOM_SuppressionVar;
player spawn {sleep 8; player setCustomAimCoef 1;};

if (VCOM_Adrenaline) then
{
	player setAnimSpeedCoef VCOM_AdrenalineVar;
	player spawn {sleep 8; _this setAnimSpeedCoef 1;};
};

_DynBlur = ppEffectCreate ["DynamicBlur", 5];
_DynBlur ppEffectAdjust [0.5]; 
_DynBlur ppEffectEnable true; 
_DynBlur ppEffectCommit 0; 

_FlmGr = ppEffectCreate ["FilmGrain", 2000]; 
_FlmGr ppEffectAdjust [0.1,0.05,1,0.1,0.5,true]; 
_FlmGr ppEffectEnable true; 
_FlmGr ppEffectCommit 0; 

_cc = ppEffectCreate ["ColorCorrections", 1505]; 
_cc ppEffectAdjust [0.2, 1.0, 0.0, [0, 0, 0, 0], [0, 0, 0, 0], [1, 1, 1, 1],[2,2,0,0,0,0.25,0.40]]; 
_cc ppEffectEnable true;  
_cc ppEffectCommit 0.1; 

sleep 5;

_DynBlur ppEffectAdjust [0];
_DynBlur ppEffectCommit 5; 
_cc ppEffectAdjust [1,1,0,0,0,0,0,1,1,1,1,0,0,0,0]; 
_cc ppEffectCommit 5; 
_FlmGr ppEffectAdjust [0,0,0,0,0,true];
_FlmGr ppEffectCommit 0; 

sleep 5;
_FlmGr ppEffectEnable false; 
_DynBlur ppEffectEnable false; 
_cc ppEffectEnable false; 
ppEffectDestroy _FlmGr;
ppEffectDestroy _DynBlur;
ppEffectDestroy _cc;

