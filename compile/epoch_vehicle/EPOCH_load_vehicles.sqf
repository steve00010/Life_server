private["_vehicleSlotIndex", "_vehHiveKey", "_response", "_arr", "_arrNum", "_index", "_varName", "_varData", "_dataVars", "_dataFormat", "_objType", "_objTypes", "_objQty", "_location", "_vdir", "_vup", "_vehicle", "_actualHitpoints", "_config", "_colors", "_textureSelectionIndex", "_selections", "_count", "_textures", "_weapon", "_suppressor", "_laser", "_optics", "_magazine", "_magazineName", "_magazineSize", "_magazineSizeMax", "_qty", "_diag", "_marker"];
_diag = diag_tickTime;
_dataVars = ["EP_class", "EP_worldspace", "EP_damage", "EP_hitpoints", "EP_fuel", "EP_inventory", "EP_magazines", "EP_color"];
_dataFormat = ["", [], 0, [], 0, [],
    [], 0
];
diag_log(_this);
EPOCH_VehicleSlots = [];
for "_i"
from 1 to _this do {
    _vehicleSlotIndex = EPOCH_VehicleSlots pushBack str(_i);
    _vehHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _i];
    _response = ["Vehicle", _vehHiveKey] call EPOCH_server_hiveGET;
    if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
        _arr = _response select 1;
        _arrNum = count _arr;
        EP_class = "";
        EP_worldspace = [];
        EP_damage = 0;
        EP_hitpoints = [];
        EP_fuel = 0;
        EP_inventory = [];
        EP_magazines = [];
        EP_color = 0;
        if (_arrNum == (count _dataFormat)) then {
            {
                _index = _forEachIndex;
                _varName = _dataVars select _index;
                _varData = _arr select _index;
                if (typeName _varData == typeName _x) then {
                    call compile format["%1 = _varData;", _varName];
                } else {
                    call compile format["%1 = _x;", _varName];
                };
            }
            forEach _dataFormat;
            if (EP_class != "" && EP_damage < 1) then {
                _location = EP_worldspace select 0;
                _vdir = EP_worldspace select 1;
                _vup = EP_worldspace select 2;
                if !(_location isEqualTo[]) then {
                    EPOCH_VehicleSlots deleteAt _vehicleSlotIndex;
                    switch (EP_class) do {
                        case "O_Heli_Transport_04_F"; {
                            EP_class = "O_Heli_Transport_04_EPOCH";
                        };
                        case "O_Heli_Transport_04_bench_F"; {
                            EP_class = "O_Heli_Transport_04_bench_EPOCH";
                        };
                        case "O_Heli_Transport_04_box_F"; {
                            EP_class = "O_Heli_Transport_04_box_EPOCH";
                        };
                        case "O_Heli_Transport_04_covered_F"; {
                            EP_class = "O_Heli_Transport_04_covered_EPOCH";
                        };
                        case "B_Heli_Transport_03_unarmed_F"; {
                            EP_cass = "B_Heli_Transport_03_unarmed_EPOCH";
                        };
                        case "O_Truck_03_covered_F"; {
                            EP_cass = "O_Truck_03_covered_EPOCH";
                        };
                    };
                    _vehicle = createVehicle[EP_class, _location, [], 0, "CAN_COLLIDE"];
                    _vehicle call EPOCH_server_setVToken;
                    _vehicle setposATL _location;
                    _vehicle setVectorDirAndUp[_vdir, _vup];
                    _vehicle setDamage EP_damage;
                    _actualHitpoints = _vehicle call EPOCH_getHitpoints;
                    if ((count _actualHitpoints) == (count EP_hitpoints)) then {
                        {
                            _vehicle setHitPointDamage[_x, (EP_hitpoints select _forEachIndex)];
                        }
                        forEach _actualHitpoints;
                    };
                    _vehicle setFuel EP_fuel;
                    _vehicle call EPOCH_server_vehicleInit;
                    _config = configFile >> "CfgVehicles" >> EP_class >> "availableColors";
                    if (isArray(_config)) then {
                        _colors = getArray(_config);
                        _textureSelectionIndex = configFile >> "CfgVehicles" >> EP_class >> "textureSelectionIndex";
                        _selections =
                            if (isArray(_textureSelectionIndex)) then {
                                getArray(_textureSelectionIndex)
                            } else {
                                [0]
                            };
                        _count = (count _colors) - 1; {
                            _textures = _colors select 0;
                            if (_count >= _forEachIndex) then {
                                _textures = _colors select _forEachIndex;
                            };
                            _vehicle setObjectTextureGlobal[_x, (_textures select EP_color)];
                        }
                        forEach _selections;
                        _vehicle setVariable["VEHICLE_TEXTURE", EP_color];
                    };
                    clearWeaponCargoGlobal _vehicle;
                    clearMagazineCargoGlobal _vehicle;
                    clearBackpackCargoGlobal _vehicle;
                    clearItemCargoGlobal _vehicle;
                    _vehicle disableTIEquipment true;
                    _vehicle lock true;
                    _vehicle setVariable["VEHICLE_SLOT", str(_i), true];
                    diag_log format["FILLING: _vehicle %1 pos: %2", _vehicle, (getPosATL _vehicle)]; {
                        _objType = _forEachIndex;
                        _objTypes = _x;
                        _objQty = [];
                        if (_objType in [1, 2, 3]) then {
                            _objTypes = _x select 0;
                            _objQty = _x select 1;
                        }; {
                            switch _objType do {
                                case 0:
                                    {
                                        if (typeName _x == "ARRAY") then {
                                            if ((count _x) >= 4) then {
                                                _weapon = _x select 0;
                                                _vehicle addWeaponCargoGlobal[_weapon, 1];
                                                _suppressor = _x select 1;
                                                _laser = _x select 2;
                                                _optics = _x select 3;
                                                if (_suppressor != "") then {
                                                    _vehicle addItemCargoGlobal[_suppressor, 1];
                                                };
                                                if (_laser != "") then {
                                                    _vehicle addItemCargoGlobal[_laser, 1];
                                                };
                                                if (_optics != "") then {
                                                    _vehicle addItemCargoGlobal[_optics, 1];
                                                };
                                                if ((count _x) >= 5) then {
                                                    _magazine = _x select 4;
                                                    _vehicle addMagazineAmmoCargo[_magazine select 0, 1, _magazine select 1];
                                                };
                                            };
                                        };
                                    };
                                case 1:
                                    {
                                        _magazineName = _x;
                                        _magazineSize = _objQty select _forEachIndex;
                                        if ((typeName _magazineName == "STRING") && (typeName _magazineSize == "SCALAR")) then {
                                            _magazineSizeMax = getNumber(configFile >> "CfgMagazines" >> _magazineName >> "count");
                                            _vehicle addMagazineAmmoCargo[_magazineName, floor(_magazineSize / _magazineSizeMax), _magazineSizeMax];
                                            if ((_magazineSize % _magazineSizeMax) > 0) then {
                                                _vehicle addMagazineAmmoCargo[_magazineName, 1, floor(_magazineSize % _magazineSizeMax)];
                                            };
                                        };
                                    };
                                case 2:
                                    {
                                        if (typeName _x == "STRING") then {
                                            _qty = _objQty select _forEachIndex;
                                            _vehicle addBackpackCargoGlobal[_x, _qty];
                                        };
                                    };
                                case 3:
                                    {
                                        if (typeName _x == "STRING") then {
                                            _qty = _objQty select _forEachIndex;
                                            _vehicle addItemCargoGlobal[_x, _qty];
                                        };
                                    };
                            };
                        }
                        forEach _objTypes;
                    }
                    forEach EP_inventory; {
                        _vehicle removeMagazineGlobal _x;
                    }
                    forEach(magazines _vehicle); {
                        _vehicle addMagazine _x;
                    }
                    forEach EP_magazines;
                    if (EPOCH_DEBUG_VEH) then {
                        _marker = createMarker[str(_location), _location];
                        _marker setMarkerShape "ICON";
                        _marker setMarkerType "mil_dot";
                        _marker setMarkerText EP_class;
                        _marker setMarkerColor "ColorGreen";
                    };
                    _vehicle enableSimulationGlobal false;
                    addToRemainsCollector[_vehicle];
                };
            };
        };
    };
};
diag_log format["VEH SPAWN TIMER %1", diag_tickTime - _diag];
diag_log(EPOCH_VehicleSlots);
true