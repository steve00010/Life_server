private["_aa", "_ab"];
_aa = _this select 0;
_player = _this select 2;
_token = _this select 3;
if (isNull _aa || isNull _player) exitWith {};
if !([_player, _token] call EPOCH_server_getPToken) exitWith {};
if (_player distance _aa > 20) exitWith {};
_plyrUID = getPlayerUID _player;
_plyrGroup = _player getVariable["GROUP", ""];
_lockOwner = _plyrUID;
if (_plyrGroup != "") then {
    _lockOwner = _plyrGroup;
};
if ((_aa getVariable["LOCK_OWNER", "-1"] == _lockOwner) || (_aa getVariable["LOCKED_TILL", serverTime] <= serverTime)) then {
    _ab = _this select 1;
    if (_ab) then {
        _aa setVariable["LOCK_OWNER", _lockOwner];
        _aa setVariable["LOCKED_TILL", serverTime + EPOCH_vehicleLockTime];
    };
    if (local _aa) then {
        _aa lock _ab;
    } else {
        if (_ab) then {
            [
                ["lockVehicle", _aa], (owner _aa)
            ] call EPOCH_sendPublicVariableClient;
        } else {
            [
                ["unlockVehicle", _aa], (owner _aa)
            ] call EPOCH_sendPublicVariableClient;
        };
    };
};