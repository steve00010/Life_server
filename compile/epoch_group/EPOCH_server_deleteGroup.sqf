private["_player", "_token", "_groupID", "_response"];
_player = _this select 0;
_token = _this select 1;
if !([_player, _token] call EPOCH_server_getPToken) exitWith {};
_groupID = getPlayerUID _player;
diag_log format["GROUP: Delete %1", _this];
_response = ["Group", _groupID] call EPOCH_server_hiveGET;
if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
    {
        if ((_x getVariable["GROUP", ""]) == _groupID) exitWith {
            {
                _x setVariable["GROUP", nil];
                [
                    ["resetGroup", true], (owner _x)
                ] call EPOCH_sendPublicVariableClient;
                [_x] joinSilent(createGroup west);
            }
            forEach(units group _x);
        };
    }
    forEach playableUnits;
    ["Group", _groupID] call EPOCH_server_hiveDEL;
};
true