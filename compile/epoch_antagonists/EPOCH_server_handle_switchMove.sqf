_target = _this select 0;
if !([_target, _this select 2] call EPOCH_server_getPToken) exitWith {};
_range = 0;
_move = "";
switch (_this select 1) do {
    case 1:
        {
            _range = 1000;
            _move = "AovrPercMrunSrasWrflDf";
        };
    case 2:
        {
            _range = 1000;
            _move = "epoch_unarmed_jump";
        };
};
if (_range > 0 && _move != "") then {
    _nearBy = (getPosATL _target) nearEntities[["Epoch_Male_F", "Epoch_Female_F"], _range]; {
        [
            ["switchMove", [_target, _move]], (owner _x)
        ] call EPOCH_sendPublicVariableClient;
    }
    forEach(_nearBy - [_target]);
};