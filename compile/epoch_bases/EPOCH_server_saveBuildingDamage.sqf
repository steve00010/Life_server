private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah", "_ai", "_aj", "_ak", "_al"];
_ak = _this;
if (alive _ak) then {
    _al = _ak getVariable["BUILD_SLOT", -1];
    if (_al != -1) then {
        _ai = format["%1:%2", (call EPOCH_fn_InstanceID), _al];
        _aj = ["Building", _ai] call EPOCH_server_hiveGET;
        if ((_aj select 0) == 1 && typeName(_aj select 1) == "ARRAY" && !((_aj select 1) isEqualTo[])) then {
            _ag = _aj select 1;
            _ah = count _ag;
            _aa = _ag select 0;
            _ab = _ag select 1;
            _ad = "-1";
            if (_ah >= 3) then {
                if ((typeName(_ag select 2)) == "SCALAR") then {
                    _ad = str(_ag select 2);
                } else {
                    _ad = _ag select 2;
                };
            };
            _ae = "-1";
            if (_ah >= 4) then {
                _ae = _ag select 3;
            };
            _af = 0;
            if (_ah >= 5) then {
                _af = _ag select 4;
            };
            _ac = [_aa, _ab, _ad, _ae, _af, damage _ak];
            ["Building", _ai, EPOCH_expiresBuilding, _ac] call EPOCH_server_hiveSETEX;
        };
    };
};