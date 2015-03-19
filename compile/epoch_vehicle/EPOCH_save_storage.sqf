private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah", "_ai", "_aj", "_ak", "_al", "_am", "_an", "_ao", "_ap", "_aq", "_ar", "_as", "_at"];
if (!isNull _this) then {
    _aa = _this;
    _ab = typeOf _aa;
    _ac = _aa getVariable["STORAGE_SLOT", "ABORT"];
    if (_ac != "ABORT") then {
        _ad = format["%1:%2", (call EPOCH_fn_InstanceID), _ac];
        _ae = damage _aa;
        _ag = getPosATL _aa;
        _ah = getDir _aa;
        _ai = [_ah, _ag];
        _aq = weaponsItemsCargo _aa;
        if (isNil "_aq") then {
            _aq = [];
        };
        _ar = magazinesAmmoCargo _aa;
        if (isNil "_ar") then {
            _ar = [];
        };
        _as = [
            [],
            []
        ]; {
            _at = _as find(_x select 0);
            if (_at >= 0) then {
                (_as select 1) set[_at, ((_as select 1) select _at) + (_x select 1)];
            } else {
                (_as select 0) pushBack(_x select 0);
                (_as select 1) pushBack(_x select 1);
            };
        }
        forEach _ar;
        _al = [_aq, _as, getBackpackCargo _aa, getItemCargo _aa];
        _ap = _aa getVariable["STORAGE_TEXTURE", 0];
        _storageOwners = _aa getVariable["STORAGE_OWNERS", []];
        _storageParent = _aa getVariable["EPOCH_secStorParent", -1];
        _parentID = _aa getVariable["EPOCH_secStorParent", -1];
        _parent = missionNamespace getVariable[format["EPOCH_BUILD_%1", _parentID], objNull];
        if (!isNull _parent) then {
            _objSlot = _parent getVariable["BUILD_SLOT", -1];
            if (_objSlot != -1) then {
                _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _objSlot];
                _VAL2 = [typeOf _parent, [getposATL _parent, vectordir _parent, vectorup _parent], _ac, _parent getVariable["BUILD_OWNER", "-1"], _parent getVariable["TEXTURE_SLOT", 0]];
                ["Building", _objHiveKey, EPOCH_expiresBuilding, _VAL2] call EPOCH_server_hiveSETEX;
            };
        };
        _am = [_ab, _ai, _ae, _al, _ap, _storageOwners, _storageParent];
        ["Storage", _ad, EPOCH_expiresBuilding, _am] call EPOCH_server_hiveSETEX;
        diag_log format["STORAGE: saved to hive %1 Pos %2 Owners %3 Parent %4", _ab, _ai, _storageOwners, _storageParent];
    };
};