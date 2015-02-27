private["_uid", "_time_gathered", "_time_join","_time"];
_uid =_this select 0;
_time_gathered = -1;
_time_join = -1;
{
	if((_x select 0) == _uid) exitWith
	{
		_time_gathered = _x select 1;
		_time_join = _x select 2;
	};
}
foreach life_playtime_values;
if(_time_gathered < 0 || _time_join < 0) then
{
		_time_gathered = 0;
		_time_join = time;
		life_playtime_values set [count life_playtime_values, [_uid, _time_gathered, _time_join] ];
		diag_log format["Created playtime for player %1", _uid];
};
_time = (time - _time_join); //return time
_time = _time + _time_gathered;
//diag_log format["Calculated playtime for %1 is %2 (already gathered: %3) + (%4 - %5)", _uid, _time, _time_gathered, time, _time_join];
_time