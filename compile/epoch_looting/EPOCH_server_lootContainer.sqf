private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah", "_ai", "_aj", "_ak", "_al"];
_ad = _this select 0;
_ah = _this select 1;
_al = _this select 2;
if !([_ah, _al] call EPOCH_server_getPToken) exitWith {};
if (isNull _ad) exitWith {};
if !(alive _ad) exitWith {};
if (_ah distance _ad > 20) exitWith {};
if !(_ad in EPOCH_cleanupQueue) then {
    EPOCH_cleanupQueue pushBack _ad;
    _af = typeOf _ad;
    _animated = configFile >> "CfgVehicles" >> _af >> "Destruction" >> "animations";
    if (isArray _animated) then {
        _ad setDamage 1;
        diag_log format["DEBUG: lootContainer %1", _ad];
    };
    _config = (configFile >> "CfgMainTable" >> _af);
    _ag = getArray(_config >> "tables");
    if !(_ag isEqualTo[]) then {
        _ae = configFile >> "CfgVehicles" >> _af >> "weaponHolderProxy";
        _ai = getNumber(_config >> "count");
        if (isText _ae) then {
            _aa = getText(_ae);
            _ab = getPosATL _ad;
            _ac = getDir _ad;
            _ad = createVehicle[_aa, _ab, [], 0.0, "CAN_COLLIDE"];
            _ad setDir _ac;
            _ad setPosATL _ab;
        };
        if (_ai == 0) then {
            _ai = 2
        };
        [_ad, _ag, _ai] call EPOCH_serverLootObject;
    } else {
        [_ad, ["Food"], 2] call EPOCH_serverLootObject;
    };
    _aj = EPOCH_antagonistChanceLoot;
    if (_aa == "container_epoch") then {
        _aj = 0.9;
    };
    if ((random 1) <= _aj) then {
        _ak = floor(random 3);
        if (_aa == "container_epoch") then {
            _ak = 3;
        };
        [_ah, _ak] call EPOCH_server_triggerEvent;
    };
};