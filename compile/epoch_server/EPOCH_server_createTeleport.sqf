private["_aa", "_ab", "_ac", "_ad", "_ae"];
_debugLocation = getMarkerPos "respawn_west";
_debugLocation set[2, 0];
_debug = createVehicle["Debug_static_F", _debugLocation, [], 0, "CAN_COLLIDE"];
_protection = createVehicle["ProtectionZone_Invisible_F", _debugLocation, [], 0, "CAN_COLLIDE"];
_debug1 = createVehicle["clone_male_static_F", (_debug modelToWorld(_debug selectionPosition "2")), [], 0, "CAN_COLLIDE"];
_debug1 setDir - 90;
_debug2 = createVehicle["clone_female_static_F", (_debug modelToWorld(_debug selectionPosition "5")), [], 0, "CAN_COLLIDE"];
_debug2 setDir 90;
_debug3 = createVehicle["clone_male_static_F", (_debug modelToWorld(_debug selectionPosition "7")), [], 0, "CAN_COLLIDE"];
_debug3 setDir 90;
_config = configFile >> "CfgEpoch"; {
    _class = _x select 0;
    _ab = _x select 1;
    _dir = _x select 2;
    _ep = createVehicle[_class, _ab, [], 0, "CAN_COLLIDE"];
    if (_class isKindOf "ThingX") then {
        _ep enableSimulationGlobal false;
    };
    _ep allowDamage false;
    _ep setDir _dir;
    _ep setposATL _ab;
}
forEach(getArray(_config >> worldname >> "propsPos")); {
    _enterClass = _x select 0;
    _aa = _x select 1;
    _exitClass = _x select 2;
    _ab = _x select 3;
    _pro1 = createVehicle["ProtectionZone_Invisible_F", _aa, [], 0, "CAN_COLLIDE"];
    _ad = createVehicle[_enterClass, _aa, [], 0, "CAN_COLLIDE"];
    _ad enableSimulationGlobal false;
    _ad allowDamage false;
    _ad setVariable["ParentBuilding", _ab];
    _ad setDir 0;
    _ad setposATL _aa;
    if (_exitClass != "") then {
        _ae = createVehicle[_exitClass, _ab, [], 0, "CAN_COLLIDE"];
        _ae enableSimulationGlobal false;
        _ae allowDamage false;
        _ae setVariable["ParentBuilding", _aa];
        _ae setDir 0;
        _ae setposATL _ab;
    };
    _pro2 = createVehicle["ProtectionZone_Invisible_F", _ab, [], 0, "CAN_COLLIDE"];
}
foreach(getArray(_config >> worldname >> "telePos"));