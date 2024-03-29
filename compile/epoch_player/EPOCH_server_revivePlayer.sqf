private["_aa", "_ab", "_ac", "_ad", "_ae", "_af", "_ag", "_ah", "_ai", "_aj", "_ak", "_al", "_am", "_an", "_ao", "_ap", "_aq", "_ar", "_as", "_at", "_au", "_av", "_aw", "_ax", "_ay", "_az", "_aaa", "_aab", "_aac", "_ab", "_aae", "_aaf", "_aag", "_aah", "_aai", "_aaj", "_aak", "_aal", "_aam"];
_ac = _this select 0;
_owner = owner _ac;
_reviver = _this select 1;
_token = _this select 2;
if !([_reviver, _token] call EPOCH_server_getPToken) exitWith {};
if (isNull _ac) exitWith {};
if (_ac distance _reviver > 20) exitWith {};
if (!local _ac) then {
    _ad = getPlayerUID _ac;
    if (!isNil "_ad" && !alive _ac) then {
        if (_ac == _reviver) exitWith {
            'EpochServer'
            callExtension format['800|%1|EpochMod.com Autoban #199', getPlayerUID _reviver];
            ['ahb', format['%1 (%2): Tried to Revive yourself (%3)', name _reviver, getPlayerUID _reviver, _this]] call EPOCH_server_hiveLog;
        };
        _ah = typeOf _ac;
        if (_ah in ["Epoch_Male_F", "Epoch_Female_F"]) then {
            if (_ac getVariable["REVIVE", true]) then {
                diag_log format["DEBUG server_revivePlayer : %1", _this];
                _aj = getPosATL _ac;
                _ai = getDir _ac;
                _plyrGroup = _ac getVariable["GROUP", ""];
                _ay = goggles _ac;
                _az = headgear _ac;
                _aaa = vest _ac;
                _aab = backpack _ac;
                _aac = uniform _ac;
                _af = assignedItems _ac;
                _aag = magazinesAmmo _ac;
                _primaryWeapon = "";
                _secondaryWeapon = "";
                _droppedWeapons = []; {
                    {
                        _droppedWeapons pushBack _x;
                        _ak = getNumber(configfile >> "cfgweapons" >> (_x select 0) >> "type");
                        switch _ak do {
                            case 1:
                                {
                                    _primaryWeapon = _x select 0
                                };
                            case 4:
                                {
                                    _secondaryWeapon = _x select 0
                                };
                        };
                    }
                    forEach(weaponsItemsCargo _x);
                }
                forEach nearestObjects[_ac, ["WeaponHolderSimulated"], 9];
                diag_log["DEBUG: _droppedWeapons %1", _droppedWeapons];
                _aah = [getItemCargo(uniformContainer _ac), getItemCargo(vestContainer _ac), getItemCargo(backpackContainer _ac)];
                _aal = [getWeaponCargo(uniformContainer _ac), getWeaponCargo(vestContainer _ac), getWeaponCargo(backpackContainer _ac)];
                _aaf = [currentWeapon _ac, ((weaponsItems _ac) + _droppedWeapons), [_primaryWeapon, _secondaryWeapon, handgunWeapon _ac]];
                hideObjectGlobal _ac;
                _aam = grpNull;
                if (_plyrGroup != "") then {
                    {
                        if ((_x getVariable["GROUP", ""]) == _plyrGroup) exitWith {
                            _aam = group _x;
                        };
                    }
                    forEach playableUnits;
                    if (isNull _aam) then {
                        _aam = createGroup west;
                    };
                    diag_log format["DEBUG Group Found: %1", _aam];
                } else {
                    _aam = createGroup west;
                    diag_log format["DEBUG Group Created: %1", _aam];
                };
                _newPlyr = _aam createUnit[_ah, _aj, [], 0, "CAN_COLLIDE"];
                _newPlyr allowDammage false; {
                    _newPlyr disableAI _x;
                }
                forEach["FSM", "MOVE", "AUTOTARGET", "TARGET"];
                _newPlyr setVariable["SETUP", true];
                _newPlyr setVariable["PUID", _ad];
                _newPlyr setVariable["GROUP", _plyrGroup];
                _newPlyr setVariable["REVIVE", false];
                _newPlyr setDir _ai;
                _newPlyr setPosATL _aj;
                _newPlyr setFatigue 1;
                _newPlyr setDamage 0.25;
                if (_aac != "") then {
                    _newPlyr addUniform _aac;
                };
                if (_aab != "") then {
                    _newPlyr addBackpack _aab;
                };
                if (_ay != "") then {
                    _newPlyr addGoggles _ay;
                };
                if (_az != "") then {
                    _newPlyr addHeadgear _az;
                };
                if (_aaa != "") then {
                    _newPlyr addVest _aaa;
                };
                if (count _aaf >= 2) then {
                    _equipped = _aaf select 2; {
                        _am = _x select 0;
                        _ak = getNumber(configfile >> "cfgweapons" >> _am >> "type");
                        _aq = [];
                        for "_a"
                        from 1 to 3 do {
                            _attachment = _x select _a;
                            if (_attachment != "") then {
                                _aq pushBack _attachment;
                            };
                        };
                        _wMags = (count _x) == 5;
                        if (_am in _equipped) then {
                            _equipped = _equipped - [_am];
                            if (_wMags) then {
                                _newPlyr addMagazine(_x select 4);
                            };
                            if (_am != "") then {
                                _newPlyr addWeapon _am;
                            };
                            switch _ak do {
                                case 1:
                                    {
                                        removeAllPrimaryWeaponItems _newPlyr; {
                                            _newPlyr addPrimaryWeaponItem _x
                                        }
                                        forEach _aq;
                                    };
                                case 2:
                                    {
                                        removeAllHandgunItems _newPlyr; {
                                            _newPlyr addHandgunItem _x
                                        }
                                        forEach _aq;
                                    };
                                case 4:
                                    {
                                        {
                                            _newPlyr addSecondaryWeaponItem _x
                                        }
                                        forEach _aq;
                                    };
                            };
                        } else {
                            {
                                _newPlyr addItem _x;
                            }
                            forEach _aq;
                            if (_wMags) then {
                                _newPlyr addMagazine(_x select 4);
                            };
                        };
                    }
                    forEach(_aaf select 1);
                    _ar = (_aaf select 0);
                }; {
                    if (_x in ["Binocular", "Rangefinder"]) then {
                        _newPlyr addWeapon _x;
                    } else {
                        _newPlyr linkItem _x;
                    };
                }
                forEach _af; {
                    _as = _forEachIndex;
                    _at = _x select 1; {
                        for "_i"
                        from 1 to(_at select _forEachIndex) do {
                            switch _as do {
                                case 0:
                                    {
                                        _newPlyr addItemToUniform _x
                                    };
                                case 1:
                                    {
                                        _newPlyr addItemToVest _x
                                    };
                                case 2:
                                    {
                                        _newPlyr addItemToBackpack _x
                                    };
                            };
                        };
                    }
                    forEach(_x select 0);
                }
                forEach _aah; {
                    _as = _forEachIndex;
                    _at = _x select 1; {
                        for "_i"
                        from 1 to(_at select _forEachIndex) do {
                            switch _as do {
                                case 0:
                                    {
                                        _newPlyr addItemToUniform _x
                                    };
                                case 1:
                                    {
                                        _newPlyr addItemToVest _x
                                    };
                                case 2:
                                    {
                                        _newPlyr addItemToBackpack _x
                                    };
                            };
                        };
                    }
                    forEach(_x select 0);
                }
                forEach _aal; {
                    _newPlyr addMagazine _x;
                }
                forEach _aag;
                _token = _newPlyr call EPOCH_server_setPToken;
                [
                    ["clientRevive", [_newPlyr, _token]], _owner
                ] call EPOCH_sendPublicVariableClient;
            };
        };
    };
};