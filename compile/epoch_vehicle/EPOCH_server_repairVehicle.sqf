private["_aa", "_ab"];
_aa = _this select 0;
_ab = _this select 1;
_plyr = _this select 2;
_token = _this select 3;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _aa) exitWith {};
if (_plyr distance _aa > 20) exitWith {};
if (vehicle _plyr != _plyr) exitWith {};
if ((_ab select 0) == "ALL") then {
    _aa setDamage 0;
} else {
    if (local _aa) then {
        _aa setHitPointDamage _ab;
    } else {
        [
            ["repairVehicle", [_aa, _ab]], (owner _aa)
        ] call EPOCH_sendPublicVariableClient;
    };
};
_aa call EPOCH_server_save_vehicle;