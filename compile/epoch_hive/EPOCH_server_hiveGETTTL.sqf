private["_aa", "_ab", "_ac", "_ad"];
_ab = -1;
_ac = "";
_hiveTTL = -1;
_aa = "";
_ad = 0;
while {
    _ab < 0 || _ab == 2
}
do {
    if (_ad == 0) then {
        _aa = "epochserver"
        callExtension format["210|%1:%2", _this select 0, _this select 1];
    } else {
        _aa = "epochserver"
        callExtension format["200|%1:%2", _this select 0, _this select 1];
    };
    _ab = 0;
    if (_aa != "") then {
        _aa = call compile _aa;
        if !(isNil "_aa") then {
            if (typeName _aa == "ARRAY" && !(_aa isEqualTo[])) then {
                _ab = _aa select 0;
                if (_ab >= 1) then {
                    if (_ad == 0) then {
                        _hiveTTL = _aa select 1;
                        _ac = _ac + (_aa select 2);
                    } else {
                        _ac = _ac + (_aa select 1);
                    };
                };
            };
        };
    };
    _ad = _ad + 1;
};
if (_ab > 0 && _ac find "<null>" == -1) then {
    _ac = call compile _ac;
    if (isNil "_ac") then {
        _ac = [];
    }
} else {
    _ac = [];
};
[_ab, _ac, _hiveTTL]