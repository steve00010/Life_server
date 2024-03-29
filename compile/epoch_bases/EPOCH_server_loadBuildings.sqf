private["_vehHiveKey", "_response", "_arr", "_arrCount", "_class", "_worldspace", "_storageSlot", "_owner", "_textureSlot", "_location", "_vdir", "_vup", "_baseObj", "_color", "_marker"];
for "_i"
from 0 to _this do {
    _vehHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _i];
    _response = ["Building", _vehHiveKey] call EPOCH_server_hiveGET;
    if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY" && !((_response select 1) isEqualTo[])) then {
        _arr = (_response select 1);
        _arrCount = count _arr;
        _class = _arr select 0;
        _worldspace = _arr select 1;
        _storageSlot = "-1";
        if (_arrCount >= 3) then {
            if ((typeName(_arr select 2)) == "SCALAR") then {
                _storageSlot = str(_arr select 2);
            } else {
                _storageSlot = _arr select 2;
            };
        };
        _owner = "-1";
        if (_arrCount >= 4) then {
            _owner = _arr select 3;
        };
        _textureSlot = 0;
        if (_arrCount >= 5) then {
            _textureSlot = _arr select 4;
        };
        _location = _worldspace deleteAt 0;
        if (isClass(configFile >> "CfgVehicles" >> _class)) then {
            _baseObj = createVehicle[_class, _location, [], 0, "CAN_COLLIDE"];
            _baseObj setposATL _location;
            if (_class == "LockBox_EPOCH") then {
                if ((_location select 2) < 0) then {
                    _location set[2, 0];
                    _baseObj setposATL _location;
                };
                if (_storageSlot != "-1") then {
                    _baseObj setVariable["EPOCH_secureStorage", _storageSlot];
                    _baseObj setVariable["EPOCH_Locked", true, true];
                };
            };
            _baseObj setVectorDirAndUp _worldspace;
            _baseObj call EPOCH_server_buildingInit;
            _baseObj setVariable["BUILD_SLOT", _i, true];
            if (_owner != "-1") then {
                _baseObj setVariable["BUILD_OWNER", _owner, true];
            };
            if (_textureSlot != 0) then {
                _color = getArray(configFile >> "CfgVehicles" >> _class >> "availableTextures");
                if !(_color isEqualTo[]) then {
                    _baseObj setObjectTextureGlobal[0, (_color select _textureSlot)];
                    _baseObj setVariable["TEXTURE_SLOT", _textureSlot, true];
                };
            };
            missionNamespace setVariable[format["EPOCH_BUILD_%1", _i], _baseObj];
            EPOCH_BuildingSlots set[_i, 1];
            if (EPOCH_DEBUG_VEH) then {
                _marker = createMarker[str(_location), _location];
                _marker setMarkerShape "ICON";
                _marker setMarkerType "mil_dot";
                _marker setMarkerText _class;
                _marker setMarkerColor "ColorRed";
            };
        } else {
            EPOCH_BuildingSlots set[_i, 0];
        };
    } else {
        EPOCH_BuildingSlots set[_i, 0];
    };
};
EPOCH_BuildingSlotCount = {
    _x == 0
}
count EPOCH_BuildingSlots;
publicVariable "EPOCH_BuildingSlotCount";
true