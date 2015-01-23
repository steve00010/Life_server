private ["_time"];

_time = [_this select 0] spawn life_fnc_getPlayTime;


[[_time],"SOCK_fnc_moneyCheck",_this select 1,false] spawn life_fnc_MP;