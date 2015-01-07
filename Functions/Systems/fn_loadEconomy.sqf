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
	_resource = _x select 0;
	_buyprice = _x select 1;
	_sellprice = _x select 2;
	_shoptype = _x select 3;
	_factor = _x select 4;
	_varprice = _x select 5;
	_minprice = _x select 6;
	_maxprice = _x select 7;
	life_economy pushBack [_resource,_factor,_shoptype,_buyprice,_sellprice,_varprice,_minprice,_maxprice];
	diag_log format["RES: %1",_resource];
} forEach _queryResult;

diag_log format["ECON: %1",life_economy];