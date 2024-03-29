"EPOCH_SAVEBUILD"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_saveBuilding
};
"EPOCH_UPBUILD"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_upgradeBUILD
};
"EPOCH_PAINTBUILD"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_paintBUILD
};
"EPOCH_MAINTBUILD"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_maintBUILD
};
"EPOCH_loadPlayer_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_loadPlayer
};
"EPOCH_S_S_VEHICLES"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_save_vehicles
};
"EPOCH_pushPlayer_PVS"
addPublicVariableEventHandler {
    if ([_this select 1 select 0, _this select 1 select 2] call EPOCH_server_getPToken) then {
        (_this select 1) call EPOCH_server_savePlayer
    }
};
"EPOCH_deadPlayer_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_deadPlayer
};
"EPOCH_destroyTrash"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_destroyTrash
};
"EPOCH_knockDownTree"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_knockDownTree
};
"EPOCH_lootAnimal"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_lootAnimal
};
"EPOCH_say3D_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_handle_say3D
};
"EPOCH_switchMove_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_handle_switchMove
};
"EPOCH_GROUP_Upgrade_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_upgradeGroup
};
"EPOCH_GROUP_Player_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_updatePlayerGroup
};
"EPOCH_GROUP_create_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_createGroup
};
"EPOCH_GROUP_Delete_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_deleteGroup
};
"EPOCH_GROUP_Invite_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_invitePlayer
};
"EPOCH_lootContainer"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_lootContainer
};
"EPOCH_revivePlayer_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_revivePlayer
};
"EPOCH_buildItem_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_buildItem
};
"EPOCH_storeCrypto_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_storeCrypto
};
"EPOCH_MAKETRADEREQ"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_tradeRequest
};
"EPOCH_MAKETRADE"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_makeTrade
};
"EPOCH_MAKENPCTRADE"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_makeNPCTrade
};
"EPOCH_repairVehicle_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_repairVehicle
};
"EPOCH_fillVehicle_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_fillVehicle
};
"EPOCH_lockVehicle_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_lockVehicle
};
"EPOCH_equippedItem_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_equippedItem
};
"EPOCH_lockStorage_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_lockStorage
};
"EPOCH_packStorage_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_packStorage
};
"EPOCH_packJack_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_packJack
};
"EPOCH_TEMPOBJ_PVS"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_localCleanup
};
"EPOCH_oneWayTP"
addPublicVariableEventHandler {
    (_this select 1) call EPOCH_server_teleportPlayer
};