private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag"];
_aa = _this select 0;
_ab = _this select 1;
_ac = _this select 2;
_ad = str(_this select 3);
_ae = count(toArray(_ad));
_af = 101;
_ag = 121;
if !(EPOCH_hiveAsync) then {
    _af = 100;
    _ag = 120;
};
while {
    _ae > 8000
}
do {
    "epochserver"
    callExtension format["%1|%2", _af, [_ad, 0, 8000] call EPOCH_server_substr];
    _ae = _ae - 8000;
    _ad = [_ad, 8000, 8000 + _ae] call EPOCH_server_substr;
};
"epochserver"
callExtension format["%1|%2:%3|%4|%5", _ag, _aa, _ab, _ac, _ad];