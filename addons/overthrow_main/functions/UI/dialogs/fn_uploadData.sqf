if (dialog) then {
  closeDialog 0;
};

createDialog "OT_dialog_upload";

params [
  ["_data","ERROR"],
  ["_editBox",((findDisplay 49558) displayCtrl 1)],
  ["_legalText",((findDisplay 49558) displayCtrl 5)]
];

if (_data isEqualTo "ERROR") exitWith {
  closeDialog 0;
  diag_log "UPLOAD DIALOG encountered an error with data transmited";
};

_editData = str _data;
_editData = [_editData,"<NULL-object>","objNull"] call OT_fnc_findReplace;
_editData = [_editData,",any]",",nil]"] call OT_fnc_findReplace;

_editBox ctrlSetText _editData;
_editBox ctrlSetTooltip "Copy & Paste this data to load from a string.";

_legalText ctrlSetStructuredText parseText format["<t font='PuristaMedium'>Use the data above to share your save or externally backup your mission.<br/>To load a mission from this data copy and paste it into the text box provided when selecting 'Load Game' in the mission menu. This data does contain your Steam ID and can be used to identify you.</t>",getPlayerUID player];
[_legalText] call BIS_fnc_ctrlFitToTextHeight;
