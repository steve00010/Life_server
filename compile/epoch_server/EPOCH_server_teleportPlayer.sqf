private["_aa", "_ab", "_ac", "_ad"];
_aa = _this select 0;
_ab = _this select 1;
_token = _this select 2;
if !([_aa, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _ab) exitWith {};
if (_plyr distance _ab > 20) exitWith {};
_tp = _ab getVariable["ParentBuilding", []];
if !(_tp isEqualTo[]) then {
    _aa setPosATL _tp;
};