if((vehicle _this) != _this) then {_this = vehicle _this};

{
    (_x distance _this < 7) or
    ((time - ((_x targetKnowledge _this) select 2)) < 10)
}count (call CBA_fnc_players) > 0;
