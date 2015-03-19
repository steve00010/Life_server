private[];
if (!(_this isKindOf "All")) then {
    if (alive _this) then {
        _this spawn {
            private["_aa", "_ab", "_ac", "_ad", "_ae"];
            _ac = ASLtoATL(getPosASL _this);
            _this setdamage 1;
            _ae = createVehicle["groundWeaponHolder", _ac, [], 0.0, "CAN_COLLIDE"];
            _ae setPosATL _ac;
            _config = (configFile >> "CfgMainTable" >> "Trash");
            if (random 1 < getNumber(_config >> "chance")) then {
                [_ae, getArray(_config >> "tables"), getNumber(_config >> "count")] call EPOCH_serverLootObject;
            };
            if ((random 1) <= EPOCH_antagonistChanceTrash) then {
                _nearPlayers = _ac nearEntities[["Epoch_Male_F", "Epoch_Female_F"], 50];
                if (!(_nearPlayers isEqualTo[])) then {
                    _target = _nearPlayers select(floor(random(count _nearPlayers)));
                    _triggerType = floor(random 3);
                    [_target, _triggerType] call EPOCH_server_triggerEvent;
                };
            };
        };
    };
};
true