private["_aa", "_ab", "_ac"];
_ab = -1;
_ac = "";
while {
    _ab < 0 || _ab == 2
}
do {
    _aa = "epochserver"
    callExtension format["200|%1:%2", _this select 0, _this select 1];
    _ab = 0;
    if (_aa != "") then {
        _aa = call compile _aa;
        if !(isNil "_aa") then {
            if (typeName _aa == "ARRAY" && !(_aa isEqualTo[])) then {
                _ab = _aa select 0;
                if (_ab >= 1) then {
                    _ac = _ac + (_aa select 1);
                };
            };
        };
    };
};
if (_ab > 0 && _ac find "<null>" == -1) then {
    _ac = call compile _ac;
    if (isNil "_ac") then {
        _ac = [];
    }
} else {
    _ac = [];
};
[_ab, _ac]