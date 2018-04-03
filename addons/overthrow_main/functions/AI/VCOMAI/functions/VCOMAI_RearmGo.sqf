//This function is to ensure the AI reaches their ammo objective!!!

_RAU = _this select 0;
_RL = _this select 1;

while {(_RAU distance _RL) > 5 && (_RAU distance _RL) < 100} do
{
	_RAU domove (getpos _RL);
	sleep 4;
};

	_RAU action ["rearm", _RL];