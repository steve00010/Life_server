_startTime = diag_tickTime;
Epoch_ServerVersion = getText(configFile >> "CfgMods" >> "Epoch" >> "version");
EPOCH_SERVER = [];
diag_log format["Epoch: Starting ArmA3 Epoch Server, Version %1", Epoch_ServerVersion];
_abortAndError = {
    publicVariable "EPOCH_SERVER";
    EPOCH_BADHIVE = true;
    publicVariable "EPOCH_BADHIVE";
    for "_i"
    from 0 to 15 do {
        diag_log _this;
    };
};
_clientVersion = getText(configFile >> "CfgServerVersion" >> "client");
_configVersion = getText(configFile >> "CfgServerVersion" >> "config");
_hiveVersion = getText(configFile >> "CfgServerVersion" >> "hive");
if (_clientVersion != Epoch_ServerVersion) exitWith {
    format["Epoch: Version mismatch! Current: %2 Needed: %1", _clientVersion, Epoch_ServerVersion] call _abortAndError;
};
if (_configVersion != getText(configFile >> "CfgPatches" >> "A3_server_settings" >> "epochVersion")) exitWith {
    format["Epoch: Config file needs updated! Current: %1 Needed: %2", _configVersion, getText(configFile >> "CfgPatches" >> "A3_server_settings" >> "epochVersion")] call _abortAndError;
};
if (("epochserver"
        callExtension "") != _hiveVersion) exitWith {
    format["Epoch: Server DLL mismatch! Current: %1 Needed: %2", "epochserver"
        callExtension "", _hiveVersion] call _abortAndError;
};
_serverConfig = call compile("epochserver"
    callExtension "000");
EPOCH_fn_InstanceID = compileFinal(str(_serverConfig select 0));
_instanceID = call EPOCH_fn_InstanceID;
if (isNil "_instanceID") exitWith {
    "Epoch: InstanceID missing!"
    call _abortAndError;
};
diag_log "Epoch: Init Variables";
call compile preprocessFileLineNumbers "\x\addons\a3_epoch_server\init\server_variables.sqf";
call compile preprocessFileLineNumbers "\x\addons\a3_epoch_server\init\server_securityfunctions.sqf";
["I", _instanceID, "86400", "CONTINUE"] call EPOCH_server_hiveSETEX;
diag_log format["Epoch: Start Hive, Instance ID: '%1'", _instanceID];
call EPOCH_server_publicEH;
diag_log "Epoch: Init PublicEH";
addMissionEventHandler["HandleDisconnect", {
    _this call EPOCH_server_onPlayerDisconnect
}];
onPlayerDisconnected {
    diag_log format["playerDisconnected:%1:%2", _uid, _name];
    ['Disconnected', format["playerConnected:%1:%2", _uid, _name]] call EPOCH_server_hiveLog;
    _uid call EPOCH_server_disconnect;
};
onPlayerConnected {
    diag_log format["playerConnected:%1:%2", _uid, _name];
    ['Connected', format["playerConnected:%1:%2", _uid, _name]] call EPOCH_server_hiveLog;
};
diag_log "Epoch: Setup Side Settings";
_SideHQ1 = createCenter resistance;
_SideHQ2 = createCenter east;
_SideHQ3 = createCenter west;
RESISTANCE setFriend[WEST, 0];
WEST setFriend[RESISTANCE, 0];
RESISTANCE setFriend[EAST, 0];
EAST setFriend[RESISTANCE, 0];
EAST setFriend[WEST, 1];
WEST setFriend[EAST, 1];
diag_log format["Epoch: Setup World Settings for %1", worldName];
_worldSize = 12000;
_epochWorldPath = configfile >> "CfgEpoch" >> worldName;
if (isClass _epochWorldPath && isNumber(_epochWorldPath >> "worldSize")) then {
    _worldSize = getNumber(_epochWorldPath >> "worldSize");
};
epoch_centerMarkerPosition = getMarkerPos "center";
if (epoch_centerMarkerPosition isEqualTo[0, 0, 0]) then {
    diag_log "Epoch: Error cannot find center marker!";
};
EPOCH_dynamicVehicleArea = _worldSize / 2;
diag_log "Epoch: Set Weather";
true call EPOCH_server_setWeather;
EPOCH_customChannels = [];
for "_i"
from 0 to 9 do {
    _radio = configfile >> "CfgWeapons" >> format["EpochRadio%1", _i];
    _channelTXT = getText(_radio >> "displayName");
    _channelColor = getArray(_radio >> "channelColor");
    _index = radioChannelCreate[_channelColor, _channelTXT, "%UNIT_NAME", []];
    EPOCH_customChannels pushBack _index;
};
_startTime spawn {
    diag_log "Epoch: Loading buildings";
    _workload1 = EPOCH_BuildingSlotsLimit spawn EPOCH_server_loadBuildings;
    waitUntil {
        scriptDone _workload1
    };
    diag_log "Epoch: Loading teleports and static props";
    _workload8 = [] spawn EPOCH_server_createTeleport;
    waitUntil {
        scriptDone _workload8
    };
    diag_log "Epoch: Loading NPC traders";
    _workload4 = EPOCH_NPCSlotsLimit spawn EPOCH_server_loadTraders;
    waitUntil {
        scriptDone _workload4
    };
    diag_log "Epoch: Spawning NPC traders";
    _workload5 = [] spawn EPOCH_server_spawnTraders;
    waitUntil {
        scriptDone _workload5
    };
    diag_log "Epoch: Loading vehicles";
    _workload2 = EPOCH_VehicleSlotsLimit spawn EPOCH_load_vehicles;
    waitUntil {
        scriptDone _workload2
    };
    diag_log "Epoch: Spawning vehicles";
    _workload3 = [] spawn EPOCH_spawn_vehicles;
    waitUntil {
        scriptDone _workload3
    };
    diag_log "Epoch: Loading storage";
    _workload6 = EPOCH_StorageSlotsLimit spawn EPOCH_load_storage;
    waitUntil {
        scriptDone _workload6
    };
    diag_log "Epoch: Loading static loot";
    _workload9 = [] spawn EPOCH_server_spawnBoatLoot;
    waitUntil {
        scriptDone _workload9
    };
    [] spawn EPOCH_server_masterLoop;
    [] execFSM "\x\addons\a3_epoch_server\system\server_monitor.fsm";
    _dateChanged = false;
    _date = date;
    if (EPOCH_StaticDateTime isEqualto[]) then {
        _response = "epochserver"
        callExtension "510";
        if (_response != "") then {
            diag_log format["Epoch: Set Real Time: %1", _response];
            _date = call compile _response;
            _date resize 5;
            _date set[0, (_date select 0) + 21];
            _date set[3, (_date select 3) + EPOCH_timeDifference];
            diag_log format["Epoch: Set Ingame Time: %1", _date];
            _dateChanged = true;
        };
    } else {
        {
            if (_x != 0) then {
                _date set[_forEachIndex, _x];
                _dateChanged = true;
            };
        }
        forEach EPOCH_StaticDateTime;
    };
    if (_dateChanged) then {
        setDate _date;
    };
    setTimeMultiplier EPOCH_timeMultiplier;
    if (isNil "EPOCH_taxRate") then {
        EPOCH_taxRate = 0.1;
    };
    publicVariable "EPOCH_taxRate";
    if !(EPOCH_SERVER isEqualTo[]) then {
        publicVariable "EPOCH_SERVER";
    };
    publicVariable "Epoch_ServerVersion";
    diag_log format["Epoch: Server Start Complete: %1 seconds", diag_tickTime - _this];
    if (_dateChanged) then {
        uiSleep 60;
        _date set[4, (_date select 4) + 1];
        setDate _date;
    };
};