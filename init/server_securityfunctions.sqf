comment 'Epoch Mod Antihack - Niklas Wagner - www.skaronator.com - Aaron Clark - www.epochmod.com - License: (CC) Attribution-NonCommercial-NoDerivatives 4.0 International';
_skn_enableAntihack = EPOCH_antihack_Enabled;
EPOCH_antihack_Enabled = nil;
_skn_check_addons = EPOCH_antihack_cfgPatchesCheck;
EPOCH_antihack_cfgPatchesCheck = nil;
_skn_check_files = EPOCH_antihack_checkFiles;
EPOCH_antihack_checkFiles = nil;
_skn_whitelist_cfgPatches = EPOCH_antihack_whitelistedCfgPatches;
EPOCH_antihack_whitelistedCfgPatches = nil;
_skn_inventoryOpenCheck = EPOCH_antihack_InvOpenCheck;
EPOCH_antihack_InvOpenCheck = nil;
_skn_adminsOwner = EPOCH_adminMenu_Owner;
EPOCH_adminMenu_Owner = nil;
_skn_adminsHigh = EPOCH_adminMenu_High;
EPOCH_adminMenu_High = nil;
_skn_adminsLow = EPOCH_adminMenu_Low;
EPOCH_adminMenu_Low = nil;
_skn_banReason = EPOCH_antihack_banReason;
EPOCH_antihack_banReason = nil;
_skn_adminMenuOwnerSetting = EPOCH_adminMenu_OwnerSetting;
EPOCH_adminMenu_OwnerSetting = nil;
_skn_adminMenuHighSetting = EPOCH_adminMenu_HighSetting;
EPOCH_adminMenu_HighSetting = nil;
_skn_adminMenuMenuKey = EPOCH_adminMenu_menuKey;
EPOCH_adminMenu_menuKey = nil;
_skn_adminMenuInfrontTeleport = EPOCH_adminMenu_infrontTeleport;
EPOCH_adminMenu_infrontTeleport = nil;
_skn_adminMenuLowSetting = EPOCH_adminMenu_LowSetting;
EPOCH_adminMenu_LowSetting = nil;
_skn_adminMenuBanReasons = EPOCH_adminMenu_BanReasons;
EPOCH_adminMenu_BanReasons = nil;
_skn_adminMenuCryproCfg = EPOCH_adminMenu_cryptoCfg;
EPOCH_adminMenu_cryptoCfg = nil;
_skn_cfgPatchesCfg = EPOCH_antihack_cfgPatchesCfg;
EPOCH_antihack_cfgPatchesCfg = nil;
_skn_PVSPrefix = EPOCH_antihack_PVSPrefix;
EPOCH_antihack_PVSPrefix = nil;
_skn_PVC_NAMES = ['tradeRequest', 'repairVehicle', 'lockVehicle', 'unlockVehicle', 'fillVehicle', 'clientRevive', 'earthQuake', 'unitSpawn', 'say3D', 'switchMove', 'bankBalance', 'effectCrypto', 'resetGroup', 'BADHIVE', 'groupUpdate', 'groupUidUpdate', 'groupInvitePlayer', 'serverMessage', 'healPlayer'];
_rndVAR_Count = 82 + (count _skn_PVC_NAMES);
_skn_rndVA = call compile('epochserver'
    callExtension format['810|%1', _rndVAR_Count]);
_skn_PVC_INDEX = _skn_rndVA deleteAt 0; {
    _ret = EPOCH_SERVER pushBack(_skn_rndVA deleteAt 0);
}
count _skn_PVC_NAMES;
EPOCH_sendPublicVariableClient = compileFinal("private ['_content','_index'];_content = _this select 0;_index = " + str _skn_PVC_NAMES + " find (_content select 0);if (_index != -1) then {" + _skn_PVC_INDEX + " = [" + str EPOCH_SERVER + " select _index, _content select 1];(_this select 1) publicVariableClient '" + _skn_PVC_INDEX + "';};");
_skn_AH_rndVarVehicle = _skn_rndVA deleteAt 0;
_skn_AH_rndVarPlayer = _skn_rndVA deleteAt 0;
EPOCH_server_getVToken = compileFinal("_this getVariable ['" + _skn_AH_rndVarVehicle + "',false]");
EPOCH_server_setVToken = compileFinal("_this setVariable ['" + _skn_AH_rndVarVehicle + "',true];true");
EPOCH_server_getPToken = compileFinal("_ret = false;if (typeName (_this select 0) == 'OBJECT') then {if (!isNull (_this select 0)) then {_var = (_this select 0) getVariable '" + _skn_AH_rndVarPlayer + "';if (!isNil '_var') then {_ret = _var == (_this select 1)}}};if (!_ret) then {(_this select 0) call EPOCH_server_kickToLobby};_ret");
EPOCH_server_setPToken = compileFinal("_var = 'epochserver' callExtension '810';_this setVariable ['" + _skn_AH_rndVarPlayer + "',_var];_var");
if (!_skn_enableAntihack) exitWith {
    EPOCH_server_pushPlayer = compileFinal("EPOCH_C_SET = _this select 2;EPOCH_C_SET pushBack '" + _skn_PVC_INDEX + "';EPOCH_C_SET pushBack '';(_this select 0) publicVariableClient 'EPOCH_C_SET'");
    EPOCH_server_isPAdmin = compileFinal("false");
    EPOCH_server_Authed = compileFinal("true");
    EPOCH_server_disconnect = compileFinal("true");
    EPOCH_server_kickToLobby = compileFinal("true");
};
_skn_AH_rndVarAHInitCheck = _skn_rndVA deleteAt 0;
call compile(_skn_AH_rndVarAHInitCheck + "=[];");
_skn_AH_Init = _skn_rndVA deleteAt 0;
_skn_AH_Code = _skn_rndVA deleteAt 0;
_skn_AH_Code_CA = _skn_rndVA deleteAt 0;
_skn_AH_Code_CB = _skn_rndVA deleteAt 0;
_skn_AH_Ban = _skn_rndVA deleteAt 0;
_skn_AH_rndVar = _skn_rndVA deleteAt 0;
_skn_doKickBan = _skn_PVSPrefix + (_skn_rndVA deleteAt 0);
_skn_server_getRealTime = _skn_rndVA deleteAt 0;
_skn_pv_hackerLog = _skn_rndVA deleteAt 0;
_skn_pv_adminLog = _skn_rndVA deleteAt 0;
_skn_server_adminLog = _skn_rndVA deleteAt 0;
_skn_doAdminRequest = _skn_PVSPrefix + (_skn_rndVA deleteAt 0);
_skn_doAdminLog = _skn_PVSPrefix + (_skn_rndVA deleteAt 0);
_skn_doTokenAuth = _skn_PVSPrefix + (_skn_rndVA deleteAt 0);
_skn_antiTeleportPVC = _skn_rndVA deleteAt 0;
_skn_Admin_Code = _skn_rndVA deleteAt 0;
_skn_Admin_Init = _skn_rndVA deleteAt 0;
_skn_adminRequest_PVC = _skn_rndVA deleteAt 0;
_skn_adminLog_PVC = _skn_rndVA deleteAt 0;
_skn_adminLog = _skn_rndVA deleteAt 0;
_skn_AdminKeyDown = _skn_rndVA deleteAt 0;
_skn_AdminMenu_Init = _skn_rndVA deleteAt 0;
_skn_getCtrl = _skn_rndVA deleteAt 0;
_skn_fnc_Spec = _skn_rndVA deleteAt 0;
_skn_Update_AdminButtons = _skn_rndVA deleteAt 0;
_skn_mainMenuCfg = _skn_rndVA deleteAt 0;
_skn_FillMainMenu = _skn_rndVA deleteAt 0;
_skn_FillPlayerMenu = _skn_rndVA deleteAt 0;
_skn_switchMainMenu = _skn_rndVA deleteAt 0;
_skn_dbClickMainMenu = _skn_rndVA deleteAt 0;
_skn_spawnMenu = _skn_rndVA deleteAt 0;
_skn_spawnSpawnMenu = _skn_rndVA deleteAt 0;
_skn_removespawnMenu = _skn_rndVA deleteAt 0;
_skn_fillSpawnMenu = _skn_rndVA deleteAt 0;
_skn_hackerLog = _skn_rndVA deleteAt 0;
_skn_switchTable = _skn_rndVA deleteAt 0;
_skn_customBanreason = _skn_rndVA deleteAt 0;
_skn_flipVehicle = _skn_rndVA deleteAt 0;
_skn_freeCam = _skn_rndVA deleteAt 0;
_skn_delete = _skn_rndVA deleteAt 0;
_skn_deleteMenu = _skn_rndVA deleteAt 0;
_skn_deleteNow = _skn_rndVA deleteAt 0;
_skn_doBan = _skn_rndVA deleteAt 0;
_skn_mapTeleport = _skn_rndVA deleteAt 0;
_skn_old_esp = _skn_rndVA deleteAt 0;
_skn_hideAdmin = _skn_rndVA deleteAt 0;
_skn_old_espMap = _skn_rndVA deleteAt 0;
_skn_infrontTP = _skn_rndVA deleteAt 0;
_skn_esp = _skn_rndVA deleteAt 0;
_skn_godMode = _skn_rndVA deleteAt 0;
_skn_repairVehicle = _skn_rndVA deleteAt 0;
_skn_spawnLoot = _skn_rndVA deleteAt 0;
_skn_mapLootArray = _skn_rndVA deleteAt 0;
_skn_tg_Spec = _skn_rndVA deleteAt 0;
_skn_tg_sortOrder = _skn_rndVA deleteAt 0;
_skn_tg_toggle = _skn_rndVA deleteAt 0;
_skn_tg_BanPlayer = _skn_rndVA deleteAt 0;
_skn_tg_delete = _skn_rndVA deleteAt 0;
_skn_tg_mapTeleport = _skn_rndVA deleteAt 0;
_skn_tg_spawnTyp = _skn_rndVA deleteAt 0;
_skn_tg_limitSpawn = _skn_rndVA deleteAt 0;
_skn_tg_old_espMap = _skn_rndVA deleteAt 0;
_skn_tg_old_esp = _skn_rndVA deleteAt 0;
_skn_tg_hideAdmin = _skn_rndVA deleteAt 0;
_skn_tg_infrontTP = _skn_rndVA deleteAt 0;
_skn_tg_godMode = _skn_rndVA deleteAt 0;
_skn_tg_map_player = _skn_rndVA deleteAt 0;
_skn_tg_map_corpse = _skn_rndVA deleteAt 0;
_skn_tg_map_loot = _skn_rndVA deleteAt 0;
_skn_tg_map_vehicle = _skn_rndVA deleteAt 0;
_skn_tg_map_ai = _skn_rndVA deleteAt 0;
_skn_tg_map_basebuilding = _skn_rndVA deleteAt 0;
_skn_t1 = _skn_rndVA deleteAt 0;
_skn_t2 = _skn_rndVA deleteAt 0;
_skn_t3 = _skn_rndVA deleteAt 0;
_skn_t4 = _skn_rndVA deleteAt 0;
_skn_t5 = _skn_rndVA deleteAt 0;
_skn_kickToLobby = _skn_rndVA deleteAt 0;
EPOCH_server_kickToLobby = compileFinal("if !(isNull _this) then {" + _skn_kickToLobby + " = true;(owner _this) publicVariableClient '" + _skn_kickToLobby + "';};");
_skn_AH_rndVarAHInitCheckToken = _skn_t1 + _skn_t2 + _skn_t3 + _skn_t4 + _skn_t5;
EPOCH_server_Authed = compileFinal("_this in " + _skn_AH_rndVarAHInitCheck);
EPOCH_server_disconnect = compileFinal("_ret = false;_index = " + _skn_AH_rndVarAHInitCheck + " find _this;if (_index != -1) then{" + _skn_AH_rndVarAHInitCheck + " deleteAt _index;_ret = true;};_ret ");
_stringInArray = {
    private "_ret";
    _ret = false; {
        if (_x in _case) exitWith {
            _ret = true
        }
    }
    forEach _this;
    _ret
};
_displays = [
    ["RscDisplayMainMap", [],
        []
    ],
    ["RscDisplayGetReady", [],
        []
    ],
    ["RscDisplayInventory", [],
        []
    ],
    ["RscDisplayLoadMission", [],
        []
    ],
    ["RscDisplayInterrupt", [],
        []
    ],
    ["RscDisplayOptionsVideo", [],
        []
    ],
    ["RscDisplayOptions", [],
        []
    ],
    ["RscDisplayAVTerminal", [],
        []
    ],
    ["RscDisplayConfigure", ["["
            "onLoad"
            ",_this,"
            "RscDisplayConfigure"
            ",'GUI'] call compile preprocessfilelinenumbers "
            "A3\ui_f\scripts\initDisplay.sqf"
            "; _this call compile preprocessfilelinenumbers "
            "\x\cba\addons\keybinding\gui\initDisplay.sqf"
            ""
        ],
        []
    ],
    ["RscDisplayConfigureAction", [],
        []
    ],
    ["RscDisplayConfigureControllers", [],
        []
    ],
    ["RscDisplayControlSchemes", [],
        []
    ],
    ["RscDisplayCustomizeController", [],
        []
    ],
    ["RscDisplayDebriefing", [],
        []
    ],
    ["RscDisplayDiary", [],
        []
    ],
    ["RscDisplayGameOptions", [],
        []
    ],
    ["RscDisplayJoystickSchemes", [],
        []
    ],
    ["RscDisplayLoading", [],
        []
    ],
    ["RscDisplayMicSensitivityOptions", [],
        []
    ],
    ["RscDisplayOptionsAudio", [],
        []
    ],
    ["RscDisplayOptionsLayout", [],
        []
    ],
    ["RscDisplayStart", [],
        []
    ],
    ["RscDisplayVehicleMsgBox", [],
        []
    ],
    ["RscDisplayInsertMarker", [],
        []
    ]
];
_escapeQuotes = {
    _return = []; {
        _return pushback _x;
        if (_x == 34) then {
            _return pushback _x;
        };
    }
    forEach toArray _this;
    toString _return
};
_cfg_displayArray = []; {
    _onLoad = ((getText(configFile >> (_x select 0) >> "onLoad")) call _escapeQuotes);
    _onUnload = ((getText(configFile >> (_x select 0) >> "onUnload")) call _escapeQuotes);
    _onLoad = [_onLoad];
    _onUnload = [_onUnload]; {
        _onLoad pushBack(_x call _escapeQuotes);
    }
    forEach(_x select 1); {
        _onUnload pushBack(_x call _escapeQuotes);
    }
    forEach(_x select 2);
    _cfg_displayArray pushBack[(_x select 0), _onLoad, _onUnload];
}
forEach _displays;
_skn_adminUIDArray = [];
_skn_adminNAMEArray = [];
_skn_tempuid = []; {
    _skn_adminUIDArray pushBack(_x select 0);
    _skn_adminNAMEArray pushBack(_x select 1);
}
forEach _skn_adminsOwner;
_skn_adminsOwner = _skn_adminUIDArray; {
    _skn_tempuid pushBack(_x select 0);
    _skn_adminUIDArray pushBack(_x select 0);
    _skn_adminNAMEArray pushBack(_x select 1);
}
forEach _skn_adminsHigh;
_skn_adminsHigh = _skn_tempuid;
_skn_tempuid = []; {
    _skn_adminUIDArray pushBack(_x select 0);
    _skn_tempuid pushBack(_x select 0);
    _skn_adminNAMEArray pushBack(_x select 1);
}
forEach _skn_adminsLow;
_skn_adminsLow = _skn_tempuid;
_skn_tempuid = nil; {
    _skn_adminMenuOwnerSetting set[_forEachIndex, toUpper _x]
}
forEach _skn_adminMenuOwnerSetting; {
    _skn_adminMenuHighSetting set[_forEachIndex, toUpper _x]
}
forEach _skn_adminMenuHighSetting; {
    _skn_adminMenuLowSetting set[_forEachIndex, toUpper _x]
}
forEach _skn_adminMenuLowSetting;
_skn_adminMenuOwner = "[]";
_skn_adminMenuHigh = "[]";
_skn_adminMenuLow = "[]";
_skn_blockedSpawnMenuUID = [];
if !("SPAWN-MENU" in _skn_adminMenuHighSetting) then {
    _skn_blockedSpawnMenuUID = _skn_adminsHigh
};
if !("SPAWN-MENU" in _skn_adminMenuLowSetting) then {
    {
        _skn_blockedSpawnMenuUID pushBack _x
    }
    forEach _skn_adminsLow
};
if !("SPAWN-MENU" in _skn_adminMenuOwnerSetting) then {
    {
        _skn_blockedSpawnMenuUID pushBack _x
    }
    forEach _skn_adminsOwner
};
_case = _skn_adminMenuOwnerSetting;
for "_i"
from 1 to 3 do {
    _temp = "[['=============== MAIN MENU ===============',[],'','1',[]]";
    if (["PLAYER-TELEPORT", "MAP-TELEPORT", "INFRONT-TELEPORT"] call _stringInArray) then {
        if ("PLAYER-TELEPORT" in _case) then {
            _temp = _temp + ",['  Player To Admin',[],{[101,_this select 1] call " + _skn_adminRequest_PVC + "},'4',[]],['  Admin To Player', [], { [102, _this select 1] call " + _skn_adminRequest_PVC + " },'4',[]]";
        };
        if ("INFRONT-TELEPORT" in _case) then {
            _temp = _temp + ",['  In Front', [], {" + _skn_tg_infrontTP + " = !" + _skn_tg_infrontTP + "},'2',[]]";
        };
        if ("MAP-TELEPORT" in _case) then {
            _temp = _temp + ",['  Ctrl+Click Map', [], {" + _skn_tg_mapTeleport + "=!" + _skn_tg_mapTeleport + ";['Map to Teleport', if (" + _skn_tg_mapTeleport + ") then[{2}, { 1 }]] call " + _skn_adminLog_PVC + " },'2',[]]";
        };
    };
    if (["FREE-CAM", "INVISIBLE"] call _stringInArray) then {
        _temp = _temp + ",['Spectate', [],'','1',[]]";
        if ("MAP-TELEPORT" in _case) then {
            _temp = _temp + ",['  Free Look Cam ', [], " + _skn_freeCam + ",'0',[]]";
        };
        if ("INVISIBLE" in _case) then {
            _temp = _temp + ",['  Invisible Mode', [], " + _skn_hideAdmin + ", '2', []]";
        };
    };
    if (["MAP-PLAYER", "MAP-CORPSE", "MAP-LOOT", "MAP-VEHICLE", "MAP-AI", "MAP-BASEBUILDING"] call _stringInArray) then {
        _temp = _temp + ",['Map Tools', [],'','1',[]]";
        if ("MAP-PLAYER" in _case) then {
            _temp = _temp + ",['  Player Marker', [], {" + _skn_tg_map_player + " = !" + _skn_tg_map_player + "; ['Player MARKER',if (" + _skn_tg_map_player + ") then [{2},{1}]] call " + _skn_adminLog_PVC + "}, '2', []]";
        };
        if ("MAP-CORPSE" in _case) then {
            _temp = _temp + ",['  Corpse Marker', [], {" + _skn_tg_map_corpse + " = !" + _skn_tg_map_corpse + "; ['Corpse MARKER',if (" + _skn_tg_map_corpse + ") then [{2},{1}]] call " + _skn_adminLog_PVC + "}, '2', []]";
        };
        if ("MAP-LOOT" in _case) then {
            _temp = _temp + ",['  Loot Marker', [], {" + _skn_tg_map_loot + " = !" + _skn_tg_map_loot + "; if (" + _skn_tg_map_loot + ") then {waitUntil {" + _skn_mapLootArray + " = nearestObjects[getPos player, ['WH_Loot', 'Animated_Loot'], 10000];uiSleep 1;!" + _skn_tg_map_loot + "};" + _skn_mapLootArray + " = []};['Loot MARKER',if (" + _skn_tg_map_loot + ") then [{2},{1}]] call " + _skn_adminLog_PVC + "}, '2', []]";
        };
        if ("MAP-VEHICLE" in _case) then {
            _temp = _temp + ",['  Vehicle Marker', [], {" + _skn_tg_map_vehicle + " = !" + _skn_tg_map_vehicle + "; ['Vehicle MARKER',if (" + _skn_tg_map_vehicle + ") then [{2},{1}]] call " + _skn_adminLog_PVC + "}, '2', []]";
        };
        if ("MAP-AI" in _case) then {
            _temp = _temp + ",['  AI Marker', [], {" + _skn_tg_map_ai + " = !" + _skn_tg_map_ai + "; ['AI MARKER',if (" + _skn_tg_map_ai + ") then [{2},{1}]] call " + _skn_adminLog_PVC + "}, '2', []]";
        };
        if ("MAP-BASEBUILDING" in _case) then {
            _temp = _temp + ",['  Base Building Marker (WIP)', [], {" + _skn_tg_map_basebuilding + " = !" + _skn_tg_map_basebuilding + "; ['Base Building MARKER',if (" + _skn_tg_map_basebuilding + ") then [{2},{1}]] call " + _skn_adminLog_PVC + "}, '2', []]";
        };
    };
    if (["ESP-PLAYER", "ESP-LOOT", "ESP-VEHICLE"] call _stringInArray) then {
        _temp = _temp + ",['3D Tools', [],'','1',[]]";
        if ("ESP-PLAYER" in _case) then {
            _temp = _temp + ",['  Player ESP', true, " + _skn_esp + ", '2', []]";
        };
        if ("ESP-VEHICLE" in _case) then {
            _temp = _temp + ",['  Vehicle ESP', false, " + _skn_esp + ", '2', []]";
        };
        if ("ESP-LOOT" in _case) then {
            _temp = _temp + ",['  Loot ESP (WIP)', [], '', '1', []]";
        };
    };
    if (["OLD-ESP", "OLD-MAP"] call _stringInArray) then {
        _temp = _temp + ",['Old Visualisation Tools', [],'','1',[]]";
        if ("OLD-ESP" in _case) then {
            _temp = _temp + ",['  3D ESP', [], " + _skn_old_esp + ", '2', []]";
        };
        if ("OLD-MAP" in _case) then {
            _temp = _temp + ",['  MAP ESP', [], " + _skn_old_espMap + ", '2', []]";
        };
    };
    if (["GODMODE", "HEAL", "VEHICLEREPAIR"] call _stringInArray) then {
        _temp = _temp + ",['Self Menu', [], '', '1', []]";
        if ("GODMODE" in _case) then {
            _temp = _temp + ",['  Godmode', [], " + _skn_godMode + ", '2', []]";
        };
        if ("HEAL" in _case) then {
            _temp = _temp + ",['  Heal',[],{[103,netId player] call " + _skn_adminRequest_PVC + "},'4',[0.016,0.702,0.078,1]]";
        };
        if ("VEHICLEREPAIR" in _case) then {
            _temp = _temp + ",['  Repair Vehicle', [], " + _skn_repairVehicle + ", '0', []]";
        };
    };
    if (["TARGET-HEAL", "TARGET-AMMO", "TARGET-KILL", "TARGET-CRYPTO", "TARGET-VEHICLEREPAIR"] call _stringInArray) then {
        _temp = _temp + ",['Target Actions', [], '', '1', []]";
        if ("TARGET-HEAL" in _case) then {
            _temp = _temp + ",['  Heal',[],{[103,_this select 1] call " + _skn_adminRequest_PVC + "},'4',[0.016,0.702,0.078,1]]";
        };
        if ("TARGET-KILL" in _case) then {
            _temp = _temp + ",['  Kill',[],{[100,_this select 1] call " + _skn_adminRequest_PVC + "},'4',[0.859,0.094,0.094,1]]";
        };
        if ("TARGET-AMMO" in _case) then {
            _temp = _temp + ",['  Give Ammo',[],{[200,_this select 1] call " + _skn_adminRequest_PVC + "},'4',[]]";
        };
        if ("TARGET-VEHICLEREPAIR" in _case) then {
            _temp = _temp + ",['  Repair Vehicle', [], " + _skn_flipVehicle + ", '0', []]";
        };
        if ("TARGET-CRYPTO" in _case) then {
            {
                _temp = _temp + ",['  Give Crypto - " + str _x + "'," + str _x + ",{[107,[_this select 1,_this select 2]] call " + _skn_adminRequest_PVC + "},'4',[]]"
            }
            count _skn_adminMenuCryproCfg;
        };
    };
    _temp = _temp + ",['Custom Stuff', [], '', '1', []]";
    if ("VEHICLEFLIP" in _case) then {
        _temp = _temp + ",['  Unflip Vehicle', [], " + _skn_flipVehicle + ", '0', []]";
    };
    if ("SPAWNLOOT" in _case) then {
        _temp = _temp + ",['  Loot Buildings (25m)', 25, " + _skn_spawnLoot + ", '0', []]";
    };
    _temp = _temp + ",['  Disconnect yourself', [], { (findDisplay 46) closeDisplay 0 }, '0', []]";
    if ("BANPANNEL" in _case) then {
        _temp = _temp + ",['Ban Menu',[],'','1',[]],['  BattlEye Ban - Custom Ban Reason',[]," + _skn_customBanreason + ",'4',[]]"; {
            _temp = _temp + ",['  BattlEye Ban - " + _x + "','" + _x + "'," + _skn_customBanreason + ",'4',[]]"
        }
        count _skn_adminMenuBanReasons;
    };
    _temp = _temp + ",['Key Binds',[],'','1',[]],['  3 Key - Teleport In Front',[],'','1',[]],['  F2 - Cancel Spectating',[],'','1',[]],['  F5 - Delete Target',[],'','1',[]]];";
    if (_i == 1) then {
        _skn_adminMenuOwner = _temp;
        _case = _skn_adminMenuHighSetting;
    };
    if (_i == 2) then {
        _skn_adminMenuHigh = _temp;
        _case = _skn_adminMenuLowSetting;
    };
    if (_i == 3) then {
        _skn_adminMenuLow = _temp;
    };
};
_skn_spawnPointCenter = getArray(configFile >> "CfgEpoch" >> worldname >> "telePosCenter");
if (_skn_PVSPrefix == "") then {
    "epochserver"
    callExtension format["800|%1|%2|%3|%4", _skn_doKickBan, _skn_doAdminRequest, _skn_doAdminLog, _skn_doTokenAuth];
};
EPOCH_server_pushPlayer = compileFinal("EPOCH_C_SET = _this select 2;if (_this select 1 in " + str _skn_adminUIDArray + ") then {(_this select 0) publicVariableClient '" + _skn_Admin_Code + "';(_this select 0) publicVariableClient '" + _skn_pv_adminLog + "';(_this select 0) publicVariableClient '" + _skn_pv_hackerLog + "';EPOCH_C_SET pushBack '" + _skn_PVC_INDEX + "';EPOCH_C_SET pushBack '[] spawn " + _skn_Admin_Init + "';} else {EPOCH_C_SET pushBack '" + _skn_PVC_INDEX + "';EPOCH_C_SET pushBack '[] spawn " + _skn_AH_Init + "';};(_this select 0) publicVariableClient 'EPOCH_C_SET';true");
EPOCH_server_isPAdmin = compileFinal("if (isNull _this) then {false} else {getPlayerUID _this in " + str _skn_adminUIDArray + "}");
_sknBanANDSleep = _skn_AH_Ban + "; uiSleep 60";
_sknPatches = [];
"_sknPatches pushBack (configName _x)"
configClasses(configFile >> "CfgPatches"); {
    if !(_x in _sknPatches) then {
        _sknPatches pushBack _x
    }
}
forEach _skn_whitelist_cfgPatches;
_skn_addonCheckCode =
    if (_skn_check_addons) then {
        "[] spawn{_config = '!(configName _x in " + str _sknPatches + ")' configClasses (configFile >> 'CfgPatches');if !(_config isEqualTo []) then {[format['Disallowed Addon %1',_config]," + str(_skn_cfgPatchesCfg select 0) + "] call " + _skn_AH_Ban + "}};"
    } else {
        ""
    };
_skn_fileCheckCode =
    if (_skn_check_files isEqualTo[]) then {
        ""
    } else {
        "{if(str(compile preprocessFileLineNumbers (_x select 0)) != str(missionNamespace getVariable [_x select 1,'']))exitWith{[format['Modified File %1 (%2/%3)',_x select 1,count toArray str (compile preprocessFileLineNumbers (_x select 0)),count toArray str(missionNamespace getVariable [_x select 1,''])],0] call " + _skn_AH_Ban + "}} forEach " + str _skn_check_files + ";"
    };
_sknInvOpenCheck =
    if (_skn_inventoryOpenCheck isEqualTo[]) then {
        "(locked (_this select 1) in [2, 3])"
    } else {
        "!((_this select 1) nearEntities[['Epoch_Male_F', 'Epoch_Female_F'], " + str(_skn_inventoryOpenCheck select 0) + "] isEqualTo [player]) || (locked (_this select 1) in [2, 3])"
    };
call compile(_skn_server_getRealTime + " = {_time = call compile ('EpochServer' callExtension '510');_hour = _time select 3;_min = _time select 4;if (_min < 10) then {_min = '0'+str _min};if (_hour < 10) then {_hour = '0'+str _hour};format ['%1:%2',_hour,_min]};");
call compile("'" + _skn_doTokenAuth + "' addPublicVariableEventHandler {_array = _this select 1;_tokenSet = false;if !([_array select 1, _array select 2] call EPOCH_server_getPToken) exitWith{};if (typeName(_array select 0) == 'STRING') then {if (_array select 0 == '" + _skn_AH_rndVarAHInitCheckToken + "') then{_tokenSet = true;_puid = (_array select 1) getVariable['PUID', ''];if (_puid != '') then{if !(_puid in " + _skn_AH_rndVarAHInitCheck + ") then{" + _skn_AH_rndVarAHInitCheck + " pushBack _puid;diag_log format['DEBUG: player auth token set %1', _array];};};};};if !(_tokenSet) then {(_array select 1) call EPOCH_server_kickToLobby;};};");
call compile("'" + _skn_doKickBan + "' addPublicVariableEventHandler {_array = _this select 1;_player =_array select 2;if !([_player,_array select 3] call EPOCH_server_getPToken) exitWith {['ahe', format['Token is different [%1,%2] %3',if (!isNull _player) then { _player getVariable ['" + _skn_AH_rndVarPlayer + "','']}else{'PlayerObj NULL'}, _array select 3, _array]] call EPOCH_server_hiveLog;};if ((_array select 1) == 0) then {['ahb', format['%1 (%2): %3', name _player, getPlayerUID _player, _array select 0]] call EPOCH_server_hiveLog;" + _skn_pv_hackerLog + " pushBack [[0,call " + _skn_server_getRealTime + ",name _player,getPlayerUID _player,_array select 0],[1, 0, 0, 1]];_banID = 0;'epochserver' callExtension format['820|%1|" + _skn_banReason + " #%2',getPlayerUID _player,_banID];} else {['ahl', format['%1 (%2): %3', name _player, getPlayerUID _player, _array select 0]] call EPOCH_server_hiveLog;" + _skn_pv_hackerLog + " pushBack [[1,call " + _skn_server_getRealTime + ",name _player,getPlayerUID _player,_array select 0],[]];};{if (_x call EPOCH_server_isPAdmin) then {(owner _x) publicVariableClient '" + _skn_pv_hackerLog + "';};}forEach playableUnits;};");
_skn_code_ban = compileFinal("_this pushBack player;_this pushBack Epoch_personalToken;" + _skn_doKickBan + " = _this;publicVariableServer '" + _skn_doKickBan + "';true");
_skn_code_init = compileFinal("comment 'Epoch Mod Antihack - Niklas Wagner - www.skaronator.com - Aaron Clark - www.epochmod.com - License: (CC) Attribution-NonCommercial-NoDerivatives 4.0 International';waitUntil {(getPlayerUID player) != ''};_start = diag_tickTime;waitUntil {!isNil '" + _skn_AH_Code + "' || (diag_tickTime-_start > 20)};if(isNil '" + _skn_AH_Code + "') exitWith {" + _skn_doKickBan + " = [format['Cannot Load AH [%1,%2]',!isNil '" + _skn_AH_Code_CA + "',!isNil '" + _skn_AH_Code_CB + "'],1,player,Epoch_personalToken];publicVariableServer '" + _skn_doKickBan + "';(findDisplay 46) closeDisplay 0};[] spawn " + _skn_AH_Code + ";uiSleep 3;if ((isNil '" + _skn_AH_Code_CA + "') || (isNil '" + _skn_AH_Code_CB + "')) then {uiSleep 5;if ((isNil '" + _skn_AH_Code_CA + "') || (isNil '" + _skn_AH_Code_CB + "')) then {[] spawn " + _skn_AH_Code + ";uiSleep 3;};};uiSleep 5;if ((isNil '" + _skn_AH_Code_CA + "') || (isNil '" + _skn_AH_Code_CB + "')) then {" + _skn_doKickBan + " = [format['Cannot Load AH [%1,%2]',!isNil '" + _skn_AH_Code_CA + "',!isNil '" + _skn_AH_Code_CB + "'],1,player,Epoch_personalToken];publicVariableServer '" + _skn_doKickBan + "';(findDisplay 46) closeDisplay 0};");
_skn_code_antihack = compileFinal("comment 'Epoch Mod Antihack - Niklas Wagner - www.skaronator.com - Aaron Clark - www.epochmod.com - License: (CC) Attribution-NonCommercial-NoDerivatives 4.0 International';if ((!isNil '" + _skn_AH_Code_CA + "') && (!isNil '" + _skn_AH_Code_CB + "')) exitWith {};" + _skn_AH_Code_CA + " = true;" + _skn_addonCheckCode + "_t = '" + _skn_t1 + "';[] spawn {uiSleep 5;FW" + _skn_AH_rndVar + " = '';FA" + _skn_AH_rndVar + " = 0;FWC" + _skn_AH_rndVar + " = 0;_sknOnFire = {_wep = _this select 1;_ammo = player ammo _wep;if !(_wep in ['Throw','Put']) then {if (FW" + _skn_AH_rndVar + " == _wep && FA" + _skn_AH_rndVar + " == _ammo) then {if (FWC" + _skn_AH_rndVar + " > 1) then {[format['[TEST] Unlimited Ammo: [%1,%2]', _wep, _ammo], 1] call " + _skn_AH_Ban + ";[] spawn {uiSleep 60;FWC" + _skn_AH_rndVar + " = 0};};FWC" + _skn_AH_rndVar + " = FWC" + _skn_AH_rndVar + " +1;[] spawn {uiSleep 20;FWC" + _skn_AH_rndVar + " = 0};};};FA" + _skn_AH_rndVar + " = _ammo;FW" + _skn_AH_rndVar + " = _wep;true};uiNamespace setVariable['RscDisplayRemoteMissions',displayNull];uiNamespace setVariable['RscDisplayArsenal',displayNull];missionnamespace setVariable['BIS_fnc_showNotification_queue',nil];while {true} do {{if (!isNull (_x select 0)) then {[format['Menu: %1',_x select 1],0] call " + _sknBanANDSleep + ";};}forEach[[(findDisplay 64) displayCtrl 1002,'findDisplay 64'],[(findDisplay 49) displayCtrl 0,'findDisplay 49'],[uiNamespace getVariable 'RscDisplayRemoteMissions','RscDisplayRemoteMissions'],[uiNamespace getVariable 'RscDisplayArsenal','RscDisplayArsenal'],[missionnamespace getvariable 'BIS_fnc_showNotification_queue','showNotification']];{if (!isNull (findDisplay _x)) then {[format['Menu: findDisplay %1',_x],0] call " + _sknBanANDSleep + ";};}forEach[-1337,17,19,30,32,45,59,69,71,125,132,155,156,157,162,165,166,167,312,1320,1321,2727,2928,2929,316000];if (!isNull (uiNamespace getVariable 'RscDisplayConfigureAction')) then {_ctrlTxt = toLower ctrlText 1000;if (_ctrlTxt != '') then {if (_ctrlTxt != toLower localize 'STR_A3_RscDisplayConfigureAction_Title') then {[format['Menu: RscDisplayConfigureAction-A %1',_ctrlTxt],0] call " + _sknBanANDSleep + ";};};{if (buttonAction _x != '') then {[format['Menu: RscDisplayConfigureAction-B (%1)',_x],0] call " + _sknBanANDSleep + ";};}forEach [1,104,105,106,107,108,109];};if (!isNull (uiNamespace getVariable 'RscDisplayInsertMarker')) then {_ctrlTxt = toLower ctrlText 1001;if (_ctrlTxt != '') then {if (_ctrlTxt != toLower localize 'STR_A3_RscDisplayInsertMarker_Title') then {[format['Menu: RscDisplayInsertMarker-A %1',_ctrlTxt],0] call " + _sknBanANDSleep + ";};};if ((buttonAction 1 != '') || (buttonAction 2 != '')) then {[format['Menu: RscDisplayInsertMarker-B [%1,%2]',buttonAction 1,buttonAction 2],0] call " + _sknBanANDSleep + ";};};if (!isNull (findDisplay 129)) then {closeDialog 0};if !(commandingMenu in ['','RscSelectTeam','RscTeam','RscMoveHigh','#GETIN','#RscStatus','#WATCH0','RscCombatMode','RscMenuReply','RscCallSupport','#CUSTOM_RADIO','#User:BIS_fnc_addCommMenuItem_menu','RscRadio','RscReply','#ACTION','RscMenuFormations','#WATCH','RscGroupRootMenu','RscMainMenu','RscMenuMove','RscWatchDir','RscWatchMoveDir','#User:BIS_Menu_GroupCommunication','RscMenuStatus','RscFormations']) then {[format['Menu: commandMenu: %1',commandingMenu],0] call " + _sknBanANDSleep + ";};onMapSingleClick '';player allowDamage true;vehicle player allowDamage true;setTerrainGrid 25;onEachFrame EPOCH_onEachFrame;_addCase = addMissionEventHandler ['Draw3D', {}];removeMissionEventHandler ['Draw3D',0];if (_addCase > 0) then {[format['MEH: Draw3D %1',_addCase],0] call " + _sknBanANDSleep + ";};player removeEventHandler ['Fired', 0];_addCase = player addEventHandler ['Fired',compile ('_this call EPOCH_fnc_playerFired;_this call '+str(_sknOnFire))];if (_addCase > 0) then {[format['EH: Fired %1',_addCase],0] call " + _sknBanANDSleep + ";};player removeEventHandler['InventoryClosed', 0];_addCase = player addEventHandler['InventoryClosed', {if !(EPOCH_arr_interactedObjs isEqualTo[]) then{ EPOCH_S_S_VEHICLES = EPOCH_arr_interactedObjs; publicVariableServer 'EPOCH_S_S_VEHICLES'; EPOCH_arr_interactedObjs = [];};}];if (_addCase > 0) then{[format['EH: InventoryClosed %1', _addCase], 0] call " + _sknBanANDSleep + ";};player removeEventHandler['InventoryOpened', 0];_addCase = player addEventHandler['InventoryOpened', {" + _sknInvOpenCheck + "}];if (_addCase > 0) then{[format['EH: InventoryOpened %1', _addCase], 0] call " + _sknBanANDSleep + ";};player removeEventHandler ['Killed', 0];_addCase = player addEventHandler ['Killed', {_this call EPOCH_fnc_playerDeath}];if (_addCase > 0) then {[format['EH: Killed %1',_addCase],0] call " + _sknBanANDSleep + ";};{_addCase = player addEventHandler [_x, {}];player removeEventHandler [_x, 0];if (_addCase > 0) then {[format['EH: %1 %2',_x,_addCase],0] call " + _sknBanANDSleep + ";};}forEach ['HandleDamage','FiredNear','HandleHeal','Dammaged','Hit','HitPart'];uiSleep 0.01;};};_t = _t + '" + _skn_t2 + "';[] spawn {disableSerialization;_rndA = random 99999;_rndB = compile str floor random 3;_rndC = compile str floor random 3;life_cash = _rndA;life_adminlevel = _rndB;life_coplevel = _rndC;_ActionCount = -1;_ActionVehicle = player;_displayCountKD = 0;_displayCount = 0;_personalToken = Epoch_personalToken;_antiWallCount = 0;EPOCH_ESP_PLAYER = false;EPOCH_ESP_VEHICLES = false;EPOCH_ESP_VEHICLEPLAYER = [];waitUntil{!isNull (findDisplay 46)};if (viewDistance != 1600) then {setViewDistance 1600};uiSleep 10;while {true} do {if (isNil 'Epoch_personalToken') then {" + _skn_doKickBan + " = [format['personalToken NIL: %1/%2',Epoch_personalToken,_personalToken],0,player,_personalToken];publicVariableServer '" + _skn_doKickBan + "';uiSleep 60;};{if (isNil _x) then {[format['%1: nil',_x],0] call " + _sknBanANDSleep + ";};}forEach['EPOCH_antiWallCount','EPOCH_playerEnergy','EPOCH_playerHunger','EPOCH_playerStamina','EPOCH_playerCrypto','EPOCH_target','EPOCH_ESP_TARGETS','EPOCH_ESPMAP_TARGETS','EPOCH_taxRate','EPOCH_ESP_VEHICLEPLAYER','EPOCH_ESP_PLAYER','EPOCH_ESP_VEHICLES'];if !(groupIconsVisible isEqualTo [false,false]) then {[format['GroupIcons %1',groupIconsVisible],0] call " + _sknBanANDSleep + ";};if (unitRecoilCoefficient player != 1) then {[format['Recoil %1',unitRecoilCoefficient player],0] call " + _sknBanANDSleep + ";};if (animationState player in ['AmovPercMstpSnonWnonDnon_exerciseKata','AmovPercMstpSnonWnonDnon_exercisePushup','GestureSpasm1','GestureSpasm4','GestureNod']) then {[format['BadMove: %1',animationState player],0] call " + _sknBanANDSleep + ";};if (EPOCH_playerEnergy > 2500 || EPOCH_playerEnergy < 0) then {[format['Energy: %1',EPOCH_playerEnergy],0] call " + _sknBanANDSleep + ";};if (EPOCH_playerHunger > 5000 || EPOCH_playerHunger < 0) then {[format['Hunger: %1',EPOCH_playerHunger],0] call " + _sknBanANDSleep + ";};if (EPOCH_playerThirst > 2500 || EPOCH_playerThirst < 0) then {[format['Thirsk: %1',EPOCH_playerThirst],0] call " + _sknBanANDSleep + ";};if (EPOCH_playerStamina > 2500 || EPOCH_playerStamina < 0) then {[format['Stamina: %1',EPOCH_playerStamina],0] call " + _sknBanANDSleep + ";};if (EPOCH_playerCrypto > 25000 || EPOCH_playerCrypto < 0) then {[format['Crypto: %1',EPOCH_playerCrypto],0] call " + _sknBanANDSleep + ";};if (_antiWallCount != EPOCH_antiWallCount) then {if (_antiWallCount > EPOCH_antiWallCount) then {[format['antiWall: %1/%2',EPOCH_antiWallCount,_antiWallCount],0] call " + _sknBanANDSleep + ";};_antiWallCount = EPOCH_antiWallCount;};if (EPOCH_target isEqualTo player) then {[format['setVelocityTarget: %1', EPOCH_target], 0] call " + _sknBanANDSleep + ";};if !(EPOCH_ESP_TARGETS isEqualTo []) then{[format['ESP-O: %1', EPOCH_ESP_TARGETS], 0] call " + _sknBanANDSleep + ";};if !(EPOCH_ESPMAP_TARGETS isEqualTo []) then{[format['MAP-ESP: %1', EPOCH_ESPMAP_TARGETS], 0] call " + _sknBanANDSleep + ";};if !(EPOCH_ESP_VEHICLEPLAYER isEqualTo []) then{[format['ESP-N: %1', EPOCH_ESP_VEHICLEPLAYER], 0] call " + _sknBanANDSleep + ";};if (EPOCH_ESP_PLAYER || EPOCH_ESP_VEHICLES) then {[format['ESP-N: %1', EPOCH_ESP_VEHICLES], 0] call " + _sknBanANDSleep + ";};if (EPOCH_taxRate != " + str EPOCH_taxRate + ") then {[format['taxTate: %1',EPOCH_taxRate],0] call " + _sknBanANDSleep + ";};if !(EPOCH_group_upgrade_lvl isEqualTo " + str EPOCH_group_upgrade_lvl + ") then {[format['groupUpgradeLvL: %1',EPOCH_group_upgrade_lvl],0] call " + _sknBanANDSleep + ";};if (_rndA != life_cash) then {[format['Altis Life MH: %1',life_cash],0] call " + _sknBanANDSleep + ";};if !(_rndB isEqualTo life_adminlevel) then {[format['Altis Life AH: %1',life_adminlevel],0] call " + _sknBanANDSleep + ";};if !(_rndC isEqualTo life_coplevel) then {[format['Altis Life CH: %1',life_adminlevel],0] call " + _sknBanANDSleep + ";};if (viewDistance != 1600) then {[format['viewDistance %1',viewDistance],0] call " + _sknBanANDSleep + ";};if (player == _ActionVehicle) then [{_ActionCount = _ActionCount + 1},{_ActionVehicle = player; _ActionCount = 0}];_addCase = player addAction ['', '', [], -5, false, true, '', 'false'];player removeAction _addCase;if (_addCase != _ActionCount) then {[format['addAction %1/%2',_addCase,_ActionCount],0] call " + _sknBanANDSleep + ";};_display46 = findDisplay 46;if (isNull _display46) then {_displayCountKD = 0;_displayCount = 0;} else {_display46 displayRemoveAllEventHandlers 'KeyDown';_addCase = _display46 displayAddEventHandler ['KeyDown',{_this call EPOCH_KeyDown}];if (_addCase != _displayCountKD) then {[format['DEH: KeyDown %1/%2',_addCase,_displayCountKD],0] call " + _sknBanANDSleep + ";};_display46 displayRemoveAllEventHandlers 'KeyUp';_addCase = _display46 displayAddEventHandler ['KeyUp',{}];if (_addCase != _displayCount) then {[format['DEH: KeyUp %1/%2',_addCase,_displayCount],0] call " + _sknBanANDSleep + ";};};uiSleep ((random 1)+1);};};_t = _t + '" + _skn_t3 + "';[] spawn {_cntBan = 0;while {true} do {_lastTime = diag_tickTime;_lastPos = getPosATL vehicle player;_notNearbySpawn = _lastPos distance " + str _skn_spawnPointCenter + " > 50;while {alive player} do {_curTime = diag_tickTime;_curPos = getPosATL vehicle player;_distance = _lastPos distance _curPos;if ((_curTime-_lastTime)>1 || _distance>10) then {if (((_distance/(_curTime-_lastTime)) > 10) && _notNearbySpawn && (player == vehicle player)) then {if (isNil '" + _skn_antiTeleportPVC + "') then {[format['[TEST] TP from %1 to %2, %3 meters, now at %4', _lastPos, _curPos, round _distance, getPosATL player],1] call " + _sknBanANDSleep + ";vehicle player setPosATL _lastPos;_cntBan = _cntBan + 1;if (_cntBan > 4) then {};} else {uiSleep 10;_lastPos = getPosATL vehicle player;_lastTime = diag_tickTime;_notNearbySpawn = false;};} else {_lastPos = _curPos;_lastTime = _curTime;_notNearbySpawn = _lastPos distance " + str _skn_spawnPointCenter + " > 50;};};};uiSleep 0.1;};uiSleep 0.25;};_t = _t + '" + _skn_t4 + "';[] spawn {uiNamespace setVariable['ESP_mainMap', nil];uiNamespace setVariable['ESP_adminMap', nil];while {true} do {{_badVar = _x;{_var = _x getVariable _badVar;if(!isNil '_var') then {[format['BadVar %1=%2 (%3)',_badVar,_var,_forEachIndex],0] call " + _sknBanANDSleep + ";_x setVariable [_badVar,nil];};}forEach [missionNamespace, parsingNamespace, uiNamespace];}forEach ['ESP_map','ESP_mainMap','ESP_adminMap','AntiAntiAntiAntiHax','fnc_usec_damageHandler','fnc_usec_unconscious','VAGINA_secret','yolo','VERSION','life_fnc_handleDamage','EPOCH_spawnVehicle_PVS','CLASS911_Menu','nuke_vars','JJMMEE_INIT_MENU','PLAYERON','PLAYERNEXT2','ALTISLIFEON','LY_Menu','PLAY','LY_SwaggerLikeUs','BIS_fnc_dbg_reminder_value','BIS_fnc_dbg_reminder'];" + _skn_fileCheckCode + "{_display = _x select 0;_displayCheckOkay = false;{if ((getText(configFile>>_display>>'onLoad'))==_x) exitWith { _displayCheckOkay = true };}forEach (_x select 1);if (!_displayCheckOkay) then {[format['Changed %1 >> onLoad >> %2', _display, getText(configFile>>_display>>'onLoad')],0] call " + _sknBanANDSleep + ";_displayCheckOkay = false;};{if ((getText(configFile>>_display>>'onUnload'))==_x) exitWith { _displayCheckOkay = true };}forEach (_x select 2);if (!_displayCheckOkay) then {[format['Changed %1 >> onUnload >> %2', _display, getText(configFile>>_display>>'onUnload')],0] call " + _sknBanANDSleep + ";};}forEach " + str _cfg_displayArray + ";uiSleep ((random 10)+10);};};_t = _t + '" + _skn_t5 + "';" + _skn_doTokenAuth + " = [_t,player,Epoch_personalToken];publicVariableServer '" + _skn_doTokenAuth + "';" + _skn_doTokenAuth + " = nil;'" + _skn_kickToLobby + "' addPublicVariableEventHandler {[] spawn {waitUntil {(findDisplay 46) closeDisplay 0; false}}};" + _skn_AH_Code_CB + " = true;true");
call compile(_skn_AH_Ban + " = _skn_code_ban;publicVariable '" + _skn_AH_Ban + "'");
call compile(_skn_AH_Code + " = _skn_code_antihack;publicVariable '" + _skn_AH_Code + "'");
call compile(_skn_AH_Init + " = _skn_code_init;publicVariable '" + _skn_AH_Init + "'");
call compile("" + _skn_pv_adminLog + " = [];" + _skn_pv_hackerLog + " = [];" + _skn_server_adminLog + " = {_toggle = ' -----';if ((_this select 1) != 0) then {_toggle = if ((_this select 1) == 2) then {' -ON-'} else {'-OFF-'};};_adminUID = getPlayerUID _admin;_adminNAME = " + str _skn_adminNAMEArray + " select (" + str _skn_adminUIDArray + " find _adminUID);['aml', format['%1 (%2): [%4] %3',_adminNAME,_adminUID,_this select 0,_toggle]] call EPOCH_server_hiveLog;" + _skn_pv_adminLog + " pushBack [call " + _skn_server_getRealTime + ",_adminNAME,_toggle,_this select 0];diag_log format ['SKN2 AdminRequest %1'," + _skn_pv_adminLog + "];{if (_x call EPOCH_server_isPAdmin) then {(owner _x) publicVariableClient '" + _skn_pv_adminLog + "';};}forEach playableUnits;true};");
call compile("'" + _skn_doAdminLog + "' addPublicVariableEventHandler {_array = _this select 1;diag_log format ['SKN AdminLog %1',_array];_admin = _array select 2;if !([_admin,_array select 3] call EPOCH_server_getPToken) exitWith {};if !(_admin call EPOCH_server_isPAdmin) exitWith {};[_array select 0,_array select 1] call " + _skn_server_adminLog + "};");
call compile("'" + _skn_doAdminRequest + "' addPublicVariableEventHandler {_array = _this select 1;diag_log format ['SKN AdminRequest %1',_array];_admin = _array select 2;if !([_admin,_array select 3] call EPOCH_server_getPToken) exitWith {};if !(_admin call EPOCH_server_isPAdmin) exitWith {};_case = _array select 0;_content = _array select 1;if (_case == 100) then {_playerObj = objectFromNetId _content;[format['Kill Target: %1 (%2)',name _playerObj,getPlayerUID _playerObj],0] call " + _skn_server_adminLog + ";_playerObj setDamage 1;};if (_case == 101) then {_playerObj = objectFromNetId _content;" + _skn_antiTeleportPVC + " = true;(owner _playerObj) publicVariableClient '" + _skn_antiTeleportPVC + "';[format['Teleport To Admin: %1 (%2)', name _playerObj, getPlayerUID _playerObj], 0] call " + _skn_server_adminLog + ";[vehicle _playerObj,_admin] spawn {uiSleep 0.5;(_this select 0) setPos ((_this select 1) modelToWorld [0,1,0]);(_this select 0) setDir (getDir (_this select 1));};};if (_case == 102) then {_playerObj = objectFromNetId _content;_behindM = if (vehicle _playerObj == _playerObj) then [{-1},{-5}];vehicle _admin setPos (_playerObj modelToWorld [0,_behindM,0]);vehicle _admin setDir (getDir _playerObj);[format['Teleport Admin To: %1 (%2)', name _playerObj, getPlayerUID _playerObj], 0] call " + _skn_server_adminLog + ";};if (_case == 103) then {_playerObj = objectFromNetId _content;_playerObj setDamage 0;[['healPlayer'], owner _playerObj] call EPOCH_sendPublicVariableClient;if (_playerObj == _admin) then {['Healed Self',0] call " + _skn_server_adminLog + ";} else {[format['Heal Target: %1 (%2)',name _playerObj,getPlayerUID _playerObj],0] call " + _skn_server_adminLog + ";}};if (_case == 104) then {if ((_content isKindOf 'LandVehicle') || (_content isKindOf 'Air') || (_content isKindOf 'Ship') || (_content isKindOf 'Tank')) then {_content call EPOCH_server_save_killedVehicle;} else {if (typeOf _content in ['LockBoxProxy_EPOCH'] || (_content isKindOf 'Buildable_Storage')) then {_content call EPOCH_server_save_killedStorage;} else {_content call EPOCH_server_save_killedBuilding;};};[format['Delete: %1 at [%2]',typeOf _content, getPos _content],0] call " + _skn_server_adminLog + ";deleteVehicle _content;if (!isNull _content) then {_content setDamage 1;};};if (_case == 106) then {_admin hideObjectGlobal _content;};if (_case == 107) then {_player = objectFromNetId (_content select 0);if (!isNull _player) then {[['effectCrypto', _content select 1], owner _player] call EPOCH_sendPublicVariableClient;if (_player == _admin) then {[format['Give Crypto Myself: %1',_content select 1],0] call " + _skn_server_adminLog + ";} else {[format['Give Crypto to %1 (%2): %3',name _player,getPlayerUID _player,_content select 1],0] call " + _skn_server_adminLog + ";}};};if (_case == 108) then {diag_log format ['Debug-Vehicle: vehicle: 108,%1',_content];if (!isNull _content) then {[format['Repaire Vehicle: %1',typeOf _content],0] call " + _skn_server_adminLog + ";_content setDamage 0;diag_log format ['Debug-Vehicle: Repair: 108,%1',_content];if (local _content) then {_content setFuel 1;} else {[['fillVehicle', [_content, 1]], owner _admin] call EPOCH_sendPublicVariableClient;};_content call EPOCH_server_save_vehicle;};};if (_case == 200) then{_playerObj = objectFromNetId _content;_weaponClass = currentWeapon _playerObj;_mags = getArray(configFile >> 'CfgWeapons' >> _weaponClass >> 'magazines');if !(_mags isEqualTo[]) then{_firstMag = _mags select 0;_magazineSizeMax = getNumber(configFile >> 'CfgMagazines' >> _firstMag >> 'count');_playerObj addMagazine[_firstMag, _magazineSizeMax];if (_playerObj == _admin) then{[format['Gave Ammo (%1) to Self', _firstMag], 0] call " + _skn_server_adminLog + ";} else {[format['Gave Ammo (%3) to Target: %1 (%2)', name _playerObj, getPlayerUID _playerObj, _firstMag], 0] call " + _skn_server_adminLog + ";};};};if (_case == 555) then {_target = objectFromNetId (_content select 1);_itemSpawner = {_nearbyWH = objNull;if (vehicle _target != _target) then{_nearbyWH = vehicle _target;} else {_nearbyWHArr = nearestObjects[_target, ['groundWeaponHolder'], 2];if !(_nearbyWHArr isEqualTo[]) then{_nearbyWH = _nearbyWHArr select 0;} else {_posWH = getposATL _target;_nearbyWH = createVehicle['groundWeaponHolder', _posWH, [], 0, 'CAN_COLLIDE'];_nearbyWH setPosATL _posWH;};};if !(isNull _nearbyWH) then{switch (_this select 1) do {case 1: { _nearbyWH addMagazineCargoGlobal[(_this select 0), 1] };case 2: { _nearbyWH addWeaponCargoGlobal[(_this select 0), 1] };case 3: { _nearbyWH addItemCargoGlobal[(_this select 0), 1] };case 4: { _nearbyWH addBackpackCargoGlobal[(_this select 0), 1] };};};};_permVehicleSpawner = {_item = _this;_return = false;if (_item isKindOf 'Air' || _item isKindOf 'Ship' || _item isKindOf 'LandVehicle') then{if !(EPOCH_VehicleSlots isEqualTo[]) then{_position = getPosATL _target;_slot = EPOCH_VehicleSlots select 0;EPOCH_VehicleSlots = EPOCH_VehicleSlots - [_slot];EPOCH_VehicleSlotCount = count EPOCH_VehicleSlots;publicVariable 'EPOCH_VehicleSlotCount';_vehObj = createVehicle[_item, _position, [], 20, 'NONE'];_return = true;_vehObj call EPOCH_server_setVToken;addToRemainsCollector[_vehObj];_vehObj disableTIEquipment true;clearWeaponCargoGlobal    _vehObj;clearMagazineCargoGlobal  _vehObj;clearBackpackCargoGlobal  _vehObj;clearItemCargoGlobal  _vehObj;_vehObj lock true;_plyrUID = getPlayerUID _target;_plyrGroup = _target getVariable['GROUP', ''];_lockOwner = _plyrUID;if (_plyrGroup != '') then{_lockOwner = _plyrGroup;};_vehObj setVariable['LOCK_OWNER', _lockOwner];_vehObj setVariable['LOCKED_TILL', serverTime + 1800];_config = (configFile >> 'CfgVehicles' >> _item >> 'availableColors');if (isArray(_config)) then{_textureSelectionIndex = configFile >> 'CfgVehicles' >> _item >> 'textureSelectionIndex';_selections = if (isArray(_textureSelectionIndex)) then{getArray(_textureSelectionIndex)} else {[0]};_colors = getArray(_config);_textures = _colors select 0;_color = floor(random(count _textures));_count = (count _colors) - 1;{if (_count >= _forEachIndex) then{_textures = _colors select _forEachIndex;};_vehObj setObjectTextureGlobal[_x, (_textures select _color)];} forEach _selections;_vehObj setVariable['VEHICLE_TEXTURE', _color];};_vehObj setVariable['VEHICLE_SLOT', _slot, true];_vehObj call EPOCH_server_save_vehicle;_vehObj call EPOCH_server_vehicleInit;} else {diag_log 'ADMIN: Unable to spawn vehicle, no slots available';};};_return};_allClasses = [];{_classname = _x select 0;_allClasses pushBack _classname;_type = _x select 1;if (_type == 0) then {_classname call _permVehicleSpawner};if (_type == 1) then {_classname call _permVehicleSpawner};if (_type == 2) then {_classname call _permVehicleSpawner};if (_type == 3) then {[_classname,2] call _itemSpawner};if (_type == 4) then {[_classname,2] call _itemSpawner};if (_type == 5) then {[_classname,2] call _itemSpawner};if (_type == 6) then {[_classname,1] call _itemSpawner};if (_type == 7) then {[_classname,1] call _itemSpawner};if (_type == 8) then {[_classname,4] call _itemSpawner};if (_type == 9) then {[_classname,3] call _itemSpawner};}forEach (_content select 0);if (_target == _admin) then{[format['Spawn: %1',_allClasses], 0] call " + _skn_server_adminLog + ";} else {[format['Spawn Target: %1 (%2) %3', name _target, getPlayerUID _target, _allClasses], 0] call " + _skn_server_adminLog + ";};};if (_case == 666) then {_playerObj = objectFromNetId (_content select 1);_banID = 0;'epochserver' callExtension format['820|%1|" + _skn_banReason + " #%2',getPlayerUID _playerObj,_banID];['amb', format['%1 (%2): %3', name _playerObj, getPlayerUID _playerObj, _content select 0]] call EPOCH_server_hiveLog;};};");
_skn_admincode = compileFinal("comment 'Epoch Mod Antihack - Niklas Wagner - www.skaronator.com - Aaron Clark - www.epochmod.com - License: (CC) Attribution-NonCommercial-NoDerivatives 4.0 International';waitUntil {(getPlayerUID player) != ''};" + _skn_tg_sortOrder + " = 'Range';" + _skn_tg_toggle + " = [];" + _skn_tg_BanPlayer + " = objNull;" + _skn_tg_delete + " = objNull;" + _skn_tg_mapTeleport + " = false;" + _skn_tg_old_esp + " = false;" + _skn_tg_godMode + " = false;" + _skn_tg_old_espMap + " = false;" + _skn_tg_spawnTyp + " = 64;" + _skn_tg_hideAdmin + " = false;" + _skn_tg_infrontTP + " = false;" + _skn_tg_map_player + " = false;" + _skn_tg_map_corpse + " = false;" + _skn_tg_map_loot + " = false;" + _skn_mapLootArray + " = [];" + _skn_tg_map_vehicle + " = false;" + _skn_tg_map_ai + " = false;" + _skn_tg_map_basebuilding + " = false;uiNamespace setVariable['ESP_mainMap', findDisplay 12 displayCtrl 51];uiNamespace setVariable['ESP_adminMap', findDisplay -1337 displayCtrl 7];(findDisplay 46) displayAddEventHandler ['KeyDown','_this call " + _skn_AdminKeyDown + "'];((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ['MouseButtonDown', 'if (_this select 5) then {_this call " + _skn_mapTeleport + "}'];{(uiNamespace getVariable _x) ctrlRemoveAllEventHandlers 'Draw';(uiNamespace getVariable _x) ctrlAddEventHandler['Draw',{_getDmgColor = {_color = [1,1,1,1];_dmg = damage _this;if (_dmg >= 0.25) then {_color = [1,1,0,1];if (_dmg >= 0.5) then {_color = [1,0.55,0,1];if (_dmg >= 0.75) then { _color = [1,0,0,1];if (_dmg >= 0.9) then { _color = [0,0,0,1];};};};};_color};_display = _this select 0;if (" + _skn_tg_map_player + ") then {_size = (0.5/ctrlMapScale _display) max 20;{if (isPlayer _x) then {_display drawIcon [getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'Icon'), _x call _getDmgColor, visiblePosition _x, _size, _size, getDir _x, name _x];};}forEach playableUnits;};if (" + _skn_tg_map_corpse + ") then {_size = (1/ctrlMapScale _display) max 20;{if (!isNull _x) then {_color = [1,1,1,1];_display drawIcon [getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'Icon'), _color, visiblePosition _x, _size, _size, getDir _x, typeOf _x];};}forEach allDeadMen;};if (" + _skn_tg_map_loot + ") then {{if (!isNull _x) then {_color = [1,1,1,1];_display drawRectangle [visiblePosition _x,5,5,getDir _x,[1,1,1,1],'#(rgb,8,8,3)color(1,0,0,1)'];};}forEach " + _skn_mapLootArray + ";};if (" + _skn_tg_map_vehicle + ") then {_size = (1/ctrlMapScale _display) max 20;{if (alive _x) then {_display drawIcon [getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'Icon'), _x call _getDmgColor, visiblePosition _x, _size, _size, getDir _x,getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'displayName')];};}forEach vehicles;};if (" + _skn_tg_map_ai + ") then {_size = (0.5/ctrlMapScale _display) max 20;{if (isPlayer _x) then {_display drawIcon [getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'Icon'), _x call _getDmgColor, visiblePosition _x, _size, _size, getDir _x,getText (configFile >> 'CfgVehicles' >> typeOf _x >> 'displayName')];};}forEach allUnits-playableUnits;};if (" + _skn_tg_map_basebuilding + ") then {};if (" + _skn_tg_old_espMap + ") then {{if !(isNull _x) then{_pos = visiblePosition _x;if (isPlayer _x) then{_lastPos = _x getVariable['ESP_old_MAP', []];_playerGrp = group _x;_grpColorIndex = EPOCH_ESPGROUPS find _playerGrp;if (_grpColorIndex == -1) then{EPOCH_ESPGROUPCOLORS pushBack[random 1, random 1, random 1, 1];_grpColorIndex = EPOCH_ESPGROUPS pushBack _playerGrp;};_color = EPOCH_ESPGROUPCOLORS select _grpColorIndex;(_this select 0) drawIcon[getText(configFile >> 'CfgVehicles' >> typeOf(vehicle _x) >> 'Icon'), _color, _pos, 0.5 / ctrlMapScale(_this select 0), 0.5 / ctrlMapScale(_this select 0), getDir _x, name _x, 1, 0.05, 'PuristaMedium'];if ((count _lastPos) >= 100) then{for '_i' from 10 to 100 step 10 do {_pos1 = _lastPos select(_i - 10);_pos2 = _lastPos select _i;if (!isNil '_pos1' && !isNil '_pos2') then{(_this select 0) drawLine[_pos1, _pos2, [1, 0, 0, 1]];};};};};};}forEach EPOCH_ESPMAP_TARGETS; };}];}forEach ['ESP_mainMap','ESP_adminMap'];" + _skn_adminRequest_PVC + " = {_this pushBack player;_this pushBack Epoch_personalToken;" + _skn_doAdminRequest + " = _this;publicVariableServer '" + _skn_doAdminRequest + "';};" + _skn_adminLog_PVC + " = {_this pushBack player;_this pushBack Epoch_personalToken;" + _skn_doAdminLog + " = _this;publicVariableServer '" + _skn_doAdminLog + "';};" + _skn_AdminKeyDown + " = {_keyDown = _this select 1;if (_keyDown == " + str _skn_adminMenuMenuKey + ") then {call " + _skn_AdminMenu_Init + "};if (_keyDown == 0x3C) then {if (cameraOn != vehicle player) then{ vehicle player switchCamera 'External' } };if (_keyDown == 0x58) then {if (preprocessFileLineNumbers 'skaro.sqf' != '') then {[] spawn compile preprocessFileLineNumbers 'skaro.sqf'}};if (_keyDown == " + str _skn_adminMenuInfrontTeleport + ") then {call " + _skn_infrontTP + "};if (_keyDown == 0x3F) then {call " + _skn_delete + "};};" + _skn_AdminMenu_Init + " = {disableSerialization;_hours = floor(servertime/60/60);_minutes = round((serverTime/60)-(_hours*60));if (!dialog) then {createDialog 'Skaronator_AdminMenu';{(_x call " + _skn_getCtrl + ") ctrlShow false}forEach[40,41,42,43,50,51,52,60,61,62,63,64,65,66,67,68,69,70,71] };if (getPlayerUID player in " + str _skn_blockedSpawnMenuUID + ") then {ctrlEnable [21,false]};ctrlEnable [22,false];(1 call " + _skn_getCtrl + ") ctrlSetText format['Players %1 of %2',count playableUnits,playersNumber civilian];(2 call " + _skn_getCtrl + ") ctrlSetText format['Epoch Mod Admin Menu by Skaronator.com - Server Uptime: %1h %2min', _hours, _minutes];(5 call " + _skn_getCtrl + ") ctrlSetEventHandler ['LBDblClick', '_this call " + _skn_fnc_Spec + "'];(6 call " + _skn_getCtrl + ") ctrlSetEventHandler ['LBDblClick', '_this call " + _skn_dbClickMainMenu + "'];(7 call " + _skn_getCtrl + ") ctrlSetEventHandler ['MouseButtonDown', 'if (_this select 5) then {_this call " + _skn_mapTeleport + "}'];if (call " + _skn_removespawnMenu + ") then {uiSleep 0.4};call " + _skn_Update_AdminButtons + ";_menu = call " + _skn_mainMenuCfg + ";_menu call " + _skn_FillMainMenu + ";call " + _skn_FillPlayerMenu + ";0 call " + _skn_switchMainMenu + ";};" + _skn_hideAdmin + " = {" + _skn_tg_hideAdmin + " = !" + _skn_tg_hideAdmin + ";[106, " + _skn_tg_hideAdmin + "] call " + _skn_adminRequest_PVC + ";};" + _skn_esp + " = {_enable = false;if (_this) then {EPOCH_ESP_PLAYER = !EPOCH_ESP_PLAYER;if (EPOCH_ESP_PLAYER) then {['Player ESP',2] call " + _skn_adminLog_PVC + ";_enable = true} else {['Player ESP',1] call " + _skn_adminLog_PVC + ";}} else {EPOCH_ESP_VEHICLES = !EPOCH_ESP_VEHICLES;if (EPOCH_ESP_VEHICLES) then {['Vehicle ESP',2] call " + _skn_adminLog_PVC + ";_enable = true} else {['Vehicle ESP',1] call " + _skn_adminLog_PVC + ";}};if (EPOCH_ESP_VEHICLEPLAYER isEqualTo [] && _enable) then {waitUntil {EPOCH_ESP_VEHICLEPLAYER = ((getPos cameraOn) nearEntities [['Epoch_Male_F', 'Epoch_Female_F', 'LandVehicle', 'Ship', 'Air', 'Tank'], viewDistance max 1000 min 2500]) - [vehicle player];uiSleep 1;!EPOCH_ESP_PLAYER && !EPOCH_ESP_VEHICLES};EPOCH_ESP_VEHICLEPLAYER = [];};};" + _skn_godMode + " = {" + _skn_tg_godMode + " = !" + _skn_tg_godMode + ";if (" + _skn_tg_godMode + ") then {['God Mod',2] call " + _skn_adminLog_PVC + ";_currentStamina = EPOCH_playerStamina;waitUntil {player setBleedingRemaining 0;player setOxygenRemaining 1;player allowDamage false;{if (_x in ['AliveTime','Stamina']) then {missionNamespace setVariable [format ['EPOCH_player%1',_x],EPOCH_defaultVars select _forEachIndex]}}forEach EPOCH_customVars;EPOCH_playerStamina = _currentStamina;!" + _skn_tg_godMode + "};} else {['God Mod',1] call " + _skn_adminLog_PVC + ";player allowDamage true;}};" + _skn_repairVehicle + " = {systemChat format ['Debug-Vehicle: _this: %1',_this];_veh = objNull;if (_this isEqualTo []) then {if (vehicle player == player) then {_veh = cursorTarget} else {_veh = vehicle player}} else {_player = netId (_this select 1);if (vehicle _player != _player) then {_veh = vehicle _player}};systemChat format ['Debug-Vehicle: _veh: %1',_veh];if (!isNull _veh) then {if ((_veh isKindOf 'LandVehicle') || (_veh isKindOf 'Air') || (_veh isKindOf 'Ship') || (_veh isKindOf 'Tank')) then {[108,_veh] call " + _skn_adminRequest_PVC + ";systemChat format ['Debug-Vehicle: send: 108,%1',_veh];};};};" + _skn_spawnLoot + " = {_lootLoc = getPosASL player;_lootClasses = (configFile >> 'CfgBuildingLootPos') call Bis_fnc_getCfgSubClasses;_lootClasses = _lootClasses - ['Default'];_objects = nearestObjects[_lootLoc, _lootClasses, _this];_cntItem = 0;_cntBuildings = 0;{_building = _x;_pos = getPosATL _building;_config = configFile >> 'CfgBuildingLootPos' >> (typeOf _building);if (isClass(_config)) then {_cntBuildings = _cntBuildings + 1;{_positions = [] + getArray(_config >> (_x select 0));if !(_positions isEqualTo[]) then{_class = _x select 1;_randomColor = _x select 2;{_lootBiasPos = getNumber(_config >> 'lootBiasPos');_lootType = getText(_config >> 'lootType');if ((random 100) < _lootBiasPos) then{_pos = _building modelToWorld(_x select 0);if (nearestObjects[_pos, ['WH_Loot', 'Animated_Loot'], 2] isEqualTo[]) then{_cntItem = _cntItem + 1;if ((typeName _class) == 'ARRAY') then{_class = _class select(floor(random(count _class)));};_dir = (_x select 1) + (getDir _building);if (_dir > 360) then{_dir = _dir - 360;};if (_lootType == 'mil' && _class == 'Bed_EPOCH') then{_class = 'Bunk_EPOCH';};_item = createVehicle[_class, _pos, [], 0.0, 'CAN_COLLIDE'];_item setDir _dir;if (_pos select 2 < 0) then{_pos set[2, 0];};if (surfaceIsWater _pos) then{_item setPosASL _pos;} else {_item setPosATL _pos;};if (_randomColor) then{_colors = [] + getArray(configFile >> 'CfgVehicles' >> _class >> 'availableTextures');if !(_colors isEqualTo[]) then{_color = _colors select floor(random(count _colors));_item setObjectTextureGlobal[0, _color];};};};};}forEach _positions;};}forEach [['shelfPos', 'Shelf_EPOCH', true],['fridgePos', 'Fridge_EPOCH', true],['bedPos', 'Bed_EPOCH', false],['couchPos', 'Couch_EPOCH', false],['wardrobePos', 'wardrobe_epoch', false],['cookerPos', 'cooker_epoch', false],['chairPos', ['Chair_EPOCH', 'ChairRed_EPOCH'], true],['filingPos', 'Filing_epoch', true],['pelicanPos', 'Pelican_EPOCH', false],['tablePos', 'Table_EPOCH', false],['lockerPos', 'Locker_EPOCH', false],['toolRackPos', 'ToolRack_EPOCH', false],['shoeboxPos', 'Shoebox_EPOCH', false],['palletPos', 'Tarp_EPOCH', false],['freezerPos', 'Freezer_EPOCH', false]];};}forEach (nearestObjects[getPosASL player, _lootClasses, _this]);[format['Spawn Loot (%1) for %2 Buildings (%3 Container)',_this,_cntBuildings,_cntItem],0] call " + _skn_adminLog_PVC + ";hint format['Spawned Loot for %1 Buildings (%2 Container)',_cntBuildings,_cntItem];};" + _skn_old_esp + " = {" + _skn_tg_old_esp + " = !" + _skn_tg_old_esp + ";if (" + _skn_tg_old_esp + ") then {['ESP Old',2] call " + _skn_adminLog_PVC + ";waitUntil{EPOCH_ESP_TARGETS = (cameraOn nearEntities[['Epoch_Male_F', 'Epoch_Female_F', 'LandVehicle', 'Ship', 'Air', 'Tank'], 1000]) - [vehicle player];uiSleep 1;!" + _skn_tg_old_esp + "};} else {['ESP Old',1] call " + _skn_adminLog_PVC + ";EPOCH_ESP_TARGETS = [];};};" + _skn_old_espMap + " = {" + _skn_tg_old_espMap + " = !" + _skn_tg_old_espMap + ";if (" + _skn_tg_old_espMap + ") then{['ESP-map Old', 2] call " + _skn_adminLog_PVC + ";waitUntil{uiSleep 1;EPOCH_ESPMAP_TARGETS = (cameraOn nearEntities[['CAManBase', 'LandVehicle', 'Ship', 'Air', 'Tank'], 10000]) - [player, vehicle player];{if (isPlayer _x) then{_pos = visiblePosition _x;_lastPos = _x getVariable['ESP_old_MAP', []];_lastPos pushBack _pos;reverse _lastPos;if (count _lastPos > 101) then{_lastPos resize 101;};reverse _lastPos;_x setVariable['ESP_old_MAP', _lastPos];};}forEach EPOCH_ESPMAP_TARGETS;!" + _skn_tg_old_espMap + "};} else {['ESP-map Old', 1] call " + _skn_adminLog_PVC + ";EPOCH_ESPMAP_TARGETS = [];};};" + _skn_getCtrl + " = compileFinal '(findDisplay -1337) displayCtrl _this';" + _skn_Update_AdminButtons + " = {disableSerialization;{((_x select 0) call " + _skn_getCtrl + ") ctrlSetText (_x select 1)}forEach[[23,format['Hacker Log (%1)',count " + _skn_pv_hackerLog + "]],[24,format['Admin Log (%1)',count " + _skn_pv_adminLog + "]]];};" + _skn_mapTeleport + " = {if (" + _skn_tg_mapTeleport + ") then {_pos = (_this select 0) posScreenToWorld [_this select 2, _this select 3];if (surfaceIsWater _pos) then [{vehicle player setPosASL _pos},{vehicle player setPosATL _pos}];if (!dialog) then {openMap [false, false]};};};" + _skn_deleteMenu + " = [['Delete Menu',true],[format ['%1',typeOf " + _skn_tg_delete + "], [-1], '', -5, [['expression', '']], '1', '0'],['Delete', [2], '', -5, [['expression', '[] spawn " + _skn_deleteNow + "']], '1', '1'],['Exit', [0], '', -5, [['expression', '']], '1', '1']];" + _skn_deleteNow + " = {if (!isNull " + _skn_tg_delete + ") then {if (!isPlayer " + _skn_tg_delete + ") then {[104," + _skn_tg_delete + "] call " + _skn_adminRequest_PVC + ";};};" + _skn_tg_delete + " = objNull;};" + _skn_delete + " = {showCommandingMenu '';if (!isNull cursorTarget) then {" + _skn_tg_delete + " = cursorTarget;showCommandingMenu '#USER:" + _skn_deleteMenu + "';};};" + _skn_fnc_Spec + " = {_player = objectFromNetId (_this select 0 lbData (_this select 1));if (isNull _player) exitWith {};if (!isPlayer _player) exitWith {};cutText ['F2 To Cancel!','PLAIN DOWN',1];vehicle _player switchCamera 'External';};" + _skn_mainMenuCfg + " = {" + _skn_adminMenuLow + "};if (getPlayerUID player in " + str _skn_adminsOwner + ") then {" + _skn_mainMenuCfg + " = {" + _skn_adminMenuOwner + "};};if (getPlayerUID player in " + str _skn_adminsHigh + ") then {" + _skn_mainMenuCfg + " = {" + _skn_adminMenuHigh + "};};" + _skn_freeCam + " = {_getPos = player modelToWorld[0, -1.5, 1.75];_cam = 'camera' camCreate _getPos;_cam setDir([_getPos, player] call BIS_fnc_dirTo);_cam camCommand 'MANUAL ON';_cam camCommand 'INERTIA OFF';_cam cameraEffect['INTERNAL', 'BACK'];showCinemaBorder false;cutText['Right Click To Cancel!', 'PLAIN DOWN', 1];};" + _skn_FillMainMenu + " = {lbClear (8 call " + _skn_getCtrl + ");_ctrl = 6 call " + _skn_getCtrl + ";lbClear _ctrl;for '_i' from 0 to count _menu -1 do {_item = _menu select _i;_titleoption = _item select 3;_color = _item select 4;_index = _ctrl lbAdd format['%1',_item select 0];if (count _color == 0) then {_color = [1, 1, 1, 1];if (_titleoption == '1') then {_color = [0.42,0.64,0.88,1]};if (_titleoption == '3') then {_color = [0.27,0.39,0.53,1]};};if (_titleoption == '2') then {_color = if (_index in " + _skn_tg_toggle + ") then [{[0.17,1,0,1]},{[0.51,0.51,0.51,1]}];};_ctrl lbSetColor [_i,_color];_ctrl lbSetData [_i,str [_item select 1,_item select 2,_titleoption]];};};" + _skn_switchMainMenu + " = {disableSerialization;_main = 6 call " + _skn_getCtrl + ";_map = 7 call " + _skn_getCtrl + ";_table = 8 call " + _skn_getCtrl + ";if (_this == 0) then {_main ctrlSetPosition [0.293698 * safezoneW + safezoneX,0.2888 * safezoneH + safezoneY,0.206297 * safezoneW,0.4862 * safezoneH];_map ctrlSetPosition [0.501031 * safezoneW + safezoneX,0.28836 * safezoneH + safezoneY,0.205265 * safezoneW,0.486548 * safezoneH];_table ctrlShow false;_table ctrlSetPosition [0.293698 * safezoneW + safezoneX,0.2888 * safezoneH + safezoneY,0.206297 * safezoneW,0.4862 * safezoneH];_table ctrlCommit 0;_main ctrlSetFade 0;_map ctrlShow true;};if (_this in [1,2]) then {{(_x call " + _skn_getCtrl + ") ctrlShow false}forEach[30,31,32,33,34];_main ctrlSetPosition [0.293698 * safezoneW + safezoneX,0.2888 * safezoneH + safezoneY,0.412598 * safezoneW,0.4862 * safezoneH];_map ctrlSetPosition [0.709388 * safezoneW + safezoneX,0.28836 * safezoneH + safezoneY,-0.00312413 * safezoneW,0.486548 * safezoneH];_main ctrlSetFade 0;if (_this == 2) then {_main ctrlcommit 0;_main ctrlSetFade 1;};};_main ctrlCommit 0.8;_map ctrlCommit 0.8;};" + _skn_dbClickMainMenu + " = {_currentSelect = _this select 1;_data = call compile (_this select 0 lbData _currentSelect);_tO = _data select 2;if (_tO == '1') exitWith {};if (_tO == '2') exitWith {(_data select 0) spawn (_data select 1);if (_currentSelect in " + _skn_tg_toggle + ") then {lbSetColor [6,_currentSelect,[0.51,0.51,0.51,1]];" + _skn_tg_toggle + " = " + _skn_tg_toggle + " - [_currentSelect];} else {lbSetColor [6,_currentSelect,[0.165,1,0,1]];" + _skn_tg_toggle + " pushBack _currentSelect;};};if (_tO == '4') exitWith {if ((lbCurSel 5) >= 0) then {[_text,lbData [5, lbCurSel 5],(_data select 0)] spawn (_data select 1);};};if (typeName (_data select 1) == 'CODE') then {(_data select 0) spawn (_data select 1)};};Skaronator_fnc_handleButton = compileFinal ('disableSerialization;_idc = ctrlIDC (_this select 0);if (_idc == 10) then { " + _skn_tg_sortOrder + " = ''Range''; call " + _skn_FillPlayerMenu + "};if (_idc == 11) then { " + _skn_tg_sortOrder + " = ''Alphabetically''; call " + _skn_FillPlayerMenu + "};if (_idc == 20) then {call " + _skn_AdminMenu_Init + "};if (_idc == 21) then {call " + _skn_spawnMenu + "};if (_idc == 23) then {call " + _skn_hackerLog + "};if (_idc == 24) then {call " + _skn_adminLog + "};if (_idc == 32) then {true call " + _skn_doBan + "};if (_idc == 33) then {false call " + _skn_doBan + "};if (_idc == 50) then {lbClear 43;" + _skn_tg_limitSpawn + " = [true,true,true,true,true,true,true,true,true,true,true]};if (_idc == 51) then {true call " + _skn_spawnSpawnMenu + "};if (_idc == 52) then {false call " + _skn_spawnSpawnMenu + "};if (_idc in [61,62,63,64,65,66,67,68,69,70,71]) then {" + _skn_tg_spawnTyp + " = _idc;_idc call " + _skn_fillSpawnMenu + ";};');" + _skn_spawnSpawnMenu + " = {_target = objNull;if (_this) then {if ((lbCurSel 5) >= 0) then {_target= objectFromNetId (lbData [5, lbCurSel 5]);};} else {_target= player;};if (isNull _target) exitWith {};_ctrl = 43 call " + _skn_getCtrl + ";_spawn = [];for '_i' from 0 to (lbSize _ctrl)-1 do {_data = call compile (_ctrl lbData _i);_spawn pushBack [_data select 0, _data select 2];};lbClear _ctrl;" + _skn_tg_limitSpawn + " = [true,true,true,true,true,true,true,true,true,true,true];systemChat format['SPAWN %1',_spawn];[555,[_spawn,netId _target]] call " + _skn_adminRequest_PVC + ";};" + _skn_spawnMenu + " = {false call " + _skn_doBan + ";if (!isNull " + _skn_tg_BanPlayer + ") then {uiSleep 0.8;false spawn " + _skn_switchTable + "};2 call " + _skn_switchMainMenu + ";lbclear (6 call " + _skn_getCtrl + ");_table = 8 call " + _skn_getCtrl + ";lbclear _table;_table ctrlShow false;" + _skn_tg_limitSpawn + " = [true,true,true,true,true,true,true,true,true,true,true];comment '[primaryWeapon,secondaryWeapon,launcher,backpack,map,rangefinderSlot,vehicleSlot]';(41 call " + _skn_getCtrl + ") ctrlSetEventHandler ['LBDblClick', "
    "_ctrl = _this select 0;_currentSelect = _this select 1;_type = call compile (_ctrl lbData _currentSelect) select 1;_allowed = true;if (_type != -1) then {_allowed = " + _skn_tg_limitSpawn + " select _type;" + _skn_tg_limitSpawn + " set [_type,false];};systemChat str _type;if (_allowed) then {_otherList = 43 call " + _skn_getCtrl + ";_index = _otherList lbAdd format ['%1',_ctrl lbText _currentSelect];_otherList lbSetData [_index, _ctrl lbData _currentSelect];_otherList lbSetPicture [_index,_ctrl lbPicture _currentSelect];} else {hint 'You can just select one Weapon/Item of this Type!';};"
    "];(43 call " + _skn_getCtrl + ") ctrlSetEventHandler ['LBDblClick', '_ctrl = _this select 0;_currentSelect = _this select 1;_type = call compile (_ctrl lbData _currentSelect) select 1;if (_type != -1) then {" + _skn_tg_limitSpawn + " set [_type,true];};_ctrl lbDelete _currentSelect;'];{_i = _x call " + _skn_getCtrl + ";_i ctrlShow true;_i ctrlSetFade 1;_i ctrlcommit 0;_i ctrlSetFade 0;_i ctrlcommit 0.8}forEach[40,41,42,43,50,51,52,60,61,62,63,64,65,66,67,68,69,70,71];" + _skn_tg_spawnTyp + " call " + _skn_fillSpawnMenu + ";};" + _skn_removespawnMenu + " = {if (ctrlShown (40 call " + _skn_getCtrl + ")) then {{_i = _x call " + _skn_getCtrl + ";_i ctrlShow true;_i ctrlSetFade 1;_i ctrlcommit 0.8}forEach[40,41,42,43,50,51,52,60,61,62,63,64,65,66,67,68,69,70,71];[] spawn {uiSleep 0.8;{_x call " + _skn_getCtrl + " ctrlShow false}forEach[40,41,42,43,50,51,52,60,61,62,63,64,65,66,67,68,69,70,71]};true} else {false};};" + _skn_fillSpawnMenu + " = {_ctrl = 41 call " + _skn_getCtrl + ";lbclear _ctrl;_button = _this call " + _skn_getCtrl + ";_button ctrlSetTextColor [1, 0, 0, 1];{_x call " + _skn_getCtrl + " ctrlSetTextColor [1, 1, 1, 1]}forEach([61,62,63,64,65,66,67,68,69,70,71]-[_this]);if (_this == 61) then {_airVehicles = "
    "getText(_x >> 'displayName') != '' &&getText(_x >> 'picture') != '' &&getNumber(_x >> 'type') != 0 &&getText (_x >> 'vehicleClass') in ['Air']"
    "configClasses (configFile >> 'CfgVehicles');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_ctrl lbSetData[_index, str[configName _x, 6, 0]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _airVehicles;};if (_this == 62) then {_landVehicles = "
    "getText(_x >> 'displayName') != '' &&getText(_x >> 'picture') != '' &&configName _x != 'PaperCar' &&getText (_x >> 'vehicleClass') in ['Car']"
    "configClasses (configFile >> 'CfgVehicles');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_ctrl lbSetData[_index, str[configName _x, 6, 1]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _landVehicles;};if (_this == 63) then {_shipVehicles = "
    "getText(_x >> 'displayName') != '' &&getText(_x >> 'picture') != '' &&getNumber(_x >> 'type') in [1,2,3,4] &&getText (_x >> 'vehicleClass') in ['Ship']"
    "configClasses (configFile >> 'CfgVehicles');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_ctrl lbSetData[_index, str[configName _x, 6, 2]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _shipVehicles;};if (_this == 64) then {_weapons = "
    "getText(_x >> 'displayName') != '' &&getText(_x >> 'picture') != '' &&getNumber(_x >> 'scope') in [0,2] &&getNumber(_x >> 'type') in [1,2,4]"
    "configClasses (configFile >> 'CfgWeapons');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_type = getNumber(_x >> 'type') - 1;if (getNumber(_x >> 'type') == 4) then{ _type = 2 };_ctrl lbSetData[_index, str[configName _x, _type, _type + 3]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _weapons;};if (_this == 65) then {_magazines = "
    "getText(_x >> 'displayName') != '' &&getText(_x >> 'picture') != '' &&getNumber(_x >> 'scope') in [0,2] &&getText(_x >> 'ammo') != ''"
    "configClasses (configFile >> 'CfgMagazines');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_ctrl lbSetData[_index, str[configName _x, -1, 6]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _magazines;};if (_this == 66) then {_magazines = "
    "getText(_x >> 'displayName') != '' &&getText(_x >> 'picture') != '' &&getNumber(_x >> 'scope') in[0, 2] &&getText(_x >> 'ammo') == ''"
    "configClasses(configFile >> 'CfgMagazines');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_ctrl lbSetData[_index, str[configName _x, -1, 7]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _magazines;};if (_this == 67) then {_backpack = "
    "getText(_x >> 'displayName') != '' && getText(_x >> 'picture') != '' &&  getNumber(_x >> 'isbackpack') == 1"
    "configClasses(configFile >> 'CfgVehicles');{if (isClass(configfile >> 'CfgPricing' >> configName _x))then{_index = _ctrl lbAdd format['%1', getText(_x >> 'displayName')];_ctrl lbSetData[_index, str[configName _x, 3, 8]];_ctrl lbSetPicture[_index, getText(_x >> 'picture')];};}forEach _backpack;};if (_this == 68) then{_uniforms = ['U_O_CombatUniform_ocamo','U_O_GhillieSuit','U_O_PilotCoveralls','U_O_Wetsuit','U_OG_Guerilla1_1','U_OG_Guerilla2_1','U_OG_Guerilla2_3','U_OG_Guerilla3_1','U_OG_Guerilla3_2','U_OG_leader','U_C_Poloshirt_stripped','U_C_Poloshirt_blue','U_C_Poloshirt_burgundy','U_C_Poloshirt_tricolour','U_C_Poloshirt_salmon','U_C_Poloshirt_redwhite','U_C_Poor_1','U_C_WorkerCoveralls','U_C_Journalist','U_C_Scientist','U_OrestesBody','U_Wetsuit_uniform','U_Wetsuit_White','U_Wetsuit_Blue','U_Wetsuit_Purp','U_Wetsuit_Camo','U_CamoRed_uniform','U_CamoBrn_uniform','U_CamoBlue_uniform','U_Camo_uniform','U_ghillie1_uniform','U_ghillie2_uniform','U_ghillie3_uniform','U_C_Driver_1','U_C_Driver_2','U_C_Driver_3','U_C_Driver_4','U_C_Driver_1_black','U_C_Driver_1_blue','U_C_Driver_1_green','U_C_Driver_1_red','U_C_Driver_1_white','U_C_Driver_1_yellow','U_C_Driver_1_orange','U_C_Driver_1_red'];{_index = _ctrl lbAdd format['%1', getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];_ctrl lbSetData[_index, str[_x, -1, 9]];_ctrl lbSetPicture[_index, getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];}forEach _uniforms;};if (_this == 69) then{_optics = ['optic_Arco', 'optic_Hamr', 'optic_Aco', 'optic_ACO_grn', 'optic_Aco_smg', 'optic_ACO_grn_smg', 'optic_Holosight', 'optic_Holosight_smg', 'optic_SOS', 'optic_MRCO', 'optic_DMS', 'optic_Yorris', 'optic_MRD', 'optic_LRPS', 'optic_NVS', 'optic_tws', 'optic_tws_mg'];_muzzles = ['muzzle_snds_H','muzzle_snds_L','muzzle_snds_M','muzzle_snds_B','muzzle_snds_H_MG','muzzle_snds_acp','Heal_EPOCH','Defib_EPOCH','Repair_EPOCH','acc_flashlight','acc_pointer_IR'];_misc = ['Binocular','NVG_EPOCH','ItemCompass','ItemGPS','ItemMap','EpochRadio0','EpochRadio1','EpochRadio2','EpochRadio3','EpochRadio4','EpochRadio5','EpochRadio6','EpochRadio7','EpochRadio8','EpochRadio9','ItemWatch'];_attachments = _optics + _muzzles + _misc;{if (isClass(configfile >> 'CfgPricing' >> _x))then{_index = _ctrl lbAdd format['%1', getText(configFile >> 'CfgWeapons' >> _x >> 'displayName')];_ctrl lbSetData[_index, str[_x, -1, 9]];_ctrl lbSetPicture[_index, getText(configFile >> 'CfgWeapons' >> _x >> 'picture')];};}forEach _attachments;};if (_this == 70) then{_headgear = ['wolf_mask_epoch','pkin_mask_epoch'];for '_h' from 1 to 104 do{_headgear pushBack format['H_%1_EPOCH',_h];};{_index = _ctrl lbAdd format['%1', getText(configFile >> 'cfgWeapons' >> _x >> 'displayName')];_ctrl lbSetData[_index, str[_x, -1, 9]];_ctrl lbSetPicture[_index, getText(configFile >> 'cfgWeapons' >> _x >> 'picture')];}forEach _headgear;};if (_this == 71) then{_vests = [];for '_v' from 1 to 40 do{_vests pushBack format['V_%1_EPOCH', _v];};{_index = _ctrl lbAdd format['%1', getText(configFile >> 'cfgWeapons' >> _x >> 'displayName')];_ctrl lbSetData[_index, str[_x, -1, 9]];_ctrl lbSetPicture[_index, getText(configFile >> 'cfgWeapons' >> _x >> 'picture')];}forEach _vests;};};" + _skn_FillPlayerMenu + " = {_ctrl = 5 call " + _skn_getCtrl + ";lbclear _ctrl;_sorted = [];_unsorted = playableUnits;_buttonRange = 10 call " + _skn_getCtrl + ";_buttonRange ctrlSetText 'Range';_buttonAlphabetically = 11 call " + _skn_getCtrl + ";_buttonAlphabetically ctrlSetText 'Alphabet';if (" + _skn_tg_sortOrder + " == 'Range') then {_pos = getPosATL vehicle player;{_temp = _x;{if ((getPosATL _x distance _pos) < (getPosATL _temp distance _pos)) exitWith {_unsorted = _unsorted - [_x];_sorted pushBack _x;_temp = _x;};}forEach _unsorted;}forEach _unsorted;_buttonRange ctrlSetTextColor [1, 0, 0, 1];_buttonAlphabetically ctrlSetTextColor [1, 1, 1, 1];};if (" + _skn_tg_sortOrder + " == 'Alphabetically') then {_unsortedName = [];{_unsortedName pushBack (name _x);}forEach _unsorted;_alphabetically = _unsortedName call BIS_fnc_sortAlphabetically;{{if (name _x == (_alphabetically select 0)) exitWith {_alphabetically = _alphabetically - [_alphabetically select 0];_unsorted = _unsorted - [_x];_sorted pushBack _x;};}forEach _unsorted;}forEach _unsorted;_buttonAlphabetically ctrlSetTextColor [1, 0, 0, 1];_buttonRange ctrlSetTextColor [1, 1, 1, 1];};if (_sorted isEqualTo []) then {_sorted = [player]};_skn_fnc_addPlayerToList = {_player = _this select 0;_index = _ctrl lbAdd format ['%1', name _player];_ctrl lbSetData [_index, netId _player];_ctrl lbSetColor [_index, _this select 1];if (vehicle _player == _player) then {_pic = '';if (currentWeapon _player != '') then {_pic = getText(configFile >> 'CfgWeapons' >> currentweapon _player >> 'picture')} else {if (primaryWeapon _player == '') then {_pic = getText(configFile >> 'CfgVehicles' >> typeof vehicle _player >> 'picture')} else {_pic = getText(configFile >> 'CfgWeapons' >> primaryweapon _player >> 'picture')};};_ctrl lbSetPicture [_index,_pic];} else {_ctrl lbSetPicture [_index,getText(configFile >> 'CfgVehicles' >> typeof vehicle _player >> 'picture')];};};_ctrl lbAdd '      Admins';_ctrl lbSetColor [(lbsize _ctrl)-1, [0,0.6,1,1]];{if (getPlayerUID _x in " + str _skn_adminUIDArray + ") then {_sorted = _sorted - [_x];[_x,[0,1,0,1]] call _skn_fnc_addPlayerToList};}forEach _sorted;_ctrl lbAdd '';_ctrl lbAdd '      Normal Player';_ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];{if (vehicle _x == _x) then {_sorted = _sorted - [_x];[_x,[0,1,0,1]] call _skn_fnc_addPlayerToList};}forEach _sorted;_ctrl lbAdd '';_ctrl lbAdd '      Vehicle Player';_ctrl lbSetColor [(lbsize _ctrl)-1, [1,1,1,1]];{[_x,[0,1,0,1]] call _skn_fnc_addPlayerToList}forEach _sorted;_ctrl lbAdd '';_ctrl lbAdd '';};" + _skn_switchTable + " = {disableSerialization;_map = 7 call " + _skn_getCtrl + ";_table = 8 call " + _skn_getCtrl + ";if ((ctrlPosition _table) isEqualTo [0.293698 * safezoneW + safezoneX,0.2888 * safezoneH + safezoneY,0.206297 * safezoneW,0.4862 * safezoneH]) then {_table ctrlSetPosition [0.293698 * safezoneW + safezoneX,0.2888 * safezoneH + safezoneY,0.206297 * safezoneW,0.4862 * safezoneH];_table ctrlCommit 0;_table ctrlSetEventHandler ['LBSelChanged', 'if ((_this select 1) != -1) then {lnbSetCurSelRow [8,-1]};'];_table ctrlShow _this;_table ctrlSetPosition [0.293698 * safezoneW + safezoneX,0.2888 * safezoneH + safezoneY,0.412598 * safezoneW,0.4862 * safezoneH];_table ctrlCommit 0.8;};_time = diag_tickTime;waitUntil {if (diag_tickTime-_time>1) exitWith {true};if ((ctrlPosition _map) isEqualTo [0.709388 * safezoneW + safezoneX,0.28836 * safezoneH + safezoneY,-0.00312413 * safezoneW,0.486548 * safezoneH]) exitWith {_map ctrlShow false;true};};};" + _skn_hackerLog + " = {1 call " + _skn_switchMainMenu + ";lbClear (6 call " + _skn_getCtrl + ");_table = 8 call " + _skn_getCtrl + ";lbClear _table;true spawn " + _skn_switchTable + ";if (call " + _skn_removespawnMenu + ") then {uiSleep 0.4;_table ctrlSetFade 1;_table ctrlcommit 0;_table ctrlSetFade 0;_table ctrlcommit 0.8;};_table ctrlShow true;_table lnbAddRow ['==================================== HACKER LOG ======================================'];{_player = _x select 0;_color = _x select 1;_index = _table lnbAddRow [_player select 1,_player select 2,nil,if (_player select 0 == 0) then [{format['BANNED: %1',_player select 4]},{_player select 4}]];if (count _color > 0) then {lnbSetColor [8,[_index,0],_color];lnbSetColor [8,[_index,1],_color];lnbSetColor [8,[_index,3],_color];};}forEach " + _skn_pv_hackerLog + ";};" + _skn_adminLog + " = {1 call " + _skn_switchMainMenu + ";lbClear (6 call " + _skn_getCtrl + ");_table = 8 call " + _skn_getCtrl + ";lbClear _table;true spawn " + _skn_switchTable + ";if (call " + _skn_removespawnMenu + ") then {uiSleep 0.4;_table ctrlSetFade 1;_table ctrlcommit 0;_table ctrlSetFade 0;_table ctrlcommit 0.8;};_table ctrlShow true;_table lnbAddRow ['===================================== ADMIN LOG ======================================'];{_table lnbAddRow _x}forEach " + _skn_pv_adminLog + ";};" + _skn_flipVehicle + " = {_target = cursorTarget;if (isNull _target) then {_vehicles = (getPosATL player) nearEntities[['LandVehicle', 'Ship', 'Air'], 15];if !(_vehicles isEqualTo []) then {_target = _vehicles select 0;};};if (!isNull _target) then {if (!isPlayer _target) then {_target setVectorUp [0, 0, 1];cutText [format ['Unflipping Vehicle..'],'PLAIN DOWN'];};};};" + _skn_infrontTP + " = {" + _skn_tg_infrontTP + " = !" + _skn_tg_infrontTP + ";if (" + _skn_tg_infrontTP + ") then {_distance = 10;_object = vehicle player;_dir = getdir _object;_pos = getPosATL _object;if (_object isKindOf 'Air') then {_distance = 50;_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),((getpos _object) select 2)+100];} else {_pos = [(_pos select 0)+_distance*sin(_dir),(_pos select 1)+_distance*cos(_dir),0];if (surfaceIsWater _pos) then {_pos set [2,2]};};if (surfaceIsWater _pos) then [{vehicle player setPosASL _pos},{vehicle player setPosATL _pos}];};};" + _skn_customBanreason + " = {disableSerialization;_player = objectFromNetId (_this select 1);_name = name _player;{(_x call " + _skn_getCtrl + ") ctrlShow true}forEach[30,31,32,33,34];_edit = 31 call " + _skn_getCtrl + ";_edit ctrlSetText '';if (typename (_this select 2) == 'STRING') then {_edit ctrlSetText format['%1',(_this select 2)];};_text = 34 call " + _skn_getCtrl + ";_text ctrlSetText format ['Custom Banreason for %1:',_name];" + _skn_tg_BanPlayer + " = _player;findDisplay -1337 displayAddEventHandler ['Unload', {" + _skn_tg_BanPlayer + " = objNull}];_map = 7 call " + _skn_getCtrl + ";_map ctrlSetPosition [0.501031 * safezoneW + safezoneX,0.44456 * safezoneH + safezoneY,0.205265 * safezoneW,0.328148 * safezoneH];_map ctrlCommit 0.8;};" + _skn_doBan + " = {disableSerialization;if (_this && !isNull " + _skn_tg_BanPlayer + ") then {_reason = ctrlText 31;if (_reason == '') then {ctrlSetText [31, 'Please enter a banreason!'];} else {[666,[_reason,netId " + _skn_tg_BanPlayer + "]] call " + _skn_adminRequest_PVC + ";};};{_i = _x call " + _skn_getCtrl + ";_i ctrlShow false;_i ctrlShow true}forEach[32,33];" + _skn_tg_BanPlayer + " = objNull;_map = 7 call " + _skn_getCtrl + ";_map ctrlSetPosition [0.501031 * safezoneW + safezoneX,0.28836 * safezoneH + safezoneY,0.205265 * safezoneW,0.486548 * safezoneH];_map ctrlCommit 0.8;};");
_skn_admininit = compileFinal("waitUntil {(!isNil '" + _skn_Admin_Code + "') && (!isNil '" + _skn_pv_adminLog + "') && (!isNil '" + _skn_pv_hackerLog + "')};[] spawn " + _skn_Admin_Code + "");
call compile(_skn_Admin_Code + " = _skn_admincode");
call compile(_skn_Admin_Init + " = _skn_admininit;publicVariable '" + _skn_Admin_Init + "'");