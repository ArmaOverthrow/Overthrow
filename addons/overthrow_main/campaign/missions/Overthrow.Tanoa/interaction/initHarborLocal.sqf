_civ = _this;

_civ addAction ["Talk", {OT_interactingWith = (_this select 0);[] spawn talkToCiv},nil,1.5,true,true,"","alive _target",5];