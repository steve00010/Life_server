private["_aa", "_ab", "_ac", "_ad", "_ae", "_af"];
_ac = _this select 0;
_ad = _this select 1;
_af = _this select 2;
_token = _this select 3;
if !([_af, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _ac) exitWith {};
if (_af distance _ac > 20) exitWith {};
_plyrUID = getPlayerUID _af;
_objSlot = _ac getVariable["BUILD_SLOT", -1];
if (_objSlot != -1) then {
    _ae = _ac getVariable["TEXTURE_SLOT", 0];
    if (_ad != _ae) then {
        _ab = typeOf _ac;
        _aa = getArray(configFile >> "CfgVehicles" >> _ab >> "availableTextures");
        if !(_aa isEqualTo[]) then {
            _ac setObjectTextureGlobal[0, (_aa select _ad)];
            _ac setVariable["TEXTURE_SLOT", _ad, true];
            _slot = "-1";
            _worldspace = [(getposATL _ac), (vectordir _ac), (vectorup _ac)];
            _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _objSlot];
            _VAL = [_ab, _worldspace, _slot, _plyrUID, _ad];
            _return = ["Building", _objHiveKey, EPOCH_expiresBuilding, _VAL] call EPOCH_server_hiveSETEX;
        };
    };
};