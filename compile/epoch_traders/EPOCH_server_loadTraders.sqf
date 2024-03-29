private["_staticTradersArray", "_staticTradersArrCount", "_aiTables", "_staticTrader", "_class", "_pos", "_dir", "_agent", "_randomIndex", "_randomAIUniform", "_arr", "_objHiveKey", "_response", "_marker", "_home", "_work", "_schedule"];
_staticTradersArray = getArray(configFile >> "CfgEpoch" >> worldName >> "staticNpcPos");
_staticTradersArrCount = count _staticTradersArray;
_aiTables = ["U_OG_leader", "U_C_Poloshirt_stripped", "U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite", "U_C_Poor_1", "U_C_WorkerCoveralls", "U_C_Journalist", "U_C_Scientist", "U_OrestesBody"];
EPOCH_storedVehicleCount = 0;
for "_i"
from 0 to _this do {
    if (_staticTradersArrCount > 0 && _i < _staticTradersArrCount) then {
        _staticTrader = _staticTradersArray select _i;
        _class = _staticTrader select 0;
        _pos = _staticTrader select 1;
        _dir = _staticTrader select 2;
        _agent = createAgent[_class, _pos, [], 0, "CAN_COLLIDE"];
        _randomIndex = floor(random(count _aiTables));
        _randomAIUniform = _aiTables select _randomIndex;
        _agent addUniform _randomAIUniform;
        _agent setDir _dir;
        _agent setPosATL _pos;
        _agent setVariable["AI_SLOT", _i, true];
        _agent disableAI "FSM";
        _agent setBehaviour "CARELESS";
        _agent setCombatMode "RED";
        _agent setSkill 0;
        _agent addEventHandler["Killed", {
            _this call EPOCH_server_traderKilled;
        }];
        _arr = [
            [],
            []
        ];
        _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _i];
        _response = ["AI_ITEMS", _objHiveKey] call EPOCH_server_hiveGET;
        if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
            _arr = (_response select 1);
            if (_arr isEqualTo[]) then {
                _arr = [
                    [],
                    []
                ];
            }; {
                if (_x isKindOf "Air" || _x isKindOf "Ship" || _x isKindOf "LandVehicle" || _x isKindOf "Tank") then {
                    EPOCH_storedVehicleCount = EPOCH_storedVehicleCount + ((_arr select 1) select _forEachIndex);
                };
            }
            forEach(_arr select 0);
        };
        _agent setVariable["AI_ITEMS", _arr, true];
        EPOCH_TraderSlots set[_i, 1];
        if (EPOCH_SHOW_TRADERS) then {
            _marker = createMarker[str(_pos), (_pos)];
            _marker setMarkerShape "ICON";
            _marker setMarkerType "mil_dot";
            _marker setMarkerColor "ColorBlack";
            _agent setVariable["MARKER_REF", _marker];
        };
    } else {
        _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _i];
        _response = ["AI", _objHiveKey] call EPOCH_server_hiveGET;
        if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY" && !((_response select 1) isEqualTo[])) then {
            _arr = (_response select 1);
            _class = _arr select 0;
            _home = _arr select 1;
            _work = _arr select 2;
            if (typeName _home == "ARRAY" && typeName _work == "ARRAY") then {
                _pos = _home;
                _schedule = [9, 17];
                if (typeName(_work select 1) == "ARRAY") then {
                    _schedule = _work select 1;
                } else {
                    diag_log format["DEBUG INVAILD SCHEDULE: SLOT: %1 CLASS: %2 POS: %3 WORK: %4", _i, _class, _pos, _work];
                };
                if (daytime > (_schedule select 0) && daytime < (_schedule select 1)) then {
                    _pos = (_work select 0);
                };
                _agent = createAgent[_class, _pos, [], 0, "NONE"];
                addToRemainsCollector[_agent];
                _randomIndex = floor(random(count _aiTables));
                _randomAIUniform = _aiTables select _randomIndex;
                _agent addUniform _randomAIUniform;
                _agent setPos _pos;
                _agent addEventHandler["Killed", {
                    _this call EPOCH_server_traderKilled;
                }];
                if !(EPOCH_forceStaticTraders) then {
                    [_agent, _home, _work] execFSM "\x\addons\a3_epoch_server\system\Trader_brain.fsm";
                };
                _agent setVariable["AI_SLOT", _i, true];
                _arr = [
                    [],
                    []
                ];
                _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _i];
                _response = ["AI_ITEMS", _objHiveKey] call EPOCH_server_hiveGET;
                if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
                    _arr = (_response select 1);
                    if (_arr isEqualTo[]) then {
                        _arr = [
                            [],
                            []
                        ];
                    };
                };
                _agent setVariable["AI_ITEMS", _arr, true];
                EPOCH_TraderSlots set[_i, 1];
                if (EPOCH_SHOW_TRADERS) then {
                    _marker = createMarker[str(_pos), (_pos)];
                    _marker setMarkerShape "ICON";
                    _marker setMarkerType "mil_dot";
                    _marker setMarkerColor "ColorBrown";
                    _agent setVariable["MARKER_REF", _marker];
                };
            } else {
                EPOCH_TraderSlots set[_i, 0];
            };
        } else {
            EPOCH_TraderSlots set[_i, 0];
        };
    };
};
true