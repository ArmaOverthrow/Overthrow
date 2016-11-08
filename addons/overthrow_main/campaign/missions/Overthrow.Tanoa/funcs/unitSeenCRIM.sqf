if((vehicle _this) != _this) then {_this = vehicle _this};
({((_x select 2)==east) and ((time - (((_x select 4) targetKnowledge _this) select 2)) < 10)} count (_this nearTargets 500)) > 0