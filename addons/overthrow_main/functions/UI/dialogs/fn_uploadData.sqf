if (dialog) then {
  closeDialog 0;
};

createDialog "OT_dialog_upload";

params [
  ["_data","ERROR"],
  ["_editBox",((findDisplay 49558) displayCtrl 1)],
  ["_legalText",((findDisplay 49558) displayCtrl 5)],
  ["_cancelButton",((findDisplay 49558) displayCtrl 9)],
  ["_uploadButton",((findDisplay 49558) displayCtrl 10)]
];

if (_data isEqualTo "ERROR") exitWith {
  closeDialog 0;
  diag_log "UPLOAD DIALOG encountered an error with data transmited";
};

_editData = str _data;
[_editData,"<NULL-object>","objNull"] call OT_fnc_findReplace;

_editBox ctrlSetText _editData;
_editBox ctrlSetTooltip "Copy & Paste this data to load from a string.";

_legalText ctrlSetStructuredText parseText format["<t font='PuristaMedium'>The Arma 3 Overthrow Development team care about transparency and their user's privacy. When you upload your mission using this function <t font='PuristaBold'>ONLY</t> the above data will be sent and saved to the server. Your Steam 64 ID <t font='PuristaBold'>(%1)</t> will be used to uniquely identify your saved data. This <t font='PuristaBold'>will be visible</t> to other users who use the website to view currently available saves. No data will be encrypted or obfuscated at any time.<br/><t font='PuristaBold' color='#FF0000'>Due to the nature of online hosting, the Overthrow Development Team cannot guarantee the longevity of this feature.<br/>The Overthrow Development Team reserves the right to: restrict users access, remove any data at any time for any reason without warning, shut down the online portion of this feature without warning.</t><br/>Please read through the data closely and make sure you are aware of all the data being transmitted then click ""I CONSENT"" below to agree and upload your save.</t>",getPlayerUID player];
[_legalText] call BIS_fnc_ctrlFitToTextHeight;
