/*
File: fn_getPrices.sqf
Author: Worldtrade1101

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
/*if(!isNull _unit) then
{
[[[]],"life_fnc_impoundMenu",(owner _unit),false] spawn life_fnc_MP;
}; */
};

_unit = owner _unit;


_query = switch (_data) do {



case "market" :{ "name"};
case "heroin" :{ "name"};
case "rebel" :{ "rebel"};
case "fishmarket" :{ "name"};
case "wongs" :{ "name"};
case "oil" :{ "name"};
case "cop" :{ "name"};
case "diamond" :{ "name"};
case "iron" :{ "name"};
case "glass" :{ "name"};
case "salt" :{ "name"};
case "cement" :{ "name"};
case "gold" :{ "name"};
case "bar" :{ "name"};
case "organ" :{ "name"};
case "gang" :{ "rebel"};
case "economy" :{ "economy"};
default {"Error"};
};


{
	if(_query == "name") {
		if(_x select 1 == _data) {
			_queryResult pushback [_x select 0, _x select 3,_x select 4];
		}
	}
	if(_query == "rebel") {	
		if(_x select 1 == _data OR _x select 1 == "rebel" ) {
			_queryResult pushback [_x select 0, _x select 3,_x select 4];
		}
	}
	if(_query == "economy") {
		_queryResult pushback [_x select 0, _x select 3,_x select 4];
	}

} forEach life_economy;
if (_data == "economy") exitwith {[[_type,_queryResult],"life_fnc_virt_updateEconomy",_unit,false] spawn life_fnc_MP;};

[[_type,_queryResult],"life_fnc_virt_updateprice",_unit,false] spawn life_fnc_MP;