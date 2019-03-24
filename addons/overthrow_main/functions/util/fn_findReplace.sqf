/*
	Author: Terra
  Link: https://forums.bohemia.net/forums/topic/203623-function-replace-string/

	Description:
	 Substitute a certain part of a string with another string.

	Parameters:
	1: STRING - Source string
	2: STRING - Part to edit
		* ARRAY OF STRINGS - Multiple parts to edit
	3: STRING - Substitution
	4: (Optional) NUMBER - maximum substitutions
		* Default: 10
	5: (Optional) CASE - Enable maximum limit of substitutions (WARNING: Substituting an expression with the same expression will lead to infinite loops)
		* Default: true

	Returns: STRING
*/
params ["_str", "_toFind", "_subsitution", ["_numLimit",10,[1]], ["_limit",true,[true]]];
  if !(_toFind isEqualType []) then {_toFind = [_toFind]};
  {
      _char = count _x;
      _no = _str find _x;
      private _loop = 0;
      while {-1 != _str find _x && _loop < _numLimit} do {
          _no = _str find _x;
          _splitStr = _str splitString "";
          _splitStr deleteRange [(_no +1), _char -1];
          _splitStr set [_no, _subsitution];
          _str = _splitStr joinString "";
          if (_limit) then {_loop = _loop +1;};
      };
  } forEach (_toFind);
  _str
