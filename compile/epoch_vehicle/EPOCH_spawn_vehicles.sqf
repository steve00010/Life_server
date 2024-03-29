private["_spawnPositionSize", "_spawnPositions", "_type", "_position", "_range", "_roads", "_maxSpawnSize", "_vehicleFound", "_vehClass", "_countAllowedVeh", "_randomVehicleIndex", "_randomVehicle", "_velimit", "_vehicleCount", "_isShip", "_spawnPositionIndex", "_spawnPosition", "_roadPosition", "_dir", "_vehObj", "_config", "_textureSelectionIndex", "_selections", "_colors", "_textures", "_color", "_count", "_marker"];
_spawnPositionSize = [
    ["FlatAreaCity", 1],
    ["FlatAreaCitySmall", 1],
    ["NameCity", 2],
    ["NameVillage", 1],
    ["NameCityCapital", 4],
    ["Airport", 5]
];
_allowedTypes = []; {
    _allowedTypes pushBack(_x select 0)
}
forEach _spawnPositionSize;
_allCitys = (configfile >> "CfgWorlds" >> worldName >> "Names") call BIS_fnc_returnChildren;
_allCitysDync = _allCitys;
_increaseLimit = false; {
    if (count EPOCH_VehicleSlots <= EPOCH_storedVehicleCount) exitWith {
        diag_log format["DEBUG at limit %1 %2", count EPOCH_VehicleSlots, EPOCH_storedVehicleCount];
    };
    _vehicleFound = false;
    _vehClass = "";
    while {
        !_vehicleFound
    }
    do {
        _countAllowedVeh = count EPOCH_allowedVehiclesList;
        if (_countAllowedVeh == 0) exitWith {};
        _randomVehicleIndex = floor(random(_countAllowedVeh));
        _randomVehicle = EPOCH_allowedVehiclesList select _randomVehicleIndex;
        _vehClass = _randomVehicle select 0;
        _velimit = _randomVehicle select 1;
        _vehicleCount = {
            typeOf _x == _vehClass
        }
        count vehicles;
        if (_vehicleCount >= _velimit) then {
            EPOCH_allowedVehiclesList deleteAt _randomVehicleIndex;
        } else {
            if (_vehicleCount == (_velimit - 1)) then {
                EPOCH_allowedVehiclesList deleteAt _randomVehicleIndex;
            };
            _vehicleFound = true;
        };
    };
    if (!_vehicleFound) exitWith {};
    _isShip = _vehClass isKindOf "Ship";
    if (_isShip || (_vehClass isKindOf "Air")) then {
        if (_isShip) then {
            _position = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 4000, 1] call BIS_fnc_findSafePos;
            _position = [_position, 0, 100, 10, 2, 4000, 0] call BIS_fnc_findSafePos;
        } else {
            _position = [epoch_centerMarkerPosition, 0, EPOCH_dynamicVehicleArea, 10, 0, 1000, 0] call BIS_fnc_findSafePos;
        };
    } else {
        if (_increaseLimit) then {
            {
                _spawnPositionSize set[_forEachIndex, [_x select 0, (_x select 1) + 1]];
            }
            forEach _spawnPositionSize;
            _allCitysDync = _allCitys;
        };
        _position = [];
        _start = diag_tickTime;
        waitUntil {
            if (_allCitysDync isEqualTo[]) exitWith {
                _increaseLimit = true
            };
            _selectedCity = _allCitysDync select(floor random(count _allCitysDync));
            if (!isNil "_selectedCity") then {
                _find = _allowedTypes find(getText(_selectedCity >> "type"));
                if (_find > -1) then {
                    _cityPos = getArray(_selectedCity >> "position");
                    _range = getNumber(_selectedCity >> "radiusA") * 1.3;
                    _nearBy = count(_cityPos nearEntities[["LandVehicle", "Ship", "Air"], _range]);
                    _limit = _spawnPositionSize select _find select 1;
                    if (_limit > _nearBy) then {
                        _roads = _cityPos nearRoads _range;
                        if (_roads isEqualTo[]) then {
                            _allCitysDync = _allCitysDync - [_selectedCity];
                        } else {
                            _road = _roads select(floor random(count _roads));
                            if (!isNil "_road") then {
                                _position = getPosATL _road;
                                if (_nearBy + 1 == _limit) then {
                                    _allCitysDync = _allCitysDync - [_selectedCity]
                                };
                            };
                        };
                    } else {
                        _allCitysDync = _allCitysDync - [_selectedCity];
                    };
                };
            };
            count _position == 3 || diag_tickTime - _start > 0.8
        };
        if (count _position == 3) then {
            _position deleteAt 2;
            _position = [_position, 0, 10, 10, 0, 2000, 0] call BIS_fnc_findSafePos;
        } else {
            _increaseLimit = true;
        }
    };
    if (count _position == 2) then {
        _vehObj = createVehicle[_vehClass, _position, [], 0, "CAN_COLLIDE"];
        _vehObj call EPOCH_server_setVToken;
        _vehObj setdir(random 360);
        clearWeaponCargoGlobal _vehObj;
        clearMagazineCargoGlobal _vehObj;
        clearBackpackCargoGlobal _vehObj;
        clearItemCargoGlobal _vehObj;
        _vehObj disableTIEquipment true;
        _vehObj lock true;
        _position set[2, 0];
        if (surfaceIsWater _position) then {
            _vehObj setposASL _position;
        } else {
            _vehObj setposATL _position;
        };
        _config = (configFile >> "CfgVehicles" >> _vehClass >> "availableColors");
        if (isArray(_config)) then {
            _textureSelectionIndex = configFile >> "CfgVehicles" >> _vehClass >> "textureSelectionIndex";
            _selections =
                if (isArray(_textureSelectionIndex)) then {
                    getArray(_textureSelectionIndex)
                } else {
                    [0]
                };
            _colors = getArray(_config);
            _textures = _colors select 0;
            _color = floor(random(count _textures));
            _count = (count _colors) - 1; {
                if (_count >= _forEachIndex) then {
                    _textures = _colors select _forEachIndex;
                };
                _vehObj setObjectTextureGlobal[_x, (_textures select _color)];
            }
            forEach _selections;
            _vehObj setVariable["VEHICLE_TEXTURE", _color];
        };
        if (_vehClass isKindOf "Ship") then {
            [_vehObj, ["Items", "Items", "Equipment", "Equipment", "Pistols", "Pistols", "PistolAmmo", "PistolAmmo", "PistolAmmo", "Scopes", "Muzzles", "Uniforms", "Vests", "Headgear", "Food", "Food", "Generic", "GenericAuto", "GenericAuto", "RifleBoat", "RifleBoat", "RifleAmmoBoat", "RifleAmmoBoat", "Hand", "Grenades", "Backpack"], 4] call EPOCH_serverLootObject;
        } else {
            [_vehObj, ["Items", "Items", "Equipment", "Equipment", "Pistols", "Pistols", "PistolAmmo", "PistolAmmo", "PistolAmmo", "Scopes", "Muzzles", "Uniforms", "Vests", "Headgear", "Food", "Food", "Generic", "GenericAuto", "GenericAuto", "Machinegun", "MachinegunAmmo", "MachinegunAmmo", "Rifle", "RifleAmmo", "RifleAmmo", "SniperRifle", "SniperRifleAmmo", "SniperRifleAmmo", "Hand", "Hand", "Grenades", "Backpack"], 4] call EPOCH_serverLootObject;
        };
        _vehObj setVariable["VEHICLE_SLOT", _x, true];
        _vehObj call EPOCH_server_save_vehicle;
        _vehObj call EPOCH_server_vehicleInit;
        if (EPOCH_DEBUG_VEH) then {
            _marker = createMarker[str(_position), _position];
            _marker setMarkerShape "ICON";
            _marker setMarkerType "mil_dot";
            _marker setMarkerText _vehClass;
        };
        EPOCH_VehicleSlots set[_forEachIndex, "REM"];
        addToRemainsCollector[_vehObj];
    };
}
forEach EPOCH_VehicleSlots;
EPOCH_VehicleSlots = EPOCH_VehicleSlots - ["REM"];
EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;
publicVariable "EPOCH_VehicleSlotCount";
EPOCH_allowedVehiclesList = nil;
true