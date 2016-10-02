
_bounties = [];
{
	_bounty = server getVariable [format["CRIMbounty%1",_x],0];
	if(_bounty > 0) then {
		_bounties pushback [_x,_bounty];
	};
}foreach(OT_allTowns);

_toshow = 5;
_count = 1;
_txt = "<t size='0.8' color='#ffffff'>There are currently no bounties</t>";
if(count _bounties > 0) then {
	_sorted = [_bounties,[],{_x select 1},"DESCEND"] call BIS_fnc_sortBy;


	_txt = "<t size='0.8' color='#111111'>Tanoa's Most Wanted</t><br/>";
	{
		if(_count > _toshow) exitWith {};
		_town = _x select 0;
		_bounty = [_x select 1, 1, 0, true] call CBA_fnc_formatNumber;
		_txt = format["%1<br/><t size='0.6' color='#333333'>%2. Gang Leader (%3) $%4</t>",_txt,_count,_town,_bounty];
		_count = _count +1;	
	}foreach(_sorted);
};

[_txt, [safeZoneX + (0.5 * safeZoneW), (0.2 * safeZoneW)], 0.5, 10, 0, 0, 2] spawn bis_fnc_dynamicText;



