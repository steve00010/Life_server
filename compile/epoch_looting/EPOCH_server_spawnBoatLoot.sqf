private["_aa"]; {
    if ((random 1) <= 0.4) then {
        _aa = createVehicle["container_epoch", _x, [], 0, "NONE"];
        _aa setMass 220;
    };
}
foreach(getArray(configFile >> "CfgEpoch" >> worldname >> "containerPos"));