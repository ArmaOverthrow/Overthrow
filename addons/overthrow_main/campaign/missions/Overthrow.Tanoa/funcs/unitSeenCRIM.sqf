if((vehicle _this) != _this) then {_this = vehicle _this};
({(side _x==east) and ((time - ((_x targetKnowledge _this) select 2)) < 10)} count (_this nearEntities ["CAManBase",500])) > 0
