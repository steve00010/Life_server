private["_aa", "_ab", "_ac"];
_aa = _this select 0;
if (!isNull _aa) then {
    _ab = _this select 2;
    _ac = _this select 3;
    switch (_this select 1) do {
        case 0:
            {
                _aa addWeaponCargoGlobal[_ab, _ac]
            };
        case 1:
            {
                _aa addBackpackCargoGlobal[_ab, _ac]
            };
        case 2:
            {
                _aa addMagazineCargoGlobal[_ab, _ac]
            };
        case 3:
            {
                _aa addItemCargoGlobal[_ab, _ac]
            };
    };
};