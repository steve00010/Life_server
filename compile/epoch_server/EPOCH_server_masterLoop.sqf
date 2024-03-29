_lastWeatherChange = diag_tickTime;
_lastPlantSpawnTime = diag_tickTime;
_lastSpecialEventTime = diag_tickTime;
_lastNormalEventTime = diag_tickTime;
_prevPlayers = [];
_minerals = ["MineralDepositCopper_EPOCH", "MineralDepositGold_EPOCH", "MineralDepositSilver_EPOCH"];
while {
    true
}
do {
    _currentTime = diag_tickTime;
    if ((_currentTime - _lastWeatherChange) >= EPOCH_WeatherChangeTime) then {
        false call EPOCH_server_setWeather;
        _lastWeatherChange = _currentTime;
        _position = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 1000, 0] call BIS_fnc_findSafePos;
        if ((count _position) == 2) then {
            _plyrsNearEpicenter = _position nearEntities[["Epoch_Male_F", "Epoch_Female_F"], 1000];
            if !(_plyrsNearEpicenter isEqualTo[]) then {
                if ((random 1) > 0.5) then {
                    {
                        [
                            ["earthQuake", _position], (owner _x)
                        ] call EPOCH_sendPublicVariableClient;
                    }
                    forEach _plyrsNearEpicenter;
                    _randomIndex = floor(random(count _minerals));
                    _item = createVehicle[(_minerals select _randomIndex), _position, [], 0.0, "CAN_COLLIDE"];
                    if (EPOCH_showEarthQuakes) then {
                        _marker = createMarker[str(_position), _position];
                        _marker setMarkerShape "ICON";
                        _marker setMarkerType "mil_dot";
                        _marker setMarkerText "Mineral";
                        _marker setMarkerColor "ColorRed";
                    };
                };
            };
        };
    };
    if ((_currentTime - _lastPlantSpawnTime) >= EPOCH_PlantSpawnTime) then {
        _lastPlantSpawnTime = _currentTime;
        _poppyPosition = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 4000, 0] call BIS_fnc_findSafePos;
        if ((count _poppyPosition) == 2) then {
            _item = createVehicle["Poppy_EPOCH", _poppyPosition, [], 0.0, "CAN_COLLIDE"];
            if (EPOCH_showShippingContainers) then {
                _marker = createMarker[str(_poppyPosition), _poppyPosition];
                _marker setMarkerShape "ICON";
                _marker setMarkerType "mil_dot";
                _marker setMarkerText "Poppy";
                _marker setMarkerColor "ColorRed";
            };
        };
    };
    if ((_currentTime - _lastSpecialEventTime) >= EPOCH_SpecialEventTime) then {
        _lastSpecialEventTime = _currentTime;
        _ferrisPosition = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 4000, 0] call BIS_fnc_findSafePos;
        if ((count _ferrisPosition) == 2) then {
            _item = createVehicle["ferrisWheel_EPOCH", _ferrisPosition, [], 0.0, "CAN_COLLIDE"]; {
                _item = createVehicle[_x, _ferrisPosition, [], 30, "NONE"];
            }
            forEach["Land_Slide_F", "Land_Carousel_01_F"];
            if (EPOCH_showShippingContainers) then {
                _marker = createMarker[str(_ferrisPosition), _ferrisPosition];
                _marker setMarkerShape "ICON";
                _marker setMarkerType "mil_dot";
                _marker setMarkerText "Ferris";
                _marker setMarkerColor "ColorRed";
            };
        };
    };
    if ((_currentTime - _lastNormalEventTime) >= EPOCH_NormalEventTime) then {
        _lastNormalEventTime = _currentTime;
        _cargoPosition = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 4000, 1] call BIS_fnc_findSafePos;
        if ((count _cargoPosition) == 2) then {
            _item = createVehicle["Cargo_Container", _cargoPosition, [], 0.0, "CAN_COLLIDE"];
            if (EPOCH_showShippingContainers) then {
                _marker = createMarker[str(_cargoPosition), _cargoPosition];
                _marker setMarkerShape "ICON";
                _marker setMarkerType "mil_dot";
                _marker setMarkerText "Container";
                _marker setMarkerColor "ColorRed";
            };
        };
    };
    uiSleep 1;
};