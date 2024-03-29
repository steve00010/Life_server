_unit = _this select 0;
_lockStatus = _this select 1;
_plyr = _this select 2;
_token = _this select 3;
if !([_plyr, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _unit) exitWith {};
if (_plyr distance _unit > 20) exitWith {};
_type = typeOf _unit;
if (_type in ["LockBox_EPOCH", "LockBoxProxy_EPOCH"]) then {
    _parentID = _unit getVariable["EPOCH_secureStorage", "-1"];
    _weaponHolder = missionNamespace getVariable[format["EPOCH_STORAGE_%1", _parentID], objNull];
    if (!isNull _weaponHolder) then {
        _owners = _weaponHolder getVariable["STORAGE_OWNERS", []];
        _plyrUID = getPlayerUID _plyr;
        _plyrGroup = _plyr getVariable["GROUP", ""];
        if (_plyrGroup != "") then {
            if (_plyrGroup in _owners) then {
                _unit setVariable["EPOCH_Locked", _lockStatus, true];
                _weaponHolder setPosATL(getPosATL _unit);
            } else {
                _response = ["Group", _plyrGroup] call EPOCH_server_hiveGET;
                if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
                    _gArray = _response select 1;
                    if ({
                            (_x select 0) in _owners
                        }
                        count(_gArray select 3) > 0 || {
                            (_x select 0) in _owners
                        }
                        count(_gArray select 4) > 0 ||
                        _plyrUID in _owners) then {
                        _unit setVariable["EPOCH_Locked", _lockStatus, true];
                        _weaponHolder setPosATL(getPosATL _unit);
                    };
                };
            };
        } else {
            if (_plyrUID in _owners) then {
                _unit setVariable["EPOCH_Locked", _lockStatus, true];
                _weaponHolder setPosATL(getPosATL _unit);
            };
        };
    };
    _parentID = _unit getVariable["EPOCH_secStorParent", -1];
    _parent = missionNamespace getVariable[format["EPOCH_BUILD_%1", _parentID], objNull];
    if (!isNull _parent) then {
        _owners = _unit getVariable["STORAGE_OWNERS", []];
        _plyrUID = getPlayerUID _plyr;
        _plyrGroup = _plyr getVariable["GROUP", ""];
        if (_plyrGroup != "") then {
            _response = ["Group", _plyrGroup] call EPOCH_server_hiveGET;
            if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
                _gArray = _response select 1;
                if ({
                        (_x select 0) in _owners
                    }
                    count(_gArray select 3) > 0 || {
                        (_x select 0) in _owners
                    }
                    count(_gArray select 4) > 0 ||
                    _plyrUID in _owners) then {
                    _parent setVariable["EPOCH_Locked", _lockStatus, true];
                    _currentPos = getPosATL _unit;
                    _currentPos set[2, -10];
                    _unit setPosATL _currentPos;
                };
            };
        } else {
            if (_plyrUID in _owners) then {
                _parent setVariable["EPOCH_Locked", _lockStatus, true];
                _currentPos = getPosATL _unit;
                _currentPos set[2, -10];
                _unit setPosATL _currentPos;
            };
        };
    };
};