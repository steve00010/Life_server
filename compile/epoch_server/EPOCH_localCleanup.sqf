_target = _this;
if (typename _this == "ARRAY") then {
    _target = _this select 0;
};
if (!isNull _target) then {
    _target addEventHandler["local", {
        if (_this select 1) then {
            private["_aa"];
            _aa = _this select 0; {
                _aa removeAllMPEventHandlers _x;
            }
            forEach["mpkilled", "mphit", "mprespawn"]; {
                _aa removeAllEventHandlers _x;
            }
            forEach["FiredNear", "HandleDamage", "Killed", "Fired", "GetOut", "GetIn", "Local"];
            deleteVehicle _aa;
            deleteGroup(group _aa);
        };
    }];
};