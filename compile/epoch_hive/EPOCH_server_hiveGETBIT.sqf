private["_aa", "_ab", "_ac"];
_ac = false;
_aa = "epochserver"
callExtension format["240|%1:%2|%3", _this select 0, _this select 1, _this select 2];
if (_aa != "") then {
    _aa = call compile _aa;
    if !(isNil "_aa") then {
        if (typeName _aa == "ARRAY" && !(_aa isEqualTo[])) then {
            if ((_aa select 0) == 1) then {
                _ac = ((_aa select 1) == "1");
            };
        };
    };
};
_ac