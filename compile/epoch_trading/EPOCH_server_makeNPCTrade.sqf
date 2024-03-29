private["_vehHiveKey", "_VAL", "_vehSlot", "_vehicle", "_vehicles", "_trader", "_tradeType", "_item", "_plyrNetID", "_plyr", "_itemWorth", "_position", "_tmpposition", "_textures", "_textureSelectionIndex", "_selections", "_colors", "_color", "_count", "_helipad", "_slot", "_vehObj", "_config", "_item", "_allowedVeh"];
_trader = _this select 0;
_itemsIn = _this select 1;
_itemsOut = _this select 2;
_plyr = _this select 3;
_token = _this select 4;
_returnIn = [];
_returnOut = [];
if (isNull _trader) exitWith {};
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
if (_plyr distance _trader > 20) exitWith {};
_slot = _trader getVariable["AI_SLOT", -1];
if (_slot != -1) then {
    _tradeTotal = 0;
    _tradeQtyTotal = 0;
    _cIndex = EPOCH_customVars find "Crypto";
    _current_crypto = (_plyr getVariable["VARS", EPOCH_defaultVars_SEPXVar]) select _cIndex;
    diag_log format["_current_crypto: %1 _cIndex:%2", _current_crypto, _cIndex];
    _aiItems = _trader getVariable["AI_ITEMS", [
        [],
        []
    ]];
    _itemClasses = _aiItems select 0;
    _itemQtys = _aiItems select 1; {
        _item = _x;
        _itemQty = 1;
        if (isClass(configfile >> "CfgPricing" >> _item)) then {
            _itemWorth = getNumber(configFile >> "CfgPricing" >> _item >> "price");
            _makeTradeIn = false;
            if (_item isKindOf "Air" || _item isKindOf "Ship" || _item isKindOf "LandVehicle") then {
                _vehicles = _trader nearEntities[[_item], 30];
                if !(_vehicles isEqualTo[]) then {
                    _vehicle = _vehicles select 0;
                    if (!isNull _vehicle) then {
                        _plyrNetID = owner _plyr;
                        if (_plyrNetID == (owner _vehicle)) then {
                            _vehSlot = _vehicle getVariable["VEHICLE_SLOT", "ABORT"];
                            if (_vehSlot != "ABORT") then {
                                removeFromRemainsCollector[_vehicle];
                                deleteVehicle _vehicle;
                                _vehHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _vehSlot];
                                _VAL = [];
                                ["Vehicle", _vehHiveKey, _VAL] call EPOCH_server_hiveSET;
                                EPOCH_VehicleSlots pushBack _vehSlot;
                                EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;
                                publicVariable "EPOCH_VehicleSlotCount";
                                _makeTradeIn = true;
                            };
                        };
                    };
                };
            } else {
                _makeTradeIn = true;
            };
            if (_makeTradeIn) then {
                _returnIn pushBack _item;
                _qtyIndex = _itemClasses find _item;
                if (_qtyIndex == -1) then {
                    _itemClasses pushBack _item;
                    _itemQtys pushBack _itemQty;
                    _tradeTotal = _tradeTotal + _itemWorth;
                    _current_crypto = _current_crypto + _itemWorth;
                    _tradeQtyTotal = _tradeQtyTotal + _itemQty;
                } else {
                    _currQty = _itemQtys select _qtyIndex;
                    _itemQtys set[_qtyIndex, (_currQty + _itemQty)];
                    _tradeTotal = _tradeTotal + _itemWorth;
                    _current_crypto = _current_crypto + _itemWorth;
                    _tradeQtyTotal = _tradeQtyTotal + _itemQty;
                };
                diag_log format["_itemClasses: %1 _itemQtys:%2", _itemClasses, _itemQtys];
            };
        };
    }
    forEach _itemsIn; {
        _item = _x;
        _itemQty = 1;
        diag_log format["_item: %1", _item];
        if (isClass(configfile >> "CfgPricing" >> _item)) then {
            _itemWorth = getNumber(configFile >> "CfgPricing" >> _item >> "price");
            _itemTax = getNumber(configFile >> "CfgPricing" >> _item >> "tax");
            _tax = _itemWorth * (EPOCH_taxRate + _itemTax);
            _itemWorth = ceil(_itemWorth + _tax);
            diag_log format["_itemWorth: %1", _itemWorth];
            _qtyIndex = _itemClasses find _item;
            if (_qtyIndex != -1) then {
                _currQty = _itemQtys select _qtyIndex;
                diag_log format["_currQty: %1 >= %2", _currQty, _itemQty];
                if (_currQty >= _itemQty) then {
                    if (_current_crypto >= _itemWorth) then {
                        if (_item isKindOf "Air" || _item isKindOf "Ship" || _item isKindOf "LandVehicle") then {
                            if !(EPOCH_VehicleSlots isEqualTo[]) then {
                                _position = getPosATL _plyr;
                                _helipad = nearestObjects[_position, ["Land_HelipadEmpty_F", "Land_HelipadCircle_F"], 30];
                                if !(_helipad isEqualTo[]) then {
                                    _position = getPosATL(_helipad select 0);
                                } else {
                                    _tmpposition = [];
                                    if (_item isKindOf "Ship") then {
                                        _tmpposition = [_position, 20, 120, 10, 0, 1000, 1] call BIS_fnc_findSafePos;
                                        _tmpposition = [_tmpposition, 0, 60, 10, 2, 1000, 0] call BIS_fnc_findSafePos;
                                    } else {
                                        _tmpposition = [_position, 20, 120, 20, 0, 2000, 0] call BIS_fnc_findSafePos;
                                    };
                                    if ((count _tmpposition) == 2) then {
                                        _position = _tmpposition;
                                    };
                                };
                                _slot = EPOCH_VehicleSlots select 0;
                                EPOCH_VehicleSlots = EPOCH_VehicleSlots - [_slot];
                                EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;
                                publicVariable "EPOCH_VehicleSlotCount";
                                _vehObj = createVehicle[_item, _position, [], 0, "NONE"];
                                _vehObj call EPOCH_server_setVToken;
                                addToRemainsCollector[_vehObj];
                                _vehObj disableTIEquipment true;
                                clearWeaponCargoGlobal _vehObj;
                                clearMagazineCargoGlobal _vehObj;
                                clearBackpackCargoGlobal _vehObj;
                                clearItemCargoGlobal _vehObj;
                                _vehObj lock true;
                                _lockOwner = getPlayerUID _plyr;
                                _plyrGroup = _plyr getVariable["GROUP", ""];
                                if (_plyrGroup != "") then {
                                    _lockOwner = _plyrGroup;
                                };
                                _vehObj setVariable["LOCK_OWNER", _lockOwner];
                                _vehObj setVariable["LOCKED_TILL", serverTime + 1800];
                                _config = configFile >> "CfgVehicles" >> _item >> "availableColors";
                                if (isArray(_config)) then {
                                    _textureSelectionIndex = configFile >> "CfgVehicles" >> _item >> "textureSelectionIndex";
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
                                _vehObj setVariable["VEHICLE_SLOT", _slot, true];
                                _vehObj call EPOCH_server_save_vehicle;
                                _vehObj call EPOCH_server_vehicleInit;
                                _returnOut pushBack _item;
                                _itemQtys set[_qtyIndex, (_currQty - _itemQty)];
                                _tradeTotal = _tradeTotal - _itemWorth;
                                _current_crypto = _current_crypto - _itemWorth;
                                _tradeQtyTotal = _tradeQtyTotal + _itemQty;
                            };
                        } else {
                            _returnOut pushBack _item;
                            _itemQtys set[_qtyIndex, (_currQty - _itemQty)];
                            _tradeTotal = _tradeTotal - _itemWorth;
                            _current_crypto = _current_crypto - _itemWorth;
                            _tradeQtyTotal = _tradeQtyTotal + _itemQty;
                        };
                        diag_log format["_itemClasses: %1 _itemQtys:%2", _itemClasses, _itemQtys];
                    };
                };
            };
        };
    }
    forEach _itemsOut;
    if (_itemsIn isEqualTo _returnIn || _itemsOut isEqualTo _returnOut) then {
        _trader setVariable["AI_ITEMS", [_itemClasses, _itemQtys], true];
        _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _slot];
        ["AI_ITEMS", _objHiveKey, [_itemClasses, _itemQtys]] call EPOCH_server_hiveSET;
        diag_log format["UPDATED DB FOR TRADER: %1 SLOT: %2 DATA: %3", _trader, _slot, [_itemClasses, _itemQtys]];
        diag_log format["ADMIN: %1 TRADETOTAL:%2", _this, _tradeTotal];
        [
            ["effectCrypto", _tradeTotal], owner _plyr
        ] call EPOCH_sendPublicVariableClient;
        EPOCH_TRADE_COMPLETE = [_returnIn, _returnOut];
        (owner _plyr) publicVariableClient "EPOCH_TRADE_COMPLETE";
    };
};