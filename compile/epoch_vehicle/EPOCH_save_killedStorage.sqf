private["_aa", "_ab", "_ac"];
if (!isNull _this) then {
    _aa = _this;
    _ab = _aa getVariable["STORAGE_SLOT", "ABORT"];
    if (_ab != "ABORT") then {
        _ac = format["%1:%2", (call EPOCH_fn_InstanceID), _ab];
        ["Storage", _ac, []] call EPOCH_server_hiveSET;
        EPOCH_StorageSlots pushBack _ab;
        EPOCH_StorageSlotsCount = count EPOCH_StorageSlots;
        publicVariable "EPOCH_StorageSlotsCount";
    };
};