private["_aa"]; {
    _aa = _x getVariable["VEHICLE_SLOT", "ABORT"];
    if (_aa != "ABORT") then {
        if !(_x in EPOCH_saveVehQueue) then {
            EPOCH_saveVehQueue pushBack _x
        };
    };
    _storSlot = _x getVariable["STORAGE_SLOT", "ABORT"];
    if (_storSlot != "ABORT") then {
        if !(_x in EPOCH_saveStorQueue) then {
            EPOCH_saveStorQueue pushBack _x
        };
    };
}
forEach _this;