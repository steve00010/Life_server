private["_aa", "_ab", "_ac"];
_ab = _this select 0;
_ac = owner(_this select 1);
_aa = false;
if (!isNull _ab) then {
    if (local _ab) then {
        if ((owner _ab) != _ac) then {
            _aa = _ab setOwner _ac;
            diag_log format["DEBUG CHANGEOWNER: %1 OWNER: %2 PLAYER: %3 RESULT: %4", _ab, owner(_ab), _ac, _aa];
        };
    };
};
_aa