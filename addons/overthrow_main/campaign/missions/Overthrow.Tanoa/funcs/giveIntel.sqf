private ["_handled","_player","_civ","_pos","_rnd","_txt"];

private _player = _this select 0;
private _civ = _this select 1;

private _pos = getpos _player;
private _town = _pos call OT_fnc_nearestTown;

private _standing = (_player getvariable format["rep%1",_town]) + (_player getvariable "rep");
private _stability = server getvariable format["stability%1",_town];
private _crimleader = server getvariable format["crimleader%1",_town];
private _gundealer = server getvariable [format["gundealer%1",_town],[]];
private _nearestMob = _pos call OT_fnc_nearestMobster;
private _nearestMobId = _nearestMob select 1;//efdf
private _nearestMobPos = _nearestMob select 0;
private _nearestMobGarrison = server getvariable [format["crimgarrison%1",_nearestMobId],0];

private _garrison = _civ getvariable "garrison";
private _criminal = _civ getvariable "criminal";
private _crimleader = _civ getvariable "crimleader";
private _mobster = _civ getvariable "mobster";
private _mobboss = _civ getvariable "mobboss";

if(side _civ == east) then {_standing = -_standing};
private _rnd = random 100;
private _mrkid = format["gundealer%1",_town];

if((markerType _mrkid == "") and (count(_gundealer) > 0) and (_rnd > 60)) exitWith {
	-1 call influence;
	[_civ,player,["Who are you? and what's with the outfit?","Never you mind","Whatever, I saw a guy wearing similar, he's over there"],{
		"Dealer added to map" call OT_fnc_notifyMinor;
		private _town = player call OT_fnc_nearestTown;
		private _pos = server getvariable format["gundealer%1",_town];
		_mrk = createMarkerLocal [format["gundealer%1",_town],_pos];
		_mrk setMarkerType "ot_Shop";
		_mrk setMarkerColor "ColorGUER";
		_mrk setMarkerAlpha 1;
		_mrk setMarkerShape "ICON";
	}] spawn doConversation;
};

_mrkid = format["mobster%1",_nearestMobId];

if((_nearestMobGarrison > 0) and (markerType _mrkid == "") and (isNil "_mobboss") and (isNil "_mobster") and !(isNil "_crimleader") and (side _civ == east) and (_standing > 10)) exitWith {
	-1 call influence;
	[_civ,player,["This and that","Cool, I'm looking for a place to offload some... stuff","Go and speak to the boss I guess"],{
		"Bandit camp added to map" call OT_fnc_notifyMinor;
		params ["_mobid","_mobpos"];
		_mrk = createMarkerLocal [format["mobster%1",_mobid],_mobpos];
		_mrk setMarkerType "ot_Camp";
		_mrk setMarkerColor "colorOPFOR";
		_mrk setMarkerAlpha 1;
		_mrk setMarkerShape "ICON";
	},[_nearestMobId,_nearestMobPos]] spawn doConversation;
};

if((_nearestMobGarrison > 0) and (markerType _mrkid == "") and (side _civ == civilian) and (_standing >= 0)) exitWith {
	-1 call influence;
	[_civ,player,["I heard there were some bandits camping in the jungle","Really? Where, exactly?"],{
		"Bandit camp added to map" call OT_fnc_notifyMinor;
		params ["_mobid","_mobpos"];
		_mrk = createMarkerLocal [format["mobster%1",_mobid],_mobpos];
		_mrk setMarkerType "ot_Camp";
		_mrk setMarkerColor "colorOPFOR";
		_mrk setMarkerAlpha 1;
		_mrk setMarkerShape "ICON";
	},[_nearestMobId,_nearestMobPos]] spawn doConversation;
};

[_civ,player,["Not much","Cool","k"],{
	"No intel available" call OT_fnc_notifyMinor;
}] spawn doConversation;
