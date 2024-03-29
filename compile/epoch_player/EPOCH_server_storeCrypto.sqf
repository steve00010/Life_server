private["_pos", "_veh", "_crypto2", "_plyr"];
_plyr = _this select 0;
_tradeArray = _this select 1;
_token = _this select 2;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
_plyrUID = getPlayerUID _plyr;
_response = ["Bank", _plyrUID] call EPOCH_server_hiveGET;
if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
    _plyrNetID = owner _plyr;
    _bankData = _response select 1;
    _bankBalance = 0;
    _bankBalanceBefore = 0;
    if !(_bankData isEqualTo[]) then {
        _bankBalance = _bankData select 0;
        _bankBalanceBefore = _bankBalance;
    };
    if (_tradeArray isEqualTo[]) then {
        [
            ["bankBalance", _bankBalance], _plyrNetID
        ] call EPOCH_sendPublicVariableClient;
    } else {
        _transferAmountIn = _tradeArray select 0;
        _transferAmountOut = _tradeArray select 1;
        _transferBalance = _tradeArray select 2 select 0;
        _transferTarget = objectFromNetId(_tradeArray select 2 select 1);
        if (_transferAmountIn > 0) then {
            _cIndex = EPOCH_customVars find "Crypto";
            _current_crypto = (_plyr getVariable["VARS", EPOCH_defaultVars_SEPXVar]) select _cIndex;
            diag_log format["Store: _current_crypto: %1 _cIndex:%2", _current_crypto, _cIndex];
            if (_current_crypto >= _transferAmountIn) then {
                _bankBalance = _bankBalance + _transferAmountIn;
                [
                    ["effectCrypto", -_transferAmountIn], _plyrNetID
                ] call EPOCH_sendPublicVariableClient;
            };
        };
        if (_transferAmountOut > 0) then {
            if (_bankBalance >= _transferAmountOut) then {
                _bankBalance = _bankBalance - _transferAmountOut;
                [
                    ["effectCrypto", _transferAmountOut], _plyrNetID
                ] call EPOCH_sendPublicVariableClient;
            };
        };
        if (!(isNull _transferTarget) && _bankBalance >= _transferBalance) then {
            if (_transferBalance > 0) then {
                _transferTargetUID = getPlayerUID _transferTarget;
                _transferResponse = ["Bank", _transferTargetUID] call EPOCH_server_hiveGET;
                if ((_transferResponse select 0) == 1 && typeName(_transferResponse select 1) == "ARRAY") then {
                    _transferBankData = _transferResponse select 1;
                    _transferBankBalance = 0;
                    _transferBankBalanceBefore = 0;
                    if !(_transferBankData isEqualTo[]) then {
                        _transferBankBalance = _transferBankData select 0;
                        _transferBankBalanceBefore = _transferBankBalance;
                    };
                    _bankBalance = _bankBalance - _transferBalance;
                    _transferBankBalance = _transferBankBalance + _transferBalance;
                    if (_transferBankBalanceBefore != _transferBankBalance) then {
                        _return = ["Bank", _transferTargetUID, EPOCH_expiresPlayer, [_transferBankBalance]] call EPOCH_server_hiveSETEX;
                        [
                            ["bankBalance", _transferBankBalance], (owner _transferTarget)
                        ] call EPOCH_sendPublicVariableClient;
                    };
                };
            };
        };
        if (_bankBalanceBefore != _bankBalance) then {
            _return = ["Bank", _plyrUID, EPOCH_expiresBank, [_bankBalance]] call EPOCH_server_hiveSETEX;
        };
    };
};
diag_log format["BANK: %1 (%2) TRADE: %3", _plyr, _plyrUID, _tradeArray];