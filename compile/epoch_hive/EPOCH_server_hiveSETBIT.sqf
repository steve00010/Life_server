private["_aa", "_ab", "_ac", "_ad"];
_aa = _this select 0;
_ab = _this select 1;
_ad = _this select 2;
_ac = _this select 3;
"epochserver"
callExtension format["141|%1:%2|%3|%4", _aa, _ab, _ad, _ac];