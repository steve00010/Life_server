_plyr = _this select 0;
_return = false;
if (!isNull _plyr) then {
    if (_plyr getVariable["SETUP", false]) then {
        [_plyr, _plyr getVariable["VARS", []], true, true] call EPOCH_server_savePlayer;
        if (alive _plyr) then {
            deleteVehicle _plyr;
        };
    } else {
        deleteVehicle _plyr;
    };
};
_return