_this addMPEventHandler["MPKilled", {
    (_this select 0) call EPOCH_server_save_killedVehicle
}];
_this addEventHandler["Dammaged", {
    if !((_this select 0) in EPOCH_saveVehQueue) then {
        EPOCH_saveVehQueue pushBack(_this select 0)
    }
}];
_this addEventHandler["Local", {
    if !((_this select 0) in EPOCH_saveVehQueue) then {
        EPOCH_saveVehQueue pushBack(_this select 0)
    }
}];
_this addEventHandler["GetOut", {
    if !((_this select 0) in EPOCH_saveVehQueue) then {
        EPOCH_saveVehQueue pushBack(_this select 0)
    }
}];