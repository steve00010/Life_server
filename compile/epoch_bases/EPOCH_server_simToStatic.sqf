private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah"];
_ah = allMissionObjects "Constructions_modular_F"; {
    _af = _x getVariable["LAST_POS", []];
    _ag = getposATL _x;
    if (_af isEqualTo _ag) then {
        _ae = (configFile >> "CfgVehicles" >> (typeOf _x) >> "staticClass");
        if (isText(_ae)) then {
            _ac = getText(_ae);
            _ad = _x getVariable["BUILD_SLOT", -1];
            if (_ad != -1) then {
                _aa = [_ag, (vectordir _x), (vectorup _x)];
                deleteVehicle _x;
                _ab = createVehicle[_ac, (_aa select 0), [], 0, "CAN_COLLIDE"];
                _ab setVariable["BUILD_SLOT", _ad, true];
                _ab setVectorDirAndUp[(_aa select 1), (_aa select 2)];
                _ab setposATL(_aa select 0);
                _ab setVelocity[0, 0, -1];
            };
        };
    };
    _x setVariable["LAST_POS", _ag];
    uiSleep 1;
}
forEach _ah;