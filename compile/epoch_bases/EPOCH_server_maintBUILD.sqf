private["_object", "_plyr", "_maintCount", "_plyrUID", "_counter", "_objSlot", "_objHiveKey"];
_object = _this select 0;
_plyr = _this select 1;
_maintCount = _this select 2;
if !([_plyr, _this select 3] call EPOCH_server_getPToken) exitWith {};
if (isNull _object) exitWith {};
if (_plyr distance _object > 20) exitWith {};
_plyrUID = getPlayerUID _plyr;
_counter = 0;
if (typeOf _object == "PlotPole_EPOCH") then {
    _objSlot = _object getVariable["BUILD_SLOT", -1];
    if (_objSlot != -1) then {
        _counter = _counter + 1;
        _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _objSlot];
        ["Building", _objHiveKey, EPOCH_expiresBuilding] call EPOCH_server_hiveEXPIRE;
        if (_maintCount > 1) then {
            {
                _object = _x;
                _objSlot = _object getVariable["BUILD_SLOT", -1];
                if (_objSlot != -1) then {
                    _counter = _counter + 1;
                    _objHiveKey = format["%1:%2", (call EPOCH_fn_InstanceID), _objSlot];
                    ["Building", _objHiveKey, EPOCH_expiresBuilding] call EPOCH_server_hiveEXPIRE;
                };
                if (_counter >= _maintCount) exitWith {};
            }
            forEach nearestObjects[_object, ["Constructions_static_F", "Constructions_foundation_F"], 300];
        };
        diag_log format["ADMIN: %1 maintained %2 base objects at %3", _plyrUID, _counter, getPosATL(_this select 0)];
    };
};