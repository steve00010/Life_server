private["_aa", "_ab", "_ac", "_ad", "_ae", "_af"];
_aa = _this select 0;
_ab = _this select 1;
_ac = str(_this select 2);
_ad = count(toArray(_ac));
_ae = 101;
_af = 111;
if !(EPOCH_hiveAsync) then {
    _setterCall = 100;
    _af = 110;
};
while {
    _ad > 8000
}
do {
    "epochserver"
    callExtension format["%1|%2", _ae, [_ac, 0, 8000] call EPOCH_server_substr];
    _ad = _ad - 8000;
    _ac = [_ac, 8000, 8000 + _ad] call EPOCH_server_substr;
};
"epochserver"
callExtension format["%1|%2:%3|%4", _af, _aa, _ab, _ac];