private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah"];
_vehicle = _this select 0;
_plyr = _this select 1;
if (isNull _vehicle || isNull _plyr) exitWith {};
_token = _this select 2;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
_plyrUID = getPlayerUID _plyr;
if !(isNull ropeAttachedTo _vehicle) exitWith {};
_oemType = (typeOf _vehicle);
_ah = (configFile >> "CfgVehicles" >> _oemType >> "staticClass");
if (isText(_ah)) then {
    _staticClass = getText(_ah);
    if (_staticClass isKindOf "Buildable_Storage") then {
        if !(EPOCH_StorageSlots isEqualTo[]) then {
            _ah = (configFile >> "CfgVehicles" >> _oemType >> "staticClass");
            if (isText(_ah)) then {
                _slot = EPOCH_StorageSlots select 0;
                EPOCH_StorageSlots = EPOCH_StorageSlots - [_slot];
                _ad = [(getposATL _vehicle), (vectordir _vehicle), (vectorup _vehicle)];
                deleteVehicle _vehicle;
                _storageObj = createVehicle[_staticClass, (_ad select 0), [], 0, "CAN_COLLIDE"];
                _storageObj setVariable["STORAGE_SLOT", _slot, true];
                _storageObj setVectorDirAndUp[(_ad select 1), (_ad select 2)];
                _storageObj setposATL(_ad select 0);
                _storageObj call EPOCH_server_save_storage;
                _storageObj call EPOCH_server_storageInit;
                diag_log format["STORAGE: %1 created storage %2 at %3", (getPlayerUID _plyr), _staticClass, (_ad select 0)];
                EPOCH_StorageSlotsCount = count EPOCH_StorageSlots;
                publicVariable "EPOCH_StorageSlotsCount";
            };
        };
    } else {
        if (_vehicle isKindOf "ThingX" || _vehicle isKindOf "Foundation_Ghost_EPOCH" || _vehicle isKindOf "PlotPole_EPOCH") then {
            _aa = _vehicle getVariable["BUILD_SLOT", -1];
            if (_aa == -1) then {
                _ab = EPOCH_BuildingSlots find 0;
                if (_ab != -1) then {
                    _aa = _ab;
                    EPOCH_BuildingSlots set[_ab, 1];
                    _vehicle setVariable["BUILD_SLOT", _ab, true];
                };
            };
            _textureSlot = _vehicle getVariable["TEXTURE_SLOT", 0];
            EPOCH_BuildingSlotCount = {
                _x == 0
            }
            count EPOCH_BuildingSlots;
            publicVariable "EPOCH_BuildingSlotCount";
            if (_aa != -1) then {
                _ad = [(getposATL _vehicle), (vectordir _vehicle), (vectorup _vehicle)];
                _ae = format["%1:%2", (call EPOCH_fn_InstanceID), _aa];
                _newVehicle = [_vehicle, false] call EPOCH_server_simulSwap;
                missionNamespace setVariable[format["EPOCH_BUILD_%1", _aa], _newVehicle];
                _newVehicle setVariable["BUILD_OWNER", _plyrUID, true];
                _slot = "-1";
                if (_oemType == "LockBox_SIM_EPOCH") then {
                    diag_log format["building lockbox %1", _oemType];
                    _buildClass = "LockBoxProxy_EPOCH";
                    if (!isNull _newVehicle) then {
                        diag_log format["building lockbox !isnull %1", _newVehicle];
                        if !(EPOCH_StorageSlots isEqualTo[]) then {
                            diag_log format["building lockbox findslot %1", _newVehicle];
                            _storageObj = createVehicle[_buildClass, (_ad select 0), [], 0.0, "CAN_COLLIDE"];
                            _slot = EPOCH_StorageSlots select 0;
                            EPOCH_StorageSlots = EPOCH_StorageSlots - [_slot];
                            diag_log format["building lockbox found slot %1", _slot];
                            missionNamespace setVariable[format["EPOCH_STORAGE_%1", _slot], _storageObj];
                            _newVehicle setVariable["EPOCH_secureStorage", _slot];
                            _newVehicle setVariable["EPOCH_Locked", false, true];
                            _storageObj setVariable["STORAGE_OWNERS", [_plyrUID]];
                            _storageObj setVariable["EPOCH_secStorParent", _aa];
                            _storageObj setVariable["STORAGE_SLOT", _slot, true];
                            _storageObj call EPOCH_server_save_storage;
                            _storageObj call EPOCH_server_storageInit;
                            diag_log format["STORAGE: %1 created storage %2 at %3", _plyrUID, _buildClass, _pos];
                            EPOCH_StorageSlotsCount = count EPOCH_StorageSlots;
                            publicVariable "EPOCH_StorageSlotsCount";
                        };
                    };
                };
                _af = [_staticClass, _ad, _slot, _plyrUID, _textureSlot];
                _ag = ["Building", _ae, EPOCH_expiresBuilding, _af] call EPOCH_server_hiveSETEX;
            };
        } else {
            diag_log format["DEBUG BUILD SAVE ABORT TYPE ERROR: %1", _this]
        };
    };
};
_ag