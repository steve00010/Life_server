_unit = _this select 0;
_plyr = _this select 1;
_token = _this select 2;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _unit) exitWith {};
if (_plyr distance _unit > 20) exitWith {};
if (typeOf _unit == "Jack_SIM_EPOCH") then {
    deleteVehicle _unit;
    _plyr addMagazine["JackKit", 1];
    diag_log format["added JackKit to %1", _plyr];
};