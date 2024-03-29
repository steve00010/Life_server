private["_storageSlotIndex", "_vehHiveKey", "_response", "_arr", "_objType", "_objTypes", "_objQty", "_class", "_damage", "_hitpoints", "_fuel", "_count", "_inventory", "_dir", "_location", "_vehicle", "_actualHitpoints", "_marker", "_isAir", "_isShip", "_config", "_magazines", "_colors", "_color"];
_diag = diag_tickTime;
EPOCH_StorageSlots = [];
for "_i"
from 1 to _this do {
    _storageSlotIndex = EPOCH_StorageSlots pushBack str(_i);
    _vehHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _i];
    _response = ["Storage", _vehHiveKey] call EPOCH_server_hiveGET;
    if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
        _arr = _response select 1;
        if !(_arr isEqualTo[]) then {
            EPOCH_StorageSlots deleteAt _storageSlotIndex;
            _class = _arr select 0;
            _damage = _arr select 2;
            _inventory = _arr select 3;
            if (typeName(_inventory) != "ARRAY") then {
                _inventory = [];
            };
            _dir = _arr select 1 select 0;
            _location = _arr select 1 select 1;
            _vehicle = createVehicle[_class, _location, [], 0, "CAN_COLLIDE"];
            _vehicle setDamage _damage;
            _vehicle setDir _dir;
            diag_log format["STORAGE: created storage %1 at %2", _class, _location];
            if (count _location == 2) then {
                _location set[2, 0];
            };
            _vehicle setposATL _location;
            _vehicle setVariable["STORAGE_SLOT", str(_i), true];
            missionNamespace setVariable[format["EPOCH_STORAGE_%1", _i], _vehicle];
            _vehicle call EPOCH_server_storageInit;
            if (count _arr >= 5) then {
                _color = _arr select 4;
                _config = configFile >> "CfgVehicles" >> _class >> "availableColors";
                if (isArray _config) then {
                    _colors = getArray(_config);
                    _textureSelectionIndex = configFile >> "CfgVehicles" >> _class >> "textureSelectionIndex";
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
                        _vehicle setObjectTextureGlobal[_x, (_textures select _color)];
                    }
                    forEach _selections;
                    _vehicle setVariable["STORAGE_TEXTURE", _color];
                };
            };
            if (count _arr >= 6) then {
                _vehicle setVariable["STORAGE_OWNERS", _arr select 5];
                if (_class == "LockBoxProxy_EPOCH") then {
                    if ((_arr select 6) != -1) then {
                        _vehicle setVariable["EPOCH_secStorParent", _arr select 6];
                        _location set[2, -10];
                        _vehicle setPosATL _location;
                    };
                };
            };
            clearWeaponCargoGlobal _vehicle;
            clearMagazineCargoGlobal _vehicle;
            clearBackpackCargoGlobal _vehicle;
            clearItemCargoGlobal _vehicle;
            if !(_inventory isEqualTo[]) then {
                diag_log format["FILLING: storage %1 pos: %2", _vehicle, (getPosATL _vehicle)]; {
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
                forEach _inventory;
            };
            if (EPOCH_DEBUG_VEH) then {
                _marker = createMarker[str(_location), _location];
                _marker setMarkerShape "ICON";
                _marker setMarkerType "mil_dot";
                _marker setMarkerText _class;
                _marker setMarkerColor "ColorBlue";
            };
        };
    };
};
EPOCH_StorageSlotsCount = count EPOCH_StorageSlots;
publicVariable "EPOCH_StorageSlotsCount";
diag_log format["Storage SPAWN TIMER %1", diag_tickTime - _diag];
true