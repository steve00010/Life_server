if (typename _this == "OBJECT") then {
    _plyrObj = _this;
    if (!isNull _plyrObj) then {
        _plyrUID = getPlayerUID _plyrObj;
        if (_plyrUID != "") then {
            _response = ["Player", _plyrUID] call EPOCH_server_hiveGET;
            _dead = false;
            _arr = [];
            if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
                _arr = (_response select 1);
            };
            if (count _arr < 11) then {
                _dead = true;
            } else {
                _medical = _arr select 1;
                _vars = _arr select 4;
                _hitpoints = _vars select 11;
                _deadPlayer = ["PlayerStats", _plyrUID, 0] call EPOCH_server_hiveGETBIT;
                if (_deadPlayer || (_medical select 3 == 1) || (_hitpoints select 2 == 1) || (_hitpoints select 3 == 1) || (_vars select 12 >= 180)) then {
                    _dead = true;
                };
            };
            EPOCH_checkPlayer_PVC = _dead;
            (owner _plyrObj) publicVariableClient "EPOCH_checkPlayer_PVC";
            if (!_dead) then {
                [_plyrObj, true] call EPOCH_server_loadPlayer;
            };
        };
    };
};