private["_uid", "_onoff"];

_uid = [_this,0,"",[""]] call BIS_fnc_param;
_onoff = [_this,1,"",[""]] call BIS_fnc_param;

if(_onoff == 0) then {
	_query = format["UPDATE players SET online=0 WHERE playerid='%1'",_uid];
	diag_log "PLAYER SET ONLINE 2";
} else {
	_query = format["UPDATE players SET online=1 WHERE playerid='%1'",_uid];
	diag_log "PLAYER SET ONLINE 3";
};
waitUntil {sleep (random 0.3); !DB_Async_Active};
_queryResult = [_query,1] call DB_fnc_asyncCall;