/*
	File: fn_wantedRemove.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Removes a person from the wanted list.
*/
private["_uid","_index","_query","_queryResult","_result"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
if(_uid == "") exitWith {}; //Bad data

_index = [_uid,life_wanted_list] call TON_fnc_index;
if(_index != -1) then
{
	life_wanted_list set[_index,-1];
	life_wanted_list = life_wanted_list - [-1];
};

diag_log format["WANTED_LIST = %1", life_wanted_list];
_query = format["DELETE from wanted WHERE pid='%1';",_uid];


waitUntil {sleep (random 0.3); !DB_Async_Active};_queryResult = [_query,1] call DB_fnc_asyncCall;