private["_aa", "_ab", "_ac"];
_ab = _this select 0;
_plyr = _this select 2;
_token = _this select 3;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
if (_plyr distance _ab > 20) exitWith {};
if (!isNull _ab) then {
    _ac = _this select 1;
    if (local _ab) then {
        _ab setFuel _ac;
    } else {
        [
            ["fillVehicle", [_ab, _ac]], (owner _ab)
        ] call EPOCH_sendPublicVariableClient;
    };
};