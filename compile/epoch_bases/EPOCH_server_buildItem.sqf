private["_aa", "_ab", "_ac", "_ad", "_ae"];
_itemClass = _this select 0;
_ac = _this select 1;
_plyr = _this select 2;
_ad = getDir _plyr;
if (isNull _plyr) exitWith {};
_token = _this select 3;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
_ab = getText(configfile >> "CfgMagazines" >> (_itemClass) >> "buildClass");
if (_ab != "") then {
    _isStorage = getNumber(configfile >> "CfgMagazines" >> (_itemClass) >> "isStorage");
    if (_isStorage == 1) then {
        if !(EPOCH_StorageSlots isEqualTo[]) then {
            _ae = createVehicle[_ab, _ac, [], 0.0, "CAN_COLLIDE"];
            _ae setDir _ad;
            _ae setPosATL _ac;
            _aa = EPOCH_StorageSlots select 0;
            EPOCH_StorageSlots = EPOCH_StorageSlots - [_aa];
            _ae setVariable["STORAGE_SLOT", _aa, true];
            _ae call EPOCH_server_save_storage;
            _ae call EPOCH_server_storageInit;
            diag_log format["STORAGE: %1 created storage %2 at %3", (getPlayerUID _plyr), _ab, _ac];
            EPOCH_StorageSlotsCount = count EPOCH_StorageSlots;
            publicVariable "EPOCH_StorageSlotsCount";
        };
    } else {
        _isTemp = getNumber(configfile >> "CfgMagazines" >> (_itemClass) >> "isTemp");
        _ae = createVehicle[_ab, _ac, [], 0.0, "CAN_COLLIDE"];
        _ae setDir _ad;
        _ae setPosATL _ac;
        if (_isTemp == 0) then {
            [_ae, _plyr] call EPOCH_server_saveBuilding;
        };
        diag_log format["BUILDING: %1 created building %2 at %3", (getPlayerUID _plyr), _ab, _ac];
    };
};