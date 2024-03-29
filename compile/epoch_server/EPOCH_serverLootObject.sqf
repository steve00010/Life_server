private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah"];
_ah = _this select 0;
_ag = _this select 1;
for "_k"
from 1 to(_this select 2) do {
    _ab = _ag select(floor(random(count _ag)));
    _ac = configFile >> "CfgLootTable" >> _ab;
    _ad = getArray(_ac >> "items");
    _ae = getText(_ac >> "itemType");
    _af = _ad select(floor(random(count _ad)));
    _aa = 1;
    if ((count _af) >= 2) then {
        _aa = _af select 1;
    };
    switch _ae do {
        case "item":
            {
                _ah additemCargoGlobal[_af select 0, _aa];
            };
        case "magazine":
            {
                _ah addMagazineCargoGlobal[_af select 0, _aa];
            };
        case "backpack":
            {
                _ah addBackpackCargoGlobal[_af select 0, _aa];
            };
        case "weapon":
            {
                _ah addWeaponCargoGlobal[_af select 0, _aa];
                _mags = getArray(configFile >> "CfgWeapons" >> (_af select 0) >> "magazines");
                if !(_mags isEqualTo[]) then {
                    _ah addMagazineCargoGlobal[_mags select 0, ceil(random 2)];
                };
            };
        default {
            diag_log format["%1: CASE DEFAULT WITH %1", __FILE__, _this];
        };
    };
    diag_log format["DEBUG SPAWN LOOT IN VEH: %1 %2 %3 type:%4", typeOf _ah, _ab, _af select 0, _ae];
};