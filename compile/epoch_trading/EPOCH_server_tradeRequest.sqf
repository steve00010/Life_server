private["_aa", "_ab", "_ac"];
_aa = _this select 0;
_ab = _this select 1;
_ac = _this select 2;
if !([_ab, _ac] call EPOCH_server_getPToken) exitWith {};
if (isNull _aa) exitWith {};
if (_ab distance _aa > 10) exitWith {};
[
    ["tradeRequest", _ab], (owner _aa)
] call EPOCH_sendPublicVariableClient;