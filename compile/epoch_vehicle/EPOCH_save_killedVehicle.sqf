private["_aa", "_ab", "_ac"];
if (!isNull _this) then {
    _aa = _this;
    _ab = _aa getVariable["VEHICLE_SLOT", "ABORT"];
    if (_ab != "ABORT") then {
        _ac = format["%1:%2", (call EPOCH_fn_InstanceID), _ab];
        ["Vehicle", _ac, []] call EPOCH_server_hiveSET;
        EPOCH_VehicleSlots pushBack _ab;
        EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;
        publicVariable "EPOCH_VehicleSlotCount";
    };
};