private["_aa", "_ab", "_ac"];
if (!isNull _this) then {
    _aa = _this;
    _ab = _aa getVariable["BUILD_SLOT", -1];
    if (_ab != -1) then {
        _ac = format["%1:%2", (call EPOCH_fn_InstanceID), _ab];
        ["Building", _ac, []] call EPOCH_server_hiveSET;
        EPOCH_BuildingSlots set[_ab, 0];
        EPOCH_BuildingSlotCount = {
            _x == 0
        }
        count EPOCH_BuildingSlots;
        publicVariable "EPOCH_BuildingSlotCount";
    };
};