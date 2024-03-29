_unit = _this select 0;
_plyr = _this select 1;
_token = _this select 2;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _unit) exitWith {};
if (_plyr distance _unit > 20) exitWith {};
if (typeOf _unit == "LockBox_EPOCH") then {
    _parentID = _unit getVariable["EPOCH_secureStorage", "-1"];
    _weaponHolder = missionNamespace getVariable[format["EPOCH_STORAGE_%1", _parentID], objNull];
    if (!isNull _weaponHolder) then {
        _owners = _weaponHolder getVariable["STORAGE_OWNERS", []];
        if ((getPlayerUID _plyr) in _owners) then {
            _posWH = getPosATL _unit;
            _unit call EPOCH_server_save_killedBuilding;
            deleteVehicle _unit;
            _wepsItemsCargo = weaponsItemsCargo _weaponHolder;
            if (isNil "_wepsItemsCargo") then {
                _wepsItemsCargo = [];
            };
            _magsAmmoCargo = magazinesAmmoCargo _weaponHolder;
            if (isNil "_magsAmmoCargo") then {
                _magsAmmoCargo = [];
            };
            _inventory = [_wepsItemsCargo, _magsAmmoCargo, getBackpackCargo _weaponHolder, getItemCargo _weaponHolder];
            _weaponHolder call EPOCH_server_save_killedStorage;
            deleteVehicle _weaponHolder;
            _gwh = createVehicle["groundWeaponHolder", _posWH, [], 0, "CAN_COLLIDE"];
            _gwh setPosATL _posWH;
            _gwh addMagazineCargoGlobal["ItemLockbox", 1]; {
                _objType = _forEachIndex;
                _objTypes = _x;
                _objQty = [];
                if (_objType in [2, 3]) then {
                    _objTypes = _x select 0;
                    _objQty = _x select 1;
                }; {
                    switch _objType do {
                        case 0:
                            {
                                if (typeName _x == "ARRAY") then {
                                    _arrCount = count _x;
                                    if (_arrCount >= 4) then {
                                        _weapon = _x select 0;
                                        _gwh addWeaponCargoGlobal[_weapon, 1];
                                        _suppressor = _x select 1;
                                        _laser = _x select 2;
                                        _optics = _x select 3;
                                        if (_suppressor != "") then {
                                            _gwh addItemCargoGlobal[_suppressor, 1];
                                        };
                                        if (_laser != "") then {
                                            _gwh addItemCargoGlobal[_laser, 1];
                                        };
                                        if (_optics != "") then {
                                            _gwh addItemCargoGlobal[_optics, 1];
                                        };
                                        if ((count _x) >= 5) then {
                                            _magazine = _x select 4;
                                            _gwh addMagazineAmmoCargo[_magazine select 0, 1, _magazine select 1];
                                        };
                                    };
                                };
                            };
                        case 1:
                            {
                                if (typeName _x == "ARRAY") then {
                                    if ((count _x) == 2) then {
                                        _magazineName = _x select 0;
                                        _magazineSize = _x select 1;
                                        if ((typeName _magazineName == "STRING") && (typeName _magazineSize == "SCALAR")) then {
                                            _gwh addMagazineAmmoCargo[_magazineName, 1, _magazineSize];
                                        };
                                    };
                                };
                            };
                        case 2:
                            {
                                if (typeName _x == "STRING") then {
                                    _qty = _objQty select _forEachIndex;
                                    _gwh addBackpackCargoGlobal[_x, _qty];
                                };
                            };
                        case 3:
                            {
                                if (typeName _x == "STRING") then {
                                    _qty = _objQty select _forEachIndex;
                                    _gwh addItemCargoGlobal[_x, _qty];
                                };
                            };
                    };
                }
                forEach _objTypes;
            }
            forEach _inventory;
        };
    };
};