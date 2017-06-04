//Generates a civilian identity [face, clothes, name]
private _glasses = "";
if((random 100) < 35) then {_glasses = selectRandom OT_allGlasses};
[selectRandom OT_faces_local, selectRandom OT_clothes_locals, [round random ((count OT_firstNames_local) - 1),round random ((count OT_lastNames_local) - 1)],_glasses]
