private["_aa", "_ab", "_ac", "_ad"];
_aa = _this select 0;
_ab = _this select 1;
_ac = _this select 2;
_ad = 131;
if !(EPOCH_hiveAsync) then {
    _ad = 130;
};
"epochserver"
callExtension format["%1|%2:%3|%4", _ad, _aa, _ab, _ac];