private["_aa"];
_aa = createVehicle["groundWeaponHolder", (_this select 0), [], 0.0, "CAN_COLLIDE"];
_aa setPosATL(_this select 0);
_class = "SeaFood";
if (isClass(configFile >> "CfgLootTable" >> (_this select 1))) then {
    _class = _this select 1;
};
[_aa, [_class], 1] call EPOCH_serverLootObject;
true