private["_player1", "_player2", "_token", "_trade1", "_trade2", "_tradeOffer1", "_tradeOffer2", "_tradeCryptoOffer1", "_tradeCryptoOffer2", "_overFlowItems"];
_player1 = _this select 0;
_player2 = _this select 1;
_token = _this select 4;
if (isNull _player2) exitWith {};
if !([_player1, _token] call EPOCH_server_getPToken) exitWith {};
if (_player1 distance _player2 > 10) exitWith {};
if ((_player1 getVariable["Accept", false]) && (_player2 getVariable["Accept", false])) then {
    _trade1 = _player1 getVariable["Offer", [
        [], 0
    ]];
    _trade2 = _player2 getVariable["Offer", [
        [], 0
    ]];
    _tradeOffer1 = _trade1 select 0;
    _tradeOffer2 = _trade2 select 0;
    _tradeCryptoOffer1 = _trade1 select 1;
    _tradeCryptoOffer2 = _trade2 select 1;
    _cIndex = EPOCH_customVars find "Crypto";
    _current_crypto1 = (_player1 getVariable["VARS", EPOCH_defaultVars_SEPXVar]) select _cIndex;
    _current_crypto2 = (_player2 getVariable["VARS", EPOCH_defaultVars_SEPXVar]) select _cIndex;
    diag_log format["p2p: _current_crypto1: %1 _current_crypto2: %2 _cIndex:%2", _current_crypto1, _current_crypto2, _cIndex];
    if (_current_crypto1 >= _tradeCryptoOffer1 && _current_crypto2 >= _tradeCryptoOffer2) then {
        if (_tradeCryptoOffer1 > 0) then {
            [
                ["effectCrypto", -_tradeCryptoOffer1], (owner _player1)
            ] call EPOCH_sendPublicVariableClient;
        };
        if !(_tradeOffer2 isEqualTo[]) then {
            _overFlowItems = createVehicle["groundWeaponHolder", getPosATL _player1, [], 0, "CAN_COLLIDE"]; {
                if ([_x, "CfgWeapons"] call EPOCH_isAny) then {
                    _overFlowItems addItemCargoGlobal[_x, 1];
                } else {
                    _overFlowItems addMagazineCargoGlobal[_x, 1];
                };
            }
            forEach _tradeOffer2;
        };
        if (_tradeCryptoOffer2 > 0) then {
            [
                ["effectCrypto", _tradeCryptoOffer2], (owner _player1)
            ] call EPOCH_sendPublicVariableClient;
        };
        diag_log format["ADMIN: P1:%1 P2:%2 In:%3:%4 Out:%5:%6", _player1, _player2, _tradeOffer2, _tradeCryptoOffer2, _tradeOffer1, _tradeCryptoOffer1];
    };
};