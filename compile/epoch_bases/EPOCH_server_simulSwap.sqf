private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah", "_ai", "_aj"];
_ah = (_this select 0);
_ai = (_this select 1);
_ad = _ah;
_aj = _ah getVariable["BUILD_SLOT", -1];
if (_aj != -1) then {
    _aa = "staticClass";
    if (_ai) then {
        _aa = "simulClass";
    };
    _af = (typeOf _ah);
    _ag = (configFile >> "CfgVehicles" >> _af >> _aa);
    if (isText(_ag)) then {
        _ae = getText(_ag);
        if (_af != _ae) then {
            _textureSlot = _ah getVariable["TEXTURE_SLOT", 0];
            _ab = [(getposATL _ah), (vectordir _ah), (vectorup _ah)];
            deleteVehicle _ah;
            _ac = createVehicle[_ae, (_ab select 0), [], 0, "CAN_COLLIDE"];
            _ac setVariable["BUILD_SLOT", _aj, true];
            if (_textureSlot != 0) then {
                _color = getArray(configFile >> "CfgVehicles" >> _ae >> "availableTextures");
                if !(_color isEqualTo[]) then {
                    _ac setObjectTextureGlobal[0, (_color select _textureSlot)];
                    _ac setVariable["TEXTURE_SLOT", _textureSlot, true];
                };
            };
            _ac setVectorDirAndUp[(_ab select 1), (_ab select 2)];
            _ac setposATL(_ab select 0);
            _ad = _ac;
        };
    };
};
_ad