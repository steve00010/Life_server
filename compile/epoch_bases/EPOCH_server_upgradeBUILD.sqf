private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah"];
_object = _this select 0;
_player = _this select 1;
_token = _this select 2;
if (isNull _object) exitWith {};
if !([_player, _token] call EPOCH_server_getPToken) exitWith {};
_ah = _object getVariable["BUILD_SLOT", -1];
if (_ah != -1) then {
    _ag = getArray(configFile >> "CfgVehicles" >> (typeOf _object) >> "upgradeBuilding");
    if !(_ag isEqualTo[]) then {
        _aa = [getposATL _object, vectordir _object, vectorup _object];
        deleteVehicle _object;
        _ab = _ag select 0;
        _ac = createVehicle[_ab, (_aa select 0), [], 0, "CAN_COLLIDE"];
        _ac setVariable["BUILD_SLOT", _ah, true];
        _ac setVectorDirAndUp[(_aa select 1), (_aa select 2)];
        _ac setposATL(_aa select 0);
        _ad = format["%1:%2", (call EPOCH_fn_InstanceID), _ah];
        _ae = [_ab, _aa];
        _af = ["Building", _ad, EPOCH_expiresBuilding, _ae] call EPOCH_server_hiveSETEX;
    };
} else {
    diag_log format["DEBUG upgrade BUILD : %1 slot %2", _object, _ah];
};