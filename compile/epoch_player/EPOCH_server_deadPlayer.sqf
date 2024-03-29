private["_playerObj", "_pos", "_veh", "_krypto"];
_playerObj = _this select 0;
_krypto = _this select 1;
_killer = _this select 2;
_token = _this select 4;
if !([_playerObj, _token] call EPOCH_server_getPToken) exitWith {};
_plyrUID = getPlayerUID _playerObj;
if (_playerObj != _killer) then {
    if (random 1 <= EPOCH_antagonistChancePDeath) then {
        _triggerType = 2;
        if (surfaceIsWater getPosATL player) then {
            _triggerType = 3;
        };
        [_killer, 2] call EPOCH_server_triggerEvent;
    };
    ['deathlog', format['%1 (%2) killed %3 (%4) with weapon %5', _this select 3, _plyrUID, name _killer, getPlayerUID _killer, currentWeapon _killer]] call EPOCH_server_hiveLog;
};
if (_krypto > 0) then {
    _pos = getposATL _playerObj;
    _veh = createVehicle["Land_MPS_EPOCH", _pos, [], 1.5, "CAN_COLLIDE"];
    diag_log format["ADMIN: Created crypto device for %1 with %2 at %3", getPlayerUID _playerObj, _krypto, _pos];
    _veh setVariable["Crypto", _krypto, true];
};
[_playerObj, EPOCH_defaultVars_SEPXVar] call EPOCH_server_savePlayer;
if (EPOCH_cloneCost > 0) then {
    _response = ["Bank", _plyrUID] call EPOCH_server_hiveGET;
    if ((_response select 0) == 1 && typeName(_response select 1) == "ARRAY") then {
        _bankData = _response select 1;
        _bankBalance = 0;
        if !(_bankData isEqualTo[]) then {
            _bankBalance = _bankData select 0;
        };
        _bankBalance = _bankBalance - EPOCH_cloneCost;
        ["Bank", _plyrUID, EPOCH_expiresBank, [_bankBalance]] call EPOCH_server_hiveSETEX;
    };
};