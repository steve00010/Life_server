private["_aa", "_ab", "_ac"];
if (!isNull(_this select 0)) then {
    _aa = (_this select 0) getVariable["MARKER_REF", ""];
    if (_aa != "") then {
        _aa setMarkerColor "ColorRed";
    };
    _ab = (_this select 0) getVariable["AI_SLOT", -1];
    if (_ab != -1) then {
        [(_this select 1), 0] call EPOCH_server_triggerEvent;
        _ac = format["%1:%2", (call EPOCH_fn_InstanceID), _ab];
        ["AI", _ac, []] call EPOCH_server_hiveSET;
    };
};