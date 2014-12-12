private["_uid", "_onoff","_query","_queryResult"];

_uid = _this select 0;
_onoff = _this select 1;

diag_log format["%1 %2",_onoff,_uid];


if(_onoff == 0) then {
	_query = format["UPDATE players SET online=0 WHERE playerid='%1'",_uid];
	diag_log "PLAYER SET ONLINE 2";
} else {
	_query = format["UPDATE players SET online=1 WHERE playerid='%1'",_uid];
	diag_log "PLAYER SET ONLINE 3";
};
waitUntil {sleep (random 0.3); !DB_Async_Active};
_queryResult = [_query,1] call DB_fnc_asyncCall;