private["_aa", "_ab", "_ac", "_ad", "_ae"];
_object = _this select 0;
_index = _this select 1;
_ae = _this select 2;
if !([_ae, _this select 3] call EPOCH_server_getPToken) exitWith {};
if !(_object isKindOf "All") then {
    if (alive _object) then {
        _aa = getPosATL _ae;
        _aa set[2, 0];
        _lootables = ["CinderBlocks", "ItemScraps", "ItemScraps", "ItemScraps", "ItemScraps", "ItemScraps", "ItemScraps", "ItemScraps"];
        _payout = "PartOre";
        if (_index >= 0) then {
            _payout = _lootables select _index;
        };
        _dmg = 0.25;
        if (_payout == "CinderBlocks") then {
            _dmg = 1;
        };
        _object setdamage((damage _object) + _dmg) min 1;
        _ac = nearestObjects[_aa, ["groundWeaponHolder"], 2];
        if !(_ac isEqualTo[]) then {
            _aa = getPosATL(_ac select 0);
            (_ac select 0) addMagazineCargoGlobal[_payout, 1];
        } else {
            _ab = createVehicle["groundWeaponHolder", _aa, [], 0, "CAN_COLLIDE"];
            _ab setPosATL _aa;
            _ab addMagazineCargoGlobal[_payout, 1];
        };
    };
};
true