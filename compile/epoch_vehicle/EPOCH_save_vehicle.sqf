private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah", "_ai", "_aj", "_ak", "_al", "_am", "_an", "_ao", "_ap", "_aq", "_ar"];
if (!isNull _this) then {
    _aa = _this;
    _ac = _this getVariable["VEHICLE_SLOT", "ABORT"];
    if (_ac != "ABORT") then {
        _ad = format["%1:%2", (call EPOCH_fn_InstanceID), _ac];
        _aj = [];
        _ak = _aa call EPOCH_getHitpoints; {
            _aj pushBack(_aa getHitPointDamage _x);
        }
        forEach _ak;
        _wepsItemsCargo = weaponsItemsCargo _aa;
        if (isNil "_wepsItemsCargo") then {
            _wepsItemsCargo = [];
        };
        _magsAmmoCargo = magazinesAmmoCargo _aa;
        if (isNil "_magsAmmoCargo") then {
            _magsAmmoCargo = [];
        };
        _aq = [
            [],
            []
        ]; {
            _ar = _aq find(_x select 0);
            if (_ar >= 0) then {
                (_aq select 1) set[_ar, ((_aq select 1) select _ar) + (_x select 1)];
            } else {
                (_aq select 0) pushBack(_x select 0);
                (_aq select 1) pushBack(_x select 1);
            };
        }
        forEach _magsAmmoCargo;
        _al = [_wepsItemsCargo, _aq, getBackpackCargo _aa, getItemCargo _aa];
        _ap = _aa getVariable["VEHICLE_TEXTURE", 0];
        _am = [typeOf _aa, [getposATL _aa, vectordir _aa, vectorup _aa], damage _aa, _aj, fuel _aa, _al, magazinesAmmo _aa, _ap];
        ["Vehicle", _ad, EPOCH_expiresVehicle, _am] call EPOCH_server_hiveSETEX;
    };
};