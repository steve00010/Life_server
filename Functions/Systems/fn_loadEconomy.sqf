/*
File: fn_loadEconomy.sqf
Author: Steve

Description:
Send a query to retrieve the price of stuff on the server
*/
private["_type","_side","_data","_unit","_ret","_tickTime","_queryResult"];
_type = [_this,0,0,[0]] call BIS_fnc_param;
_unit = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
_data= [_this,2,"",[""]] call BIS_fnc_param;


//Error checks

diag_log format ["%1   %2    %3",_unit,_type,_data];
if( (_data == "") OR (isNull _unit)) exitWith
{

diag_log "data ou type ou unit null";
};

_unit = owner _unit;


_query = "SELECT ressource, buyprice, sellprice, shoptype,factor, varprice, minprice, maxprice FROM economy";



if(_query == "Error") exitWith {
diag_log "error";
};

waitUntil{sleep (random 0.3); !DB_Async_Active};
_tickTime = diag_tickTime;
_queryResult = [_query,2,true] call DB_fnc_asyncCall;

diag_log "------------- Client Query Request -------------";
diag_log format["QUERY: %1",_query];
diag_log format["Time to complete: %1 (in seconds)",(diag_tickTime - _tickTime)];
diag_log format["Result: %1",_queryResult];
diag_log "------------------------------------------------";

{
	_resource = _queryResult select 0;
	_buyprice = _queryResult select 1;
	_sellprice = _queryResult select 2;
	_shoptype = _queryResult select 3;
	_factor = _queryResult select 4;
	_varprice = _queryResult select 5;
	_minprice = _queryResult select 6;
	_maxprice = _queryResult select 7;
	life_economy pushBack [_resource,_factor,_shoptype,_buyprice,_sellprice,_varprice,_minprice,_maxprice];

} forEach _queryResult;

