_handled = false;

_key = _this select 1;
if (_key == 21) then
{
	closedialog 0;			
	_nul = createDialog "AIT_dialog_main";
	_handled = true;
}
else
{
	if (_key == 207 and !AIT_hasAce) then
	{		
		if (soundVolume <= 0.5) then
		{
			0.5 fadeSound 1;
			hintSilent "You've taken out your ear plugs.";
		}
		else
		{
			0.5 fadeSound 0.1;
			hintSilent "You've inserted your ear plugs.";
		};
		_handled = true;
	};	
};
_handled