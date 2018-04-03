//Created on 8/4/2016: Detecting if a unit has a suppressor or not.
_ItemList = weaponsitems _this;
_Return = true;

if (((_ItemList select 0) select 1) isEqualTo "") then {_Return = false;};


_Return