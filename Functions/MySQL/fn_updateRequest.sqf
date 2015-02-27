/*
	File: fn_updateRequest.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Ain't got time to describe it, READ THE FILE NAME!
*/
private["_uid","_side","_cash","_bank","_licenses","_gear","_name","_query","_thread","_playtime"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_side = [_this,2,sideUnknown,[civilian]] call BIS_fnc_param;
_cash = [_this,3,0,[0]] call BIS_fnc_param;
_bank = [_this,4,5000,[0]] call BIS_fnc_param;
_drug = [_this,5,0,[0]] call BIS_fnc_param;
_addiction = [_this,6,[],[[]]] call BIS_fnc_param;
_licenses = [_this,7,[],[[]]] call BIS_fnc_param;
_gear = [_this,8,[],[[]]] call BIS_fnc_param;

//Get to those error checks.
if((_uid == "") OR (_name == "")) exitWith {};

//Parse and setup some data.
_name = [_name] call DB_fnc_mresString;
_gear = [_gear] call DB_fnc_mresArray;
_addiction = [_addiction] call DB_fnc_mresArray;
_cash = [_cash] call DB_fnc_numberSafe;
_bank = [_bank] call DB_fnc_numberSafe;



//Does something license related but I can't remember I only know it's important?
for "_i" from 0 to count(_licenses)-1 do {
	_bool = [(_licenses select _i) select 1] call DB_fnc_bool;
	_licenses set[_i,[(_licenses select _i) select 0,_bool]];
};

_licenses = [_licenses] call DB_fnc_mresArray;
_playtime = [_uid] call life_fnc_getPlayTime;


switch (_side) do {
	case west: {_query = format["UPDATE players SET name='%1', cash='%2', bankacc='%3', cop_gear='%4', cop_licenses='%5', playtime='%7', druglevel='%8', drugaddiction='%9' WHERE playerid='%6'",_name,_cash,_bank,_gear,_licenses,_uid,_playtime,_drug,_addiction];};
	case civilian: {_query = format["UPDATE players SET name='%1', cash='%2', bankacc='%3', civ_licenses='%4', civ_gear='%6', arrested='%7', playtime='%8', druglevel='%9', drugaddiction='%10' WHERE playerid='%5'",_name,_cash,_bank,_licenses,_uid,_gear,[_this select 7] call DB_fnc_bool,_playtime,_drug,_addiction];};
	case independent: {_query = format["UPDATE players SET name='%1', cash='%2', bankacc='%3', med_licenses='%4', med_gear='%6', playtime='%7', druglevel='%8', drugaddiction='%9' WHERE playerid='%5'",_name,_cash,_bank,_licenses,_uid,_gear,_playtime,_drug,_addiction];};
	case east: {_query = format["UPDATE players SET name='%1', cash='%2', bankacc='%3', arc_licenses='%4', arc_gear='%6' WHERE playerid='%5'",_name,_cash,_bank,_licenses,_uid,_gear];};	
};

waitUntil {sleep (random 0.3); !DB_Async_Active};
_queryResult = [_query,1] call DB_fnc_asyncCall;