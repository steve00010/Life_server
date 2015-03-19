if !([_this select 0, _this select 3] call EPOCH_server_getPToken) exitWith {};
_target = _this select 1;
if (isNull _target) exitWith {};
_soundIndex = _this select 2;
_sound = EPOCH_sounds select _soundIndex;
if (!isNil "_sound") then {
    _range = EPOCH_soundsDistance select _soundIndex;
    _nearBy = (getPosATL _target) nearEntities[["Epoch_Male_F", "Epoch_Female_F"], _range]; {
        [
            ["say3D", [_target, _soundIndex]], owner _x
        ] call EPOCH_sendPublicVariableClient;
    }
    forEach(_nearBy - [_this select 0]);
};