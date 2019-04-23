if (dialog) then {
  closeDialog 0;
};


private ["_str","_classes","_editBox","_legalText"];
_classes = _this;

_str = "";
{
    if((OT_loadedPrices find _x) == -1) then {
        _str = _str + format["['%1',%2],",_x,str (cost getVariable _x)];
    };
} forEach _classes;

createDialog "OT_dialog_upload";

_editBox = ((findDisplay 49558) displayCtrl 1);
_legalText = ((findDisplay 49558) displayCtrl 5);

_editBox ctrlSetText _str;

_legalText ctrlSetStructuredText parseText format["<t font='PuristaMedium'>For use in /overthrow_main/data/prices.sqf. Will only show items that are not already in the file, so you can append mod items etc.</t>",getPlayerUID player];
[_legalText] call BIS_fnc_ctrlFitToTextHeight;
