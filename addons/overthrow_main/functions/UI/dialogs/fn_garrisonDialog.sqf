createDialog "OT_dialog_garrison";
disableSerialization;

_b = player call OT_fnc_nearestRealEstate;
_name = "Base";
if(typename _b isEqualTo "ARRAY") then {
	if(typeof (_b select 0) isEqualTo OT_flag_IND) then {
        _name = "";
        {
            if((_x select 0) distance (_b select 0) < 10) exitWith {_name = _x select 1};
        }foreach(server getVariable ["bases",[]]);
    };
}else{
    _ob = (position player) call OT_fnc_nearestObjective;
	_name = _ob select 1;
};

_textctrl = (findDisplay 9000) displayCtrl 1100;
_textctrl ctrlSetStructuredText parseText format["<t size='1.5' align='center'>%1</t>",_name];

_btn = (findDisplay 9000) displayCtrl 1600;
_soldier = ((OT_Recruitables select 0) select 0) call OT_fnc_getSoldier;
_btn ctrlSetTooltip format["$%1",[_soldier select 0, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1601;
_soldier = ((OT_Recruitables select 1) select 0) call OT_fnc_getSoldier;
_btn ctrlSetTooltip format["$%1",[_soldier select 0, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1602;
_soldier = ((OT_Recruitables select 12) select 0) call OT_fnc_getSoldier;
_btn ctrlSetTooltip format["$%1",[_soldier select 0, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1603;
_soldier = ((OT_Recruitables select 8) select 0) call OT_fnc_getSoldier;
_btn ctrlSetTooltip format["$%1",[_soldier select 0, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1604;
_soldier = ((OT_Recruitables select 9) select 0) call OT_fnc_getSoldier;
_btn ctrlSetTooltip format["$%1",[_soldier select 0, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1605;
_soldier = ((OT_Recruitables select 10) select 0) call OT_fnc_getSoldier;
_btn ctrlSetTooltip format["$%1",[_soldier select 0, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1606;
_cost = [OT_nation,"I_HMG_01_high_weapon_F",0] call OT_fnc_getPrice;
_cost = _cost + ([OT_nation,"CIV",0] call OT_fnc_getPrice);
_cost = _cost + 300;
_btn ctrlSetTooltip format["$%1",[_cost, 1, 0, true] call CBA_fnc_formatNumber];

_btn = (findDisplay 9000) displayCtrl 1607;
_cost = [OT_nation,"I_GMG_01_high_weapon_F",0] call OT_fnc_getPrice;
_cost = _cost + ([OT_nation,"CIV",0] call OT_fnc_getPrice);
_cost = _cost + 300;
_btn ctrlSetTooltip format["$%1",[_cost, 1, 0, true] call CBA_fnc_formatNumber];
