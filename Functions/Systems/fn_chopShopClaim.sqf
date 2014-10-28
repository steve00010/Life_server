/*
	File: fn_chopShopClaim.sqf
	Author: Steve 
	
	Description:
	Checks whether or not the vehicle is persistent or temp and claimsit 
*/
private["_unit","_vehicle","_price","_cash","_uid1","_name"];
_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_vehicle = [_this,1,objNull,[objNull]] call BIS_fnc_param;
_price = [_this,2,500,[0]] call BIS_fnc_param;
_cash = [_this,3,0,[0]] call BIS_fnc_param;

//Error checks
if(isNull _vehicle OR isNull _unit) exitWith 
{
	[["life_action_inUse",false],"life_fnc_netSetVar",nil,false] spawn life_fnc_MP;
};

_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
_uid1 = getPlayerUID _unit;
_name = name _unit;
_unit = owner _unit;



_dbInfo = _vehicle getVariable["dbInfo",[]];
if(count _dbInfo > 0) then {
	_uid = _dbInfo select 0;
	_plate = _dbInfo select 1;
	
	_vehicle setVariable["vehicle_info_owners",[[_uid1,_name]],true];
	
	
	_query = format["UPDATE vehicles SET pid='%3',side='civ' WHERE pid='%1' AND plate='%2'",_uid,_plate,_uid1];
	waitUntil {!DB_Async_Active};
	_sql = [_query,1] call DB_fnc_asyncCall;
};


[["life_action_inUse",false],"life_fnc_netSetVar",_unit,false] spawn life_fnc_MP;
[["pbh_life_cash",_cash],"life_fnc_netSetVar",_unit,false] spawn life_fnc_MP;
[[2,format["You have claimed this vehicle!",_displayName,[_price] call life_fnc_numberText]],"life_fnc_broadcast",_unit,false] spawn life_fnc_MP;